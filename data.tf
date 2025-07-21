/*
data "github_actions_secrets" "webapp" {
  full_name = "balajipothula/webapp"
}
*/

# Data Source: aws_region
data "aws_region" "current" {}

# Data Source: aws_caller_identity
data "aws_caller_identity" "current" {}

# Data Source: aws_partition
data "aws_partition" "current" {}

# Data Source: aws_vpc
data "aws_vpc" "default" {
  default = true
}

# Data Source: aws_internet_gateway - first IGW in the VPC.
data "aws_internet_gateway" "default" {
  filter {
    name   = "attachment.vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# Data Source: aws_route_tables - all route tables in the VPC.
data "aws_route_tables" "all" {
  vpc_id = data.aws_vpc.default.id
}

# Data Source: aws_availability_zones
data "aws_availability_zones" "available" {

  all_availability_zones = true
  state                  = "available"

  filter {
    name   = "zone-type"
    values = ["availability-zone"]
  }

}

# Data Source: aws_subnets
# Fetch subnet IDs in default VPC
data "aws_subnets" "available" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# Data Source: aws_security_groups
data "aws_security_groups" "default" {

  filter {
    name   = "group-name"
    values = ["default"]
  }

  filter {
    name   = "description"
    values = ["default VPC security group"]
  }

}

/*
data "aws_ami" "default" {

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "name"
    values = ["amzn-ami-hvm-*-x86_64-gp2"]
  }

  most_recent = "true"
  owners      = ["amazon"]

}
*/


# Archive Lambda Function source code.
data "archive_file" "webapp" {
  type        = "zip"
  source_file = local.webapp_src
  output_path = "./${local.webapp_zip}"
}



locals {
  timestamp  = timestamp()
  yyyymmdd   = formatdate("YYYY/MM/DD",          local.timestamp)   
  datetime   = formatdate("YYYY-MM-DD-HH-mm-ss", local.timestamp)
  layer_zip  = "./python/lib/layer.zip"
  webapp_src = "./python/src/lambda_function.py"
  webapp_zip = "webapp-${local.datetime}.zip"
}



# WebApp Lambda Python Source S3 Bucket IAM Policy Document. 
data "aws_iam_policy_document" "webapp_lambda_src_s3_bucket_policy" {

  statement {
    sid = "WebAppLambdaSrcS3BucketPolicy"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["${data.aws_caller_identity.current.arn}"]
    }
    actions = [
      "s3:GetObject"
    ]
    resources = [
      "arn:aws:s3:::${var.webapp_lambda_src_s3_bucket_name}/*"
    ]
  }

}



# 📄 IAM Trust Policy for WebApp Lambda to Assume the Role ⛑️.
data "aws_iam_policy_document" "webapp_lambda_iam_role" {

  statement {
    sid = "WebAppLambdaIAMRolePolicy"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }

}



# 📄 WebApp Lambda Monitoring IAM Policy 🔐.
data "aws_iam_policy_document" "webapp_lambda_monitoring_policy" {
  statement {
    sid = "WebAppLambdaMonitoringPolicy"
    effect = "Allow"

    actions = [
      "cloudformation:DescribeStacks",
      "cloudformation:ListStackResources",
      "cloudwatch:ListMetrics",
      "cloudwatch:GetMetricData",
      "cloudwatch:PutMetricData",
      "cloudwatch:PutMetricStream",
      "ec2:DeleteNetworkInterface",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeSubnets",
      "ec2:DescribeVpcs",
      "ec2:CreateNetworkInterface",
      "kms:ListAliases",
      "iam:GetPolicy",
      "iam:GetPolicyVersion",
      "iam:GetRole",
      "iam:GetRolePolicy",
      "iam:ListAttachedRolePolicies",
      "iam:ListRolePolicies",
      "iam:ListRoles",
      "lambda:*",
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:DescribeLogGroups",
      "logs:PutLogEvents",
      "secretsmanager:GetSecretValue",
      "states:DescribeStateMachine",
      "states:ListStateMachines",
      "tag:GetResources",
      "xray:GetTraceSummaries",
      "xray:BatchGetTraces"
    ]

    resources = ["*"]
  }

  statement {
    effect = "Allow"

    actions = ["iam:PassRole"]
    resources = ["*"]

    condition {
      test     = "StringEquals"
      variable = "iam:PassedToService"

      values = ["lambda.amazonaws.com"]
    }
  }

  statement {
    effect = "Allow"

    actions = [
      "logs:DescribeLogStreams",
      "logs:GetLogEvents",
      "logs:FilterLogEvents"
    ]

    resources = ["arn:aws:logs:*:*:log-group:/aws/lambda/*"]
  }
}

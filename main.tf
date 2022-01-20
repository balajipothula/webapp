provider "aws" {

  region     = var.region
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"

}

# Data Source: aws_region
data "aws_region" "current" {
}

# Data Source: aws_vpc
data "aws_vpc" "default" {
}

# Data Source: aws_subnet_ids
data "aws_subnet_ids" "available" {
  vpc_id = data.aws_vpc.default.id
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

#  WebApp AWS S3 Bucket Creation Module.
module "webapp_aws_s3_bucket" {

  source = "./terraform/aws/s3/bucket"

  bucket = "webapp-aws-s3-bucket"                # Optional argument but keep it.
  acl    = "private"                             # Optional argument but keep it.
  policy = file("./json/WebAppS3IAMPolicy.json") # Optional argument but keep it.

  tags   = {                                     # Optional argument but keep it.
    "AppName"        = "WebAppFastAPI"
    "Division"       = "Platform"
    "DeveloperName"  = "Balaji Pothula"
    "DeveloperEmail" = "balan.pothula@gmail.com"
  }

}

#  WebApp AWS IAM Role Creation Module.
module "webapp_aws_iam_role" {

  source                = "./terraform/aws/iam/role"

  assume_role_policy    = file("./json/WebAppLambdaIAMRole.json") # Required argument.
  description           = "AWS IAM Role for WebApp Lambda."       # Optional argument but keep it.
  force_detach_policies = true                                    # Optional argument but keep it.
  name                  = "WebAppLambdaIAMRole"                   # Optional argument but keep it.

}

#  WebApp AWS IAM Policy Creation Module.
module "webapp_aws_iam_policy" {

  source      = "./terraform/aws/iam/policy"

  description = "AWS IAM Policy for WebApp Lambda."       # Optional argument but keep it.
  name        = "WebAppLambdaIAMPolicy"                   # Optional argument but keep it.
  path        = "/"                                       # Optional argument but keep it.
  policy      = file("./json/WebAppLambdaIAMPolicy.json") # Required argument.

}

#  WebApp AWS IAM Role Policy Attachment Module.
module "webapp_aws_iam_role_policy_attachment" {

  source      = "./terraform/aws/iam/role_policy_attachment"

  depends_on = [
    module.webapp_aws_iam_role,
    module.webapp_aws_iam_policy,
  ]

  role       = module.webapp_aws_iam_role.name  # Required argument.
  policy_arn = module.webapp_aws_iam_policy.arn # Required argument.

}

#  WebApp AWS Lambda Function Creation Module.
module "webapp_aws_lambda_function" {

  source                         = "./terraform/aws/lambda/function"

  depends_on                     = [
    module.webapp_aws_iam_role_policy_attachment,
  ]

  function_name                  = "webapp"                                          # Required argument.
  role                           = module.webapp_aws_iam_role.arn                    # Required argument.
  description                    = "WebApp Lambda Function."                         # Optional argument but keep it.
  handler                        = "lambda_function.lambda_handler"                  # Optional argument but keep it.
  memory_size                    = 128                                               # Optional argument but keep it.
  package_type                   = "Zip"                                             # Optional argument but keep it.
  publish                        = false                                             # Optional argument but keep it.
  reserved_concurrent_executions = -1                                                # Optional argument but keep it.
  runtime                        = "python3.8"                                       # Optional argument but keep it.
  s3_bucket                      = "job-log-s3-bucket"                               # Optional argument but keep it.
  s3_key                         = "v1.0.3/job-log.zip"                              # Optional argument but keep it, Conflicts with filename and image_uri.
  tags                           = {                                                 # Optional argument but keep it.
    "AppName"        = "WebAppFastAPI"
    "Division"       = "Platform"
    "DeveloperName"  = "Balaji Pothula"
    "DeveloperEmail" = "balan.pothula@gmail.com"
  }
  timeout                        = 30                                                # Optional argument but keep it.

}

#  WebApp AWS CloudWatch Log Group Creation Module.
module "webapp_aws_cloudwatch_log_group" {

  source             = "./terraform/aws/cloudwatch/log_group"

  name               = "/aws/lambda/${module.webapp_aws_lambda_function.function_name}" # Optional argument but keep it.
  retention_in_days  = 14                                                               # Optional argument but keep it.
  tags               = {                                                                # Optional argument but keep it.
    "AppName"        = "WebAppFastAPI"
    "Division"       = "Platform"
    "DeveloperName"  = "Balaji Pothula"
    "DeveloperEmail" = "balan.pothula@gmail.com"
  }

}

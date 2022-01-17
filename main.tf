provider "aws" {

  region     = var.region

  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"

//shared_credentials_file = "/home/balaji/.aws/config"
//profile                 = "terraform"

/*
  assume_role {
    role_arn = "arn:aws:iam::123456789012:role/terraform"
  }
*/

//allowed_account_ids   = ["123456789012"]
//forbidden_account_ids = ["123456789013"]

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

resource "aws_cloudwatch_log_group" "webapp_lambda_log_group" {
  name = "/aws/lambda/${var.function_name}"
//name_prefix       = ""
/*Possible values are: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, 3653
  If retention_in_days is 0, the events in the log group are always retained and never expire.
*/
  retention_in_days = 14
  tags = {
    Environment = "Dev"
    Application = "WebApp"
  }
}

resource "aws_iam_role" "webapp_lambda_role" {
  assume_role_policy    = file("./WebAppLambdaRole.json")
  description           = "Role policy for WebApp Lambda Function."
  force_detach_policies = false 
  name                  = "WebAppLambdaRole"
}

# See also the following AWS managed policy: AWSLambdaBasicExecutionRole
resource "aws_iam_policy" "webapp_lambda_policy" {
  name        = "WebAppLambdaPolicy"
  path        = "/"
  description = "IAM policy for WebApp Lambda Function."
  policy      = file("./WebAppLambdaPolicy.json")
}

######
resource "aws_iam_role_policy_attachment" "webapp_lambda_policy_attachment" {

  depends_on = [
    module.aws_iam_role_webapp,
    aws_iam_role.webapp_lambda_role,
    aws_iam_policy.webapp_lambda_policy
  ]

  role       = "WebAppLambdaRole"
  policy_arn = aws_iam_policy.webapp_lambda_policy.arn
}

module "aws_iam_role_webapp" {
  source  = "./terraform/aws/iam/role"
}

module "aws_lambda_function_webapp" {

  source  = "./terraform/aws/lambda/function"

  depends_on = [
    aws_iam_role_policy_attachment.webapp_lambda_policy_attachment,
    aws_cloudwatch_log_group.webapp_lambda_log_group
  ]

  function_name                  = var.function_name                    # Required argument.
  role                           = var.role                             # Required argument.
//architectures                  = var.architectures                    # Optional argument.
//code_signing_config_arn        = var.code_signing_config_arn          # Optional argument.
/*
  dead_letter_config {                                                  # Optional argument block.
    target_arn                   = var.target_arn                       # Required block argument.
  }
*/
  description                    = var.description                      # Optional argument but keep it.
/*
  file_system_config {                                                  # Optional argument block.
    arn                          = var.efs_arn                          # Required block argument.
    local_mount_path             = var.local_mount_path                 # Required block argument.
  }
*/
//filename                       = var.filename                         # Optional argument, Conflicts with image_uri, s3_bucket, s3_key, and s3_object_version.
  handler                        = var.handler                          # Optional argument but keep it.
/*
  image_config {                                                        # Optional argument block.
    command                      = var.command                          # Optional block argument.
    entry_point                  = var.entry_point                      # Optional block argument.
    working_directory            = var.working_directory                # Optional block argument.
  }
*/
//image_uri                      = var.image_uri                        # Conflicts with filename, s3_bucket, s3_key, and s3_object_version.
//kms_key_arn                    = var.kms_key_arn                      # Optional argument.
//layers                         = var.layers                           # Optional argument.
  memory_size                    = var.memory_size                      # Optional argument but keep it.
  package_type                   = var.package_type                     # Optional argument but keep it.
  publish                        = var.publish                          # Optional argument but keep it.
  reserved_concurrent_executions = var.reserved_concurrent_executions   # Optional argument but keep it.
  runtime                        = var.runtime                          # Optional argument but keep it.
  s3_bucket                      = var.s3_bucket                        # Optional argument but keep it.
  s3_key                         = var.s3_key                           # Optional argument but keep it, Conflicts with filename and image_uri.
//s3_object_version              = var.s3_object_version                # Optional argument, Conflicts with filename and image_uri.
//source_code_hash               = var.source_code_hash                 # Optional argument.
  tags                           = var.tags                             # Optional argument but keep it.
  timeout                        = var.timeout                          # Optional argument but keep it.
/*
  tracing_config {                                                      # Optional argument block.
    mode                         = var.mode                             # Required block argument.
  }
*/

}

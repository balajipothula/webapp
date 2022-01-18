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
  name = "/aws/lambda/WebAppFastAPI"
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

# See also the following AWS managed policy: AWSLambdaBasicExecutionRole
resource "aws_iam_policy" "webapp_lambda_policy" {
  name        = "WebAppLambdaPolicy"
  path        = "/"
  description = "IAM policy for WebApp Lambda Function."
  policy      = file("./WebAppLambdaPolicy.json")
}

resource "aws_iam_role_policy_attachment" "webapp_lambda_policy_attachment" {

  depends_on = [
    module.aws_iam_role_webapp,
    aws_iam_policy.webapp_lambda_policy
  ]

  role       = module.aws_iam_role_webapp.name
  policy_arn = aws_iam_policy.webapp_lambda_policy.arn

}

module "aws_iam_role_webapp" {

  source                = "./terraform/aws/iam/role"

  description           = "AWS IAM Role for WebApp." # Optional argument but keep it.
  force_detach_policies = true                       # Optional argument but keep it.
  name                  = "WebAppLambdaRole"         # Optional argument but keep it.

}

module "webapp_aws_lambda_function" {

  source                         = "./terraform/aws/lambda/function"

  depends_on                     = [
    aws_iam_role_policy_attachment.webapp_lambda_policy_attachment,
  ]

  function_name                  = "WebAppFastAPI"                                   # Required argument.
  role                           = "arn:aws:iam::304501768659:role/WebAppLambdaRole" # Required argument.
  description                    = "Web App FastAPI Lambda Function."                # Optional argument but keep it.
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

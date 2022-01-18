provider "aws" {

  region     = var.region
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"

}

module "webapp_aws_iam_role" {

  source                = "./terraform/aws/iam/role"

  description           = "AWS IAM Role for WebApp." # Optional argument but keep it.
  force_detach_policies = true                       # Optional argument but keep it.
  name                  = "WebAppRole"         # Optional argument but keep it.

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
    module.webapp_aws_iam_role,
    aws_iam_policy.webapp_lambda_policy
  ]

  role       = module.webapp_aws_iam_role.name
  policy_arn = aws_iam_policy.webapp_lambda_policy.arn

}

module "webapp_aws_lambda_function" {

  source                         = "./terraform/aws/lambda/function"

  depends_on                     = [
    aws_iam_role_policy_attachment.webapp_lambda_policy_attachment,
  ]

  function_name                  = "WebAppFastAPI"                                   # Required argument.
  role                           = "arn:aws:iam::304501768659:role/WebAppRole" # Required argument.
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

resource "aws_cloudwatch_log_group" "webapp_lambda_log_group" {
  name = "/aws/lambda/${module.webapp_aws_lambda_function.function_name}"
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

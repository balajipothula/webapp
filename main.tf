provider "aws" {

  region     = var.region
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"

}

module "webapp_aws_iam_role" {

  source                = "./terraform/aws/iam/role"

  assume_role_policy    = file("./json/WebAppLambdaIAMRole.json") # Required argument.
  description           = "AWS IAM Role for WebApp Lambda."       # Optional argument but keep it.
  force_detach_policies = true                                    # Optional argument but keep it.
  name                  = "WebAppLambdaIAMRole"                   # Optional argument but keep it.

}

module "webapp_aws_iam_policy" {

  source      = "./terraform/aws/iam/policy"

  description = "AWS IAM Policy for WebApp Lambda."       # Optional argument but keep it.
  name        = "WebAppLambdaIAMPolicy"                   # Optional argument but keep it.
  path        = "/"                                       # Optional argument but keep it.
  policy      = file("./json/WebAppLambdaIAMPolicy.json") # Required argument.

}

module "webapp_aws_iam_role_policy_attachment" {

  source      = "./terraform/aws/iam/role_policy_attachment"

  depends_on = [
    module.webapp_aws_iam_role,
    module.webapp_aws_iam_policy,
  ]

  role       = module.webapp_aws_iam_role.name  # Required argument.
  policy_arn = module.webapp_aws_iam_policy.arn # Required argument.

}

module "webapp_aws_lambda_function" {

  source                         = "./terraform/aws/lambda/function"

  depends_on                     = [
    module.webapp_aws_iam_role_policy_attachment,
  ]

  function_name                  = "WebApp"                                          # Required argument.
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

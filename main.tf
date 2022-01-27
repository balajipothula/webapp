provider "aws" {

  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key

}

# Data Source: aws_region
data "aws_region" "current" {
}

# Data Source: aws_vpc
data "aws_vpc" "default" {
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

# Archive Lambda Function source code.
data "archive_file" "webapp" {
  type        = "zip"
  source_file = local.python_src
  output_path = "./${local.webapp_zip}"
}

locals {
  timestamp  = timestamp()
  yyyymmdd   = formatdate("YYYY/MM/DD",          local.timestamp)   
  datetime   = formatdate("YYYY-MM-DD-hh-mm-ss", local.timestamp)
  layer_zip  = "./python/lib/layer.zip"
  python_src = "./python/src/lambda_function.py"
  webapp_zip = "webapp-${local.datetime}.zip"
}

#  WebApp AWS IAM Role creation.
module "webapp_aws_iam_role" {

  source                = "./terraform/aws/iam/role"

  assume_role_policy    = file("./json/WebAppLambdaIAMRole.json") # Required argument.
  description           = "AWS IAM Role for WebApp Lambda."       # Optional argument but keep it.
  force_detach_policies = true                                    # Optional argument but keep it.
  name                  = "WebAppLambdaIAMRole"                   # Optional argument but keep it.

}

#  WebApp AWS IAM Policy creation.
module "webapp_aws_iam_policy" {

  source      = "./terraform/aws/iam/policy"

  description = "AWS IAM Policy for WebApp Lambda."       # Optional argument but keep it.
  name        = "WebAppLambdaIAMPolicy"                   # Optional argument but keep it.
  path        = "/"                                       # Optional argument but keep it.
  policy      = file("./json/WebAppLambdaIAMPolicy.json") # Required argument.

}

#  WebApp AWS IAM Role Policy Attachment Module.
module "webapp_aws_iam_role_policy_attachment" {

  source     = "./terraform/aws/iam/role_policy_attachment"

  depends_on = [
    module.webapp_aws_iam_role,
    module.webapp_aws_iam_policy,
  ]

  role       = module.webapp_aws_iam_role.name  # Required argument.
  policy_arn = module.webapp_aws_iam_policy.arn # Required argument.

}

#  WebApp AWS S3 Bucket creation.
module "webapp_aws_s3_bucket" {

  source = "./terraform/aws/s3/bucket"

  bucket = "webapp-aws-s3-bucket"                # Optional argument but keep it.
  acl    = "private"                             # Optional argument but keep it.
  policy = file("./json/WebAppS3IAMPolicy.json") # Optional argument but keep it.
  tags   = {                                     # Optional argument but keep it.
    "AppName" = "WebApp"
  }

}

#  WebApp AWS S3 Bucket Object creation.
module "webapp_aws_s3_bucket_object" {

  source     = "./terraform/aws/s3/bucket_object"

  depends_on = [
    module.webapp_aws_s3_bucket,
  ]

  bucket      = module.webapp_aws_s3_bucket.id                # Required argument.
  key         = "/${local.yyyymmdd}/${local.webapp_zip}"      # Required argument.
  acl         = "private"                                     # Optional argument but keep it.
  etag        = filemd5(data.archive_file.webapp.output_path) # Optional argument but keep it.
  source_code = data.archive_file.webapp.output_path          # Optional argument but keep it.
  tags        = {                                             # Optional argument but keep it.
    "AppName" = "WebApp"
  }

}

#  WebApp AWS Lambda Layer Version creation.
module "webapp_aws_lambda_layer_version" {

  source                   = "./terraform/aws/lambda/layer_version"

  layer_name               = "webapp"                          # Required argument.
  compatible_architectures = ["arm64", "x86_64"]               # Optional argument, but keep it.
  compatible_runtimes      = ["python3.8"]                     # Optional argument, but keep it.
  description              = "Python Library."                 # Optional argument, but keep it.
  filename                 = local.layer_zip                   # Optional argument, conflicts with s3_bucket, s3_key and s3_object_version.
  license_info             = "Apache License 2.0"              # Optional argument, but keep it.
//s3_bucket                = var.s3_bucket                     # Optional argument, conflicts with filename.
//s3_key                   = var.s3_key                        # Optional argument, conflicts with filename.
//s3_object_version        = var.s3_object_version             # Optional argument, conflicts with filename.
  source_code_hash         = filebase64sha256(local.layer_zip) # Optional argument, but keep it.

}

#  WebApp AWS Lambda Function creation.
module "webapp_aws_lambda_function" {

  source                         = "./terraform/aws/lambda/function"

  depends_on                     = [
    module.webapp_aws_s3_bucket,
    module.webapp_aws_s3_bucket_object,
    module.webapp_aws_iam_role_policy_attachment,
    module.webapp_aws_lambda_layer_version,
  ]

  function_name                  = "webapp"                                     # Required argument.
  role                           = module.webapp_aws_iam_role.arn               # Required argument.
  description                    = "WebApp Lambda Function."                    # Optional argument but keep it.
  handler                        = "lambda_function.lambda_handler"             # Optional argument but keep it.
  layers                         = [module.webapp_aws_lambda_layer_version.arn] # Optional argument but keep it.
  memory_size                    = 128                                          # Optional argument but keep it.
  package_type                   = "Zip"                                        # Optional argument but keep it.
  publish                        = false                                        # Optional argument but keep it.
  reserved_concurrent_executions = -1                                           # Optional argument but keep it.
  runtime                        = "python3.8"                                  # Optional argument but keep it.
  s3_bucket                      = module.webapp_aws_s3_bucket.id               # Optional argument but keep it.
  s3_key                         = "${local.yyyymmdd}/${local.webapp_zip}"      # Optional argument but keep it, Conflicts with filename and image_uri.
  tags                           = {                                            # Optional argument but keep it.
    "AppName" = "WebAppFastAPI"
  }
  timeout                        = 30                                           # Optional argument but keep it.

}

#  WebApp AWS CloudWatch Log Group creation.
module "webapp_aws_cloudwatch_log_group" {

  source             = "./terraform/aws/cloudwatch/log_group"

  depends_on = [
    module.webapp_aws_lambda_function,
  ]

  name               = "/aws/lambda/${module.webapp_aws_lambda_function.function_name}" # Optional argument but keep it.
  retention_in_days  = 14                                                               # Optional argument but keep it.
  tags               = {                                                                # Optional argument but keep it.
    "AppName"        = "WebAppFastAPI"
  }

}

# WebApp AWS API Gateway V2 API Module.
module "webapp_aws_apigatewayv2_api" {

  source        = "./terraform/aws/apigatewayv2/api"

  name          = "webapp" # Required argument.
  protocol_type = "HTTP"   # Required argument.

}

# WebApp AWS API Gateway V2 Stage Module.
module "webapp_aws_apigatewayv2_stage" {

  source        = "./terraform/aws/apigatewayv2/stage"

  depends_on = [
    module.webapp_aws_apigatewayv2_api,
  ]

  api_id = module.webapp_aws_apigatewayv2_api.id                 # Required argument.
  name              = "$default"                                 # Required argument.
  auto_deploy       = true                                       # Optional argument, but keep it.

}

# WebApp AWS API Gateway V2 Integration Module.
module "webapp_aws_apigatewayv2_integration" {

  source             = "./terraform/aws/apigatewayv2/integration"

  depends_on         = [
    module.webapp_aws_lambda_function,
    module.webapp_aws_apigatewayv2_api,
  ]

  api_id             = module.webapp_aws_apigatewayv2_api.id
  integration_type   = "AWS_PROXY"
  integration_uri    = module.webapp_aws_lambda_function.arn
  integration_method = "POST"

}

# WebApp AWS API Gateway V2 Route Module.
module "webapp_aws_apigatewayv2_route" {

  source        = "./terraform/aws/apigatewayv2/route"

  depends_on    = [
    module.webapp_aws_apigatewayv2_api,
    module.webapp_aws_apigatewayv2_integration,
  ]

  api_id        = module.webapp_aws_apigatewayv2_api.id                           # Required argument.
  route_key     = "GET /"                                                         # Required argument.
  target        = "integrations/${module.webapp_aws_apigatewayv2_integration.id}" # Optional argument, but keep it.

}

# WebApp AWS Lambda Permission Module.
module "webapp_aws_lambda_permission" {

  source        = "./terraform/aws/lambda/permission"

  depends_on    = [
    module.webapp_aws_lambda_function,
    module.webapp_aws_apigatewayv2_api,
  ]

  action        = "lambda:InvokeFunction"                                   # Required argument.
  function_name = module.webapp_aws_lambda_function.function_name           # Required argument.
  principal     = "apigateway.amazonaws.com"                                # Required argument.
  statement_id  = "AllowExecutionFromAPIGateway"                            # Optional argument.
  source_arn    = "${module.webapp_aws_apigatewayv2_api.execution_arn}/*/*" # Optional argument.

}

# WebApp AWS RDS Cluster creation.
module "webapp_aws_rds_cluster" {

  source                       = "./terraform/aws/rds/cluster"

  allow_major_version_upgrade  = true                                   # Optional argument but keep it.
  apply_immediately            = true                                   # Optional argument but keep it.
  backup_retention_period      = 1                                      # Optional argument but keep it.
  cluster_identifier           = "webapp"                               # Optional argument but keep it.
  copy_tags_to_snapshot        = true                                   # Optional argument but keep it.
  database_name                = "webapp_db"                            # Optional argument but keep it.
  deletion_protection          = false                                  # Optional argument but keep.
  enable_http_endpoint         = true                                   # Optional argument but keep it.
  engine                       = "aurora-postgresql"                    # Optional argument but keep it.
  engine_mode                  = "serverless"                           # Optional argument but keep it.
  engine_version               = "10.14"                                # Optional argument but keep it.
  final_snapshot_identifier    = "webapp-snapshot-at-${local.datetime}" # Optional argument but keep it.
//master_password              = "WebApp#2022"                          # Required argument.
//master_username              = "webapp"                               # Required argument.
  master_password              = var.master_password                    # Required argument.
  master_username              = var.master_username                    # Required argument.
  port                         = "5432"                                 # Optional argument but keep it.
  preferred_backup_window      = "00:00-00:59"                          # Optional argument but keep it.
  preferred_maintenance_window = "sun:01:00-sun:02:00"                  # Optional argument but keep it.
  skip_final_snapshot          = true                                   # Optional argument but keep it.
  storage_encrypted            = true                                   # Optional argument but keep it.
  tags                         = {                                      # Optional argument but keep it.
    "AppName"           = "WebAppFastAPI"
    "Developer"         = "Balaji Pothula"
  }

}

# terraform provider information.
provider "aws" {

  default_tags {
    tags = {
      DeveloperName  = "Balaji Pothula"
      DeveloperEmail = "balan.pothula@gmail.com"
    }
  }    

  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key

}



# Creation of WebApp Lambda Function AWS IAM Role.
module "webapp_lambda_aws_iam_role" {

  source                = "./terraform/aws/iam/role"

  assume_role_policy    = data.aws_iam_policy_document.webapp_lambda_iam_role.json  # 🔒 Required argument.
  description           = "AWS IAM Role for WebApp Lambda."                         # ✅ Optional argument — recommended to keep.
  force_detach_policies = true                                                      # ✅ Optional argument — recommended to keep.
  name                  = "WebAppLambdaIAMRole"                                     # ✅ Optional argument — recommended to keep.

}



# Creation of WebApp Lambda Function CloudWatch Monitoring AWS IAM Policy.
module "webapp_lambda_monitoring_iam_policy" {

  source      = "./terraform/aws/iam/policy"

  description = "WebApp Lambda Function CloudWatch Monitoring IAM Policy."        # ✅ Optional argument, but keep it, ❗ Forces new resource.
//name_prefix = "dev-webapp"                                                      # ✅ Optional argument — conflicts with `name`, keep it commented, ❗ Forces new resource.
  name        = "WebAppLambdaMonitoringIAMPolicy"                                 # ✅ Optional argument — conflicts with `name_prefix`, ❗ Forces new resource. 
  path        = "/"                                                               # ✅ Optional argument, but keep it.
  policy      = data.aws_iam_policy_document.webapp_lambda_monitoring_policy.json # 🔒 Required argument.
  tags   = {                                                                      # ✅ Optional argument — recommended to keep.
    "Name"            = "WebApp"
    "AppName"         = "Python FastAPI Web App"
  }

}



# Attachment of WebApp Lambda IAM Role and  CloudWatch Monitoring IAM Policy to WebApp Lambda Function.
module "webapp_lambda_aws_iam_role_policy_attachment" {

  source     = "./terraform/aws/iam/role_policy_attachment"

  depends_on = [
    module.webapp_lambda_aws_iam_role,
    module.webapp_lambda_monitoring_iam_policy,
  ]

  name       = "webapp-lambda-iam-role-and-policy-attachment" # 🔒 Required argument — ❗ Forces new resource.
  policy_arn = module.webapp_lambda_monitoring_iam_policy.arn # 🔒 Required argument.
  users      = null                                           # ✅ Optional argument.
  roles      = [module.webapp_lambda_aws_iam_role.name]       # ✅ Optional argument.
  groups     = null                                           # ✅ Optional argument.

}



# Creation of AWS S3 Bucket for WebApp Lambda Function Python Source.
module "webapp_lambda_src_s3_bucket" {

  source = "./terraform/aws/s3/bucket"

  bucket              = var.webapp_lambda_src_s3_bucket_name # ✅ Optional argument, but keep it, ❗ Forces new resource.
//bucket_prefix       = var.bucket_prefix                    # ✅ Optional argument, ❗ Forces new resource.
  force_destroy       = false                                # ✅ Optional argument, but keep it.
  object_lock_enabled = false                                # ✅ Optional argument, ❗ Forces new resource.
  tags   = {                                                 # ✅ Optional argument — recommended to keep.
    "Name"            = "WebApp"
    "AppName"         = "Python FastAPI Web App"
  }

}



module "webapp_lambda_src_s3_bucket_policy" {

  source = "./terraform/aws/s3/bucket_policy"

  depends_on  = [
    module.webapp_lambda_src_s3_bucket,
  ]

  bucket = module.webapp_lambda_src_s3_bucket.id                                # 🔒 Required argument.
  policy = data.aws_iam_policy_document.webapp_lambda_src_s3_bucket_policy.json # 🔒 Required argument

}



# Creation of AWS S3 Object for WebApp Lambda Function Python Source.
module "webapp_lambda_src_s3_object" {

  source      = "./terraform/aws/s3/object"

  depends_on  = [
    module.webapp_lambda_src_s3_bucket,
  ]

  bucket                         = module.webapp_lambda_src_s3_bucket.id         # 🔒 Required argument.
  key                            = "${local.yyyymmdd}/${local.webapp_zip}"       # 🔒 Required argument.
  acl                            = "private"                                     # ✅ Optional argument.
  bucket_key_enabled             = false                                         # ✅ Optional argument.
  cache_control                  = null                                          # ✅ Optional argument.
//checksum_algorithm             = null                                          # ✅ Optional argument, but keep it commented.
//content_base64                 = null                                          # ✅ Optional argument, 🤜💥🤛 conflicts with `content` and `source`, so keep it commented.
  content_disposition            = null                                          # ✅ Optional argument.
  content_encoding               = null                                          # ✅ Optional argument.
  content_language               = "en-US"                                       # ✅ Optional argument.
  content_type                   = null                                          # ✅ Optional argument.
//content                        = null                                          # ✅ Optional argument, 🤜💥🤛 conflicts with `content_base64` and `source`, keep it commented.
  etag                           = filemd5(data.archive_file.webapp.output_path) # ✅ Optional argument.
  force_destroy                  = false                                         # ✅ Optional argument.
  kms_key_id                     = null                                          # ✅ Optional argument.
  metadata                       = null                                          # ✅ Optional argument.
//object_lock_legal_hold_status  = null                                          # ✅ Optional argument, but keep it commented.
//object_lock_mode               = null                                          # ✅ Optional argument, but keep it commented.
  object_lock_retain_until_date  = null                                          # ✅ Optional argument.
//override_provider              = null                                          # ✅ Optional argument, but keep it commented.
//server_side_encryption         = null                                          # ✅ Optional argument, but keep it commented.
  source_hash                    = null                                          # ✅ Optional argument.
  source_path                    = data.archive_file.webapp.output_path          # ✅ Optional argument, 🤜💥🤛 conflicts with `content_base64` and `content`
  storage_class                  = "STANDARD"                                    # ✅ Optional argument.
  tags                           = {                                             # ✅ Optional argument — recommended to keep.
    "Name"            = "WebApp"
    "AppName"         = "Python FastAPI Web App"
  }
  website_redirect               = null                                          # ✅ Optional argument.

}




# Creation of AWS Lambda Layer Version for WebApp Lambda Function.
module "webapp_aws_lambda_layer_version" {

  source                   = "./terraform/aws/lambda/layer_version"

  layer_name               = "webapp-lambda-layer"              # 🔒 Required argument.
  compatible_architectures = ["arm64", "x86_64"]                # ✅ Optional argument — recommended to keep.
  compatible_runtimes      = ["python3.11"]                     # ✅ Optional argument — recommended to keep.
  description              = "Python Lib — FastAPI, SQLAlchemy" # ✅ Optional argument — recommended to keep.
  filename                 = local.layer_zip                    # ✅ Optional argument, 🤜💥🤛 conflicts with `s3_bucket`, `s3_key` and `s3_object_version`.
  license_info             = "Apache License 2.0"               # ✅ Optional argument — recommended to keep.
//s3_bucket                = var.s3_bucket                      # ✅ Optional argument, 🤜💥🤛 conflicts with `filename`, keep it commented.
//s3_key                   = var.s3_key                         # ✅ Optional argument, 🤜💥🤛 conflicts with `filename`, keep it commented.
//s3_object_version        = var.s3_object_version              # ✅ Optional argument, 🤜💥🤛 conflicts with `filename`, keep it commented.
  source_code_hash         = filebase64sha256(local.layer_zip)  # ✅ Optional argument — recommended to keep.

}



# Creation of AWS Lambda Function for WebApp.
module "webapp_aws_lambda_function" {

  source                         = "./terraform/aws/lambda/function"

  depends_on                     = [
    module.webapp_lambda_aws_iam_role,
    module.webapp_db_aws_secretsmanager_secret,
    module.webapp_lambda_src_s3_bucket,
    module.webapp_lambda_src_s3_object,
  ]

  function_name                  = "webapp-lambda-function"                     # 🔒 Required argument, ❗ Forces new resource.
  role                           = module.webapp_lambda_aws_iam_role.arn        # 🔒 Required argument.
  description                    = "WebApp Lambda Function"                     # ✅ Optional argument — recommended to keep.
  environment_variables          = {                                            # ✅ Optional argument — recommended to keep.
    region = data.aws_region.current.name,
    secret = module.webapp_db_aws_secretsmanager_secret.name,
  }
  handler                        = "lambda_function.lambda_handler"             # ✅ Optional argument — recommended to keep.
  layers                         = [module.webapp_aws_lambda_layer_version.arn] # ✅ Optional argument — recommended to keep.
  memory_size                    = 128                                          # ✅ Optional argument — recommended to keep.
  package_type                   = "Zip"                                        # ✅ Optional argument — recommended to keep.
  publish                        = false                                        # ✅ Optional argument — recommended to keep.
  reserved_concurrent_executions = -1                                           # ✅ Optional argument — recommended to keep.
  runtime                        = "python3.11"                                 # ✅ Optional argument — recommended to keep.
  s3_bucket                      = module.webapp_lambda_src_s3_bucket.id        # ✅ Optional argument — recommended to keep.
  s3_key                         = "${local.yyyymmdd}/${local.webapp_zip}"     # ✅ Optional argument, 🤜💥🤛 conflicts with `filename` and `image_uri`.
  tags                           = {                                            # ✅ Optional argument — recommended to keep.
    "Name"            = "webapp"
    "AppName"         = "Python FastAPI Web Application"
  }
  timeout                        = 120                                          # ✅ Optional argument — recommended to keep.

}



# Creation of AWS CloudWatch Log Group for WebApp Lambda Function.
module "webapp_lambda_aws_cloudwatch_log_group" {

  source            = "./terraform/aws/cloudwatch/log_group"

  depends_on        = [
    module.webapp_aws_lambda_function,
  ]

  name              = "/aws/lambda/${module.webapp_aws_lambda_function.function_name}" # ✅ Optional argument — recommended to keep.
  retention_in_days = 1                                                                # ✅ Optional argument — recommended to keep.
  tags              = {                                                                # ✅ Optional argument — recommended to keep.
    "Name"            = "WebApp"
    "AppName"         = "Python FastAPI Web App"
  }

}



# Creation of AWS API Gateway V2 API for WebApp Lambda Function.
module "webapp_lambda_aws_apigatewayv2_api" {

  source        = "./terraform/aws/apigatewayv2/api"

  name          = "webapp-lambda-api-gateway" # 🔒 Required argument.
  protocol_type = "HTTP"                      # 🔒 Required argument.

}



# Creation of AWS API Gateway V2 Stage for WebApp Lambda Function.
module "webapp_lambda_aws_apigatewayv2_stage" {

  source      = "./terraform/aws/apigatewayv2/stage"

  depends_on  = [
    module.webapp_lambda_aws_apigatewayv2_api,
  ]

  api_id      = module.webapp_lambda_aws_apigatewayv2_api.id # 🔒 Required argument.
  name        = "$default"                                   # 🔒 Required argument.
  auto_deploy = true                                         # ✅ Optional argument — recommended to keep.

}



# Creation of AWS API Gateway V2 Integration for WebApp Lambda Function.
module "webapp_lambda_aws_apigatewayv2_integration" {

  source             = "./terraform/aws/apigatewayv2/integration"

  depends_on         = [
    module.webapp_aws_lambda_function,
    module.webapp_lambda_aws_apigatewayv2_api,
  ]

  api_id             = module.webapp_lambda_aws_apigatewayv2_api.id # 🔒 Required argument.
  integration_type   = "AWS_PROXY"                                  # 🔒 Required argument.
  integration_uri    = module.webapp_aws_lambda_function.arn        # ✅ Optional argument — recommended to keep.
  integration_method = "ANY"                                        # ✅ Optional argument — recommended to keep.

}



# Creation of AWS Lambda Permission to invoke WebApp Lambda Function by AWS API Gateway V2.
module "webapp_aws_lambda_permission" {

  source        = "./terraform/aws/lambda/permission"

  depends_on    = [
    module.webapp_aws_lambda_function,
    module.webapp_lambda_aws_apigatewayv2_api,
  ]

  action        = "lambda:InvokeFunction"                                          # 🔒 Required argument.
  function_name = module.webapp_aws_lambda_function.function_name                  # 🔒 Required argument, ❗ Forces new resource.
  principal     = "apigateway.amazonaws.com"                                       # 🔒 Required argument.
  statement_id  = "AllowExecutionFromAPIGateway"                                   # ✅ Optional argument — recommended to keep.
  source_arn    = "${module.webapp_lambda_aws_apigatewayv2_api.execution_arn}/*/*" # 🐞 Optional argument — recommended to keep. 📝 "╱*╱*"

}



# Creation of AWS API Gateway V2 Route for WebApp Lambda Function 🛣️ GET / 🛣️ Route.
module "webapp_lambda_aws_apigatewayv2_route_index" {

  source        = "./terraform/aws/apigatewayv2/route"

  depends_on    = [
    module.webapp_lambda_aws_apigatewayv2_api,
    module.webapp_lambda_aws_apigatewayv2_integration,
  ]

  api_id        = module.webapp_lambda_aws_apigatewayv2_api.id                           # 🔒 Required argument.
  route_key     = "GET /"                                                                # 🔒 Required argument.
  target        = "integrations/${module.webapp_lambda_aws_apigatewayv2_integration.id}" # ✅ Optional argument — recommended to keep.

}



# Creation of AWS API Gateway V2 Route for WebApp Lambda Function 🛣️ PUT /insert/song 🛣️ Route.
module "webapp_lambda_aws_apigatewayv2_route_put_song" {

  source        = "./terraform/aws/apigatewayv2/route"

  depends_on    = [
    module.webapp_lambda_aws_apigatewayv2_api,
    module.webapp_lambda_aws_apigatewayv2_integration,
  ]

  api_id        = module.webapp_lambda_aws_apigatewayv2_api.id                           # 🔒 Required argument.
  route_key     = "PUT /insert/song"                                                     # 🔒 Required argument.
  target        = "integrations/${module.webapp_lambda_aws_apigatewayv2_integration.id}" # ✅ Optional argument — recommended to keep.

}



# Creation of AWS API Gateway V2 Route for WebApp Lambda Function 🛣️ GET /select/songs 🛣️ Route.
module "webapp_lambda_aws_apigatewayv2_route_get_songs" {

  source        = "./terraform/aws/apigatewayv2/route"

  depends_on    = [
    module.webapp_lambda_aws_apigatewayv2_api,
    module.webapp_lambda_aws_apigatewayv2_integration,
  ]

  api_id        = module.webapp_lambda_aws_apigatewayv2_api.id                           # 🔒 Required argument.
  route_key     = "GET /select/songs"                                                    # 🔒 Required argument.
  target        = "integrations/${module.webapp_lambda_aws_apigatewayv2_integration.id}" # ✅ Optional argument — recommended to keep.

}



# Creation of AWS API Gateway V2 Route for WebApp Lambda Function 🛣️ PUT /insert/song/rating 🛣️ Route.
module "webapp_lambda_aws_apigatewayv2_route_put_song_rating" {

  source        = "./terraform/aws/apigatewayv2/route"

  depends_on    = [
    module.webapp_lambda_aws_apigatewayv2_api,
    module.webapp_lambda_aws_apigatewayv2_integration,
  ]

  api_id        = module.webapp_lambda_aws_apigatewayv2_api.id                           # 🔒 Required argument.
  route_key     = "PUT /insert/song/rating"                                              # 🔒 Required argument.
  target        = "integrations/${module.webapp_lambda_aws_apigatewayv2_integration.id}" # ✅ Optional argument — recommended to keep.

}



# Creation of AWS API Gateway V2 Route for WebApp Lambda Function 🛣️ GET /select/song/rating/{songId} 🛣️ Route.
module "webapp_aws_apigatewayv2_route_get_song_rating_by_songId" {

  source        = "./terraform/aws/apigatewayv2/route"

  depends_on    = [
    module.webapp_lambda_aws_apigatewayv2_api,
    module.webapp_lambda_aws_apigatewayv2_integration,
  ]

  api_id        = module.webapp_lambda_aws_apigatewayv2_api.id                           # 🔒 Required argument.
  route_key     = "GET /select/song/rating/{songId}"                                     # 🔒 Required argument.
  target        = "integrations/${module.webapp_lambda_aws_apigatewayv2_integration.id}" # ✅ Optional argument — recommended to keep.

}



# Creation of AWS API Gateway V2 Route for WebApp Lambda Function 🛣️ GET /select/songs/search 🛣️ Route.
module "webapp_lambda_aws_apigatewayv2_route_get_songs_search" {

  source        = "./terraform/aws/apigatewayv2/route"

  depends_on    = [
    module.webapp_lambda_aws_apigatewayv2_api,
    module.webapp_lambda_aws_apigatewayv2_integration,
  ]

  api_id        = module.webapp_lambda_aws_apigatewayv2_api.id                           # 🔒 Required argument.
  route_key     = "GET /select/songs/search"                                             # 🔒 Required argument.
  target        = "integrations/${module.webapp_lambda_aws_apigatewayv2_integration.id}" # ✅ Optional argument — recommended to keep.

}



# Creation of AWS API Gateway V2 Route for WebApp Lambda Function 🛣️ GET /select/songs/avg/difficulty 🛣️ Route.
module "webapp_lambda_aws_apigatewayv2_route_get_songs_avg_difficulty" {

  source        = "./terraform/aws/apigatewayv2/route"

  depends_on    = [
    module.webapp_lambda_aws_apigatewayv2_api,
    module.webapp_lambda_aws_apigatewayv2_integration,
  ]

  api_id        = module.webapp_lambda_aws_apigatewayv2_api.id                           # 🔒 Required argument.
  route_key     = "GET /select/songs/avg/difficulty"                                     # 🔒 Required argument.
  target        = "integrations/${module.webapp_lambda_aws_apigatewayv2_integration.id}" # ✅ Optional argument — recommended to keep.

}



# Creation of AWS Security Group for WebApp Database - Amazon Aurora Serverless V2 - PostgreSQL Database.
module "webapp_lambda_to_webapp_db_sg" {

  source                 = "./terraform/aws/vpc/security_group"

  name                   = "webapp-lambda-to-webapp-db-sg"       # ✅ Optional argument, ❗ Forces new resource.
  description            = "WebApp DB AWS Security Group"        # ✅ Optional argument, ❗ Forces new resource.
  egress_rules           = [
    {
      from_port          = 0                                     # 🔒 Required argument.
      to_port            = 0                                     # 🔒 Required argument.
      protocol           = "all"                                 # 🔒 Required argument.
      cidr_blocks        = ["0.0.0.0/0"]                         # ✅ Optional argument — recommended to keep.
      description        = "Outbound traffic from PostgreSQL"    # ✅ Optional argument — recommended to keep.
      ipv6_cidr_blocks   = null                                  # ✅ Optional argument — recommended to keep.
      prefix_list_ids    = null                                  # ✅ Optional argument — recommended to keep.
      security_groups    = null                                  # ✅ Optional argument — recommended to keep.
      self               = null                                  # ✅ Optional argument — recommended to keep.
    },
  ]
  ingress_rules          = [
    {
      from_port          = 5432                                  # 🔒 Required argument.
      to_port            = 5432                                  # 🔒 Required argument.
      protocol           = "tcp"                                 # 🔒 Required argument.
      cidr_blocks        = [data.aws_vpc.default.cidr_block]     # ✅ Optional argument — recommended to keep.
      description        = "Inbound traffic to PostgreSQL"       # ✅ Optional argument — recommended to keep.
      ipv6_cidr_blocks   = null                                  # ✅ Optional argument — recommended to keep.
      prefix_list_ids    = null                                  # ✅ Optional argument — recommended to keep.
      security_groups    = null                                  # ✅ Optional argument — recommended to keep.
      self               = null                                  # ✅ Optional argument — recommended to keep.
    },
  ]
  name_prefix            = null                                  # ✅ Optional argument — 🤜💥🤛 Conflicts with `name`.
  revoke_rules_on_delete = false                                 # ✅ Optional argument.
  tags                   = {                                     # ✅ Optional argument — recommended to keep.
    "Name"               = "webapp-lambda-to-webapp-db-sg"
    "AppName"            = "Python FastAPI Web App"
  }
  vpc_id                 = data.aws_vpc.default.id               # ✅ Optional argument, ❗ Forces new resource.

}



# Creation of AWS Security Group for GitHub Hosted Runner to access WebApp Database .
module "github_hosted_runner_to_webapp_db_sg" {

  source                 = "./terraform/aws/vpc/security_group"

  name                   = "github-hosted-runner-to-webapp-db-sg"# ✅ Optional argument, ❗ Forces new resource.
  description            = "WebApp DB AWS Security Group"        # ✅ Optional argument, ❗ Forces new resource.
  egress_rules           = [
    {
      from_port          = 0                                     # 🔒 Required argument.
      to_port            = 0                                     # 🔒 Required argument.
      protocol           = "all"                                 # 🔒 Required argument.
      cidr_blocks        = ["0.0.0.0/0"]                         # ✅ Optional argument — recommended to keep.
      description        = "Outbound traffic from PostgreSQL"    # ✅ Optional argument — recommended to keep.
      ipv6_cidr_blocks   = null                                  # ✅ Optional argument — recommended to keep.
      prefix_list_ids    = null                                  # ✅ Optional argument — recommended to keep.
      security_groups    = null                                  # ✅ Optional argument — recommended to keep.
      self               = null                                  # ✅ Optional argument — recommended to keep.
    },
  ]
  ingress_rules          = [
    {
      from_port          = 5432                                  # 🔒 Required argument.
      to_port            = 5432                                  # 🔒 Required argument.
      protocol           = "tcp"                                 # 🔒 Required argument.
      cidr_blocks        = ["${var.github_hosted_runner_ip}"]    # ✅ Optional argument — recommended to keep.
      description        = "GitHub Hosted Runner to PostgreSQL"  # ✅ Optional argument — recommended to keep.
      ipv6_cidr_blocks   = null                                  # ✅ Optional argument — recommended to keep.
      prefix_list_ids    = null                                  # ✅ Optional argument — recommended to keep.
      security_groups    = null                                  # ✅ Optional argument — recommended to keep.
      self               = null                                  # ✅ Optional argument — recommended to keep.
    },
  ]
  name_prefix            = null                                  # ✅ Optional argument — 🤜💥🤛 Conflicts with `name`.
  revoke_rules_on_delete = false                                 # ✅ Optional argument.
  tags                   = {                                     # ✅ Optional argument — recommended to keep.
    "Name"               = "github-runner-to-pg-webapp-db-sg"
    "AppName"            = "Python FastAPI Web App"
  }
  vpc_id                 = data.aws_vpc.default.id               # ✅ Optional argument, ❗ Forces new resource.

}



# Creation of AWS DB Subnet Group for WebApp backend PostgreSQL Database.
module "webapp_db_aws_db_subnet_group" {

  source      = "./terraform/aws/rds/db_subnet_group"

  name        = "webapp-db-aws-db-subnet-group"         # ✅ Optional argument, ❗ Forces new resource.
  name_prefix = null                                    # ✅ Optional argument, ❗ Forces new resource — 🤜💥🤛 Conflicts with `name`.
  description = "WebApp DB Subnet Group for PostgreSQL" # ✅ Optional argument — recommended to keep.
  subnet_ids  = data.aws_subnets.available.ids          # 🔒 Required argument
  tags = {                                              # ✅ Optional argument — recommended to keep.
    "Name"     = "webapp-db-subnet-group"
    "AppName"  = "FastAPI WebApp"
  }

}



# Creation of Amazon Aurora Serverless V2 PostgreSQL for WebApp Lambda Function.
module "webapp_db_aws_rds_cluster" {

  source      = "./terraform/aws/rds/cluster"

  depends_on = [
    module.webapp_db_aws_db_subnet_group,
    module.webapp_lambda_to_webapp_db_sg,
  ]

  allocated_storage                   = null                                                      # ✅ Optional argument — 🔒 Required for Multi-AZ DB cluster.
  allow_major_version_upgrade         = false                                                     # ✅ Optional argument — 🧩 inter-related with `db_instance_parameter_group_name`.
  apply_immediately                   = false                                                     # ✅ Optional argument — recommended to keep.
  availability_zones                  = slice(data.aws_availability_zones.available.names, 0, 3)  # ✅ Optional argument — recommended to keep.
  backtrack_window                    = 0                                                         # ✅ Optional argument — recommended to keep.
  backup_retention_period             = 1                                                         # ✅ Optional argument — recommended to keep.
  cluster_identifier                  = "webapp-db-aws-rds-cluster"                               # ✅ Optional argument, ❗ Forces new resource — 🤜💥🤛 Conflicts with `cluster_identifier_prefix`.
  cluster_identifier_prefix           = null                                                      # ✅ Optional argument, ❗ Forces new resource — 🤜💥🤛 Conflicts with `cluster_identifier`.
  copy_tags_to_snapshot               = false                                                     # ✅ Optional argument — recommended to keep.
  database_name                       = var.webapp_database_name                                  # ✅ Optional argument — 🚨 highly recommended to keep.
  db_cluster_instance_class           = null                                                      # ✅ Optional argument — 🔒 Required for Multi-AZ DB cluster.
  db_cluster_parameter_group_name     = null                                                      # ✅ Optional argument.
  db_instance_parameter_group_name    = null                                                      # ✅ Optional argument — 🧩 inter-related with `allow_major_version_upgrade`.
  db_subnet_group_name                = module.webapp_db_aws_db_subnet_group.id                   # ✅ Optional argument — 🚨 highly recommended to keep, ❗ must match with `aws_rds_cluster_instance` resource `db_subnet_group_name` variable.
  db_system_id                        = null                                                      # ✅ Optional argument.
  delete_automated_backups            = true                                                      # ✅ Optional argument — recommended to keep.
  deletion_protection                 = false                                                     # ✅ Optional argument — 🚨 highly recommended to keep.
  enable_global_write_forwarding      = false                                                     # ✅ Optional argument — 🚨 highly recommended to keep.
  enable_http_endpoint                = true                                                      # ✅ Optional argument — 🚨 `engine_mode` must be 'serverless'.
  enabled_cloudwatch_logs_exports     = []                                                        # ✅ Optional argument.
  engine                              = "aurora-postgresql"                                       # 🔒 Required argument.
  engine_mode                         = "provisioned"                                             # ✅ Optional argument — 🚨 highly recommended to keep.
  engine_version                      = "15.3"                                                    # ✅ Optional argument — 🚨 highly recommended to keep.
  final_snapshot_identifier           = null                                                      # ✅ Optional argument — recommended to keep.
//final_snapshot_identifier           = "webapp-db-snapshot-${local.datetime}"                    # ✅ Optional argument — recommended to keep.
  global_cluster_identifier           = null                                                      # ✅ Optional argument.
  iam_database_authentication_enabled = false                                                     # ✅ Optional argument.
  iam_roles                           = []                                                        # ✅ Optional argument.
  iops                                = null                                                      # ✅ Optional argument — 🧩 inter-related with `availability_zones`.
  kms_key_id                          = null                                                      # ✅ Optional argument — 🚨 `storage_encrypted` must be 'true'.
//manage_master_user_password         = false                                                     # ✅ Optional argument — 🚨 `webapp_db_master_password` must be 'null'.
  master_password                     = var.webapp_db_master_password                             # 🔒 Required argument — 🚨 `manage_master_user_password` must be 'false'.
//master_user_secret_kms_key_id       = null                                                      # ✅ Optional argument, comment it if `master_username` and `master_password` used.
  master_username                     = var.webapp_db_master_username                             # 🔒 Required argument.
  network_type                        = null                                                      # ✅ Optional argument — recommended to keep.
  port                                = 5432                                                      # ✅ Optional argument — 🚨 highly recommended to keep.
  preferred_backup_window             = null                                                      # ✅ Optional argument — recommended to keep.
//preferred_backup_window             = "00:00-00:59"                                             # ✅ Optional argument — recommended to keep.
  preferred_maintenance_window        = null                                                      # ✅ Optional argument — recommended to keep.
//preferred_maintenance_window        = "sun:01:00-sun:02:00"                                     # ✅ Optional argument — recommended to keep.
  replication_source_identifier       = null                                                      # ✅ Optional argument.
  restore_to_point_in_time            = null                                                      # ✅ Optional argument block.
  scaling_configuration               = null                                                      # ✅ Optional argument block.
  serverlessv2_scaling_configuration  = {                                                         # ✅ Optional argument block — 🚨 highly recommended to keep.
    min_capacity = 0.5
    max_capacity = 2.0
  }
  skip_final_snapshot                 = true                                                      # ✅ Optional argument — recommended to keep.
  snapshot_identifier                 = null                                                      # ✅ Optional argument — 🤜💥🤛 Conflicts with `global_cluster_identifier`.
  source_region                       = null                                                      # ✅ Optional argument.
  storage_encrypted                   = true                                                      # ✅ Optional argument.
  storage_type                        = null                                                      # ✅ Optional argument — 🔒 Required for Multi-AZ DB cluster.
  tags                                = {                                                         # ✅ Optional argument — recommended to keep.
    "Name"     = "webapp-db-aws-rds-cluster"
    "AppName"  = "FastAPI WebApp"
  }
  vpc_security_group_ids              = [                                                         # ✅ Optional argument — 🚨 highly recommended to keep.
    module.webapp_lambda_to_webapp_db_sg.id,
    module.github_hosted_runner_to_webapp_db_sg.id,    
  ]

}



module "webapp_db_aws_rds_cluster_instance_0" {
  
  source = "./terraform/aws/rds/cluster_instance"

  depends_on = [
    module.webapp_db_aws_rds_cluster,
    module.webapp_db_aws_db_subnet_group,
  ]

  apply_immediately                     = true                                           # ✅ Optional argument.
  auto_minor_version_upgrade            = true                                           # ✅ Optional argument.
  availability_zone                     = data.aws_availability_zones.available.names[0] # ✅ Optional argument, ❗ Forces new resource.
  ca_cert_identifier                    = null                                           # ✅ Optional argument.
  cluster_identifier                    = module.webapp_db_aws_rds_cluster.id            # 🔒 Required argument, ❗ Forces new resource.
  copy_tags_to_snapshot                 = false                                          # ✅ Optional argument.
  custom_iam_instance_profile           = null                                           # ✅ Optional argument.
  db_parameter_group_name               = null                                           # ✅ Optional argument.
  db_subnet_group_name                  = module.webapp_db_aws_db_subnet_group.id        # 🔒 Required argument, if `publicly_accessible = false`, Optional otherwise, ❗ Forces new resource.
  engine_version                        = "15.3"                                         # ✅ Optional argument — recommended to keep.
  engine                                = module.webapp_db_aws_rds_cluster.engine        # 🔒 Required argument, ❗ Forces new resource.
  identifier_prefix                     = null                                           # ✅ Optional argument, ❗ Forces new resource — 🤜💥🤛 Conflicts with `identifier`.
  identifier                            = "webapp-db-aws-rds-cluster-instance-0"         # ✅ Optional argument, ❗ Forces new resource.
  instance_class                        = "db.serverless"                                # 🔒 Required argument.
  monitoring_interval                   = 0                                              # ✅ Optional argument.
  monitoring_role_arn                   = null                                           # ✅ Optional argument.
  performance_insights_enabled          = false                                          # ✅ Optional argument.
//performance_insights_kms_key_id       = var.performance_insights_kms_key_id            # 🔒 Required argument, if `performance_insights_enabled = true`, Optional otherwise.
//performance_insights_retention_period = var.performance_insights_retention_period      # 🔒 Required argument, if `performance_insights_enabled = true`, Optional otherwise.
  preferred_backup_window               = null                                           # ✅ Optional argument, if it set at the cluster level, this must be `null`.
  preferred_maintenance_window          = null                                           # ✅ Optional argument — recommended to keep.
  promotion_tier                        = 0                                              # ✅ Optional argument.
  publicly_accessible                   = true                                           # ✅ Optional argument — recommended to keep.
  tags = {                                                                               # ✅ Optional argument — recommended to keep.
    Name     = "webapp_db-aws-rds-cluster-instance-0"
    AppName  = "FastAPI WebApp"
  }

}



# Creation of AWS Secrets Manager Secret for
# Amazon Aurora Serverless PostgreSQL Relational Database RDS Cluster.
module "webapp_db_aws_secretsmanager_secret" {

  source                         = "./terraform/aws/secretsmanager/secret"

  depends_on                     = [
    module.webapp_db_aws_rds_cluster,
  ]

  description                    = "webapp_db Secrets Manager" # ✅ Optional argument — recommended to keep.
  force_overwrite_replica_secret = false                       # ✅ Optional argument — recommended to keep.
  kms_key_id                     = null                        # ✅ Optional argument.
  name                           = "webapp-db-credentials-8"   # ✅ Optional argument — 🤜💥🤛 Conflicts with `name_prefix`.
//name_prefix                    = "prefix-"                   # ✅ Optional argument — 🤜💥🤛 Conflicts with `name`, better to comment it.
  recovery_window_in_days        = 7                           # ✅ Optional argument — recommended to keep.
  tags                           = {                           # ✅ Optional argument — recommended to keep.
    "Name"            = "WebApp"
    "AppName"         = "Python FastAPI Web App"
  }

}



# Creation of AWS Secrets Manager Version for
# Amazon Aurora Serverless PostgreSQL Relational Database RDS Cluster.
module "webapp_aws_secretsmanager_secret_version" {

  source        = "./terraform/aws/secretsmanager/secret_version"

  depends_on    = [
    module.webapp_db_aws_secretsmanager_secret,
    module.webapp_db_aws_rds_cluster,
  ]

  secret_id     = module.webapp_db_aws_secretsmanager_secret.id # 🔒 Required argument.
  secret_string = jsonencode({                                  # ✅ Optional argument, but required if `secret_binary` is not set.                             
    dbInstanceIdentifier = module.webapp_db_aws_rds_cluster.id
    engine               = module.webapp_db_aws_rds_cluster.engine
    host                 = module.webapp_db_aws_rds_cluster.endpoint
    port                 = module.webapp_db_aws_rds_cluster.port
    resourceId           = module.webapp_db_aws_rds_cluster.cluster_resource_id
    database             = var.webapp_database_name
    username             = var.webapp_db_master_username
    password             = var.webapp_db_master_password
    dialect              = "postgresql"
    driver               = "psycopg2"
    schema               = "public"
    echo                 = "False"
    connect_timeout      = 30
  }) 

}



# Creation of AWS Security Group for WebApp Database - Amazon Aurora Serverless V2 - PostgreSQL Database.
module "webapp_lambda_to_secretsmanager_vpce_sg" {

  source                 = "./terraform/aws/vpc/security_group"

  name                   = "webapp-lambda-access-secretsmanager-vpce-sg" # ✅ Optional argument, ❗ Forces new resource.
  description            = "WebApp Lambda Access SecretsManager VPCE SG" # ✅ Optional argument, ❗ Forces new resource.
  egress_rules           = [
    {
      from_port          = 0                                    # 🔒 Required argument.
      to_port            = 0                                    # 🔒 Required argument.
      protocol           = "all"                                # 🔒 Required argument.
      cidr_blocks        = ["0.0.0.0/0"]                        # ✅ Optional argument — recommended to keep.
      description        = "Outbound traffic from VPC Endpoint" # ✅ Optional argument — recommended to keep.
      ipv6_cidr_blocks   = null                                 # ✅ Optional argument — recommended to keep.
      prefix_list_ids    = null                                 # ✅ Optional argument — recommended to keep.
      security_groups    = null                                 # ✅ Optional argument — recommended to keep.
      self               = null                                 # ✅ Optional argument — recommended to keep.
    },
  ]
  ingress_rules          = [
    {
      from_port          = 443                                  # 🔒 Required argument.
      to_port            = 443                                  # 🔒 Required argument.
      protocol           = "tcp"                                # 🔒 Required argument.
      cidr_blocks        = [data.aws_vpc.default.cidr_block]    # ✅ Optional argument — recommended to keep.
      description        = "Inbound traffic to VPC Endpoint"    # ✅ Optional argument — recommended to keep.
      ipv6_cidr_blocks   = null                                 # ✅ Optional argument — recommended to keep.
      prefix_list_ids    = null                                 # ✅ Optional argument — recommended to keep.
      security_groups    = null                                 # ✅ Optional argument — recommended to keep.
      self               = null                                 # ✅ Optional argument — recommended to keep.
    },
  ]
  name_prefix            = null                               # ✅ Optional argument — 🤜💥🤛 Conflicts with `name`.
  revoke_rules_on_delete = false                              # ✅ Optional argument.
  tags                   = {                                  # ✅ Optional argument — recommended to keep.
    "Name"               = "webapp-lambda-to-secretsmanager-vpce-sg"
    "AppName"            = "Python FastAPI Web App"
  }
  vpc_id                 = data.aws_vpc.default.id            # ✅ Optional argument, ❗ Forces new resource.

}



# Creation of AWS VPC Endpoint for WebApp Lambda Function
# to access AWS Secrets Manager service.
module "webapp_aws_vpc_endpoint" {

  depends_on = [
    module.webapp_lambda_to_secretsmanager_vpce_sg,
  ]

  source              = "./terraform/aws/vpc/endpoint"

  service_name        = "com.amazonaws.${data.aws_region.current.name}.secretsmanager" # 🔒 Required argument.
  vpc_id              = data.aws_vpc.default.id                                        # 🔒 Required argument.
  private_dns_enabled = true                                                           # ✅ Optional argument, but applicable for endpoints of type Interface.
  subnet_ids          = data.aws_subnets.available.ids                                 # ✅ Optional argument, but applicable for endpoints of type GatewayLoadBalancer and Interface.
  security_group_ids  = [module.webapp_lambda_to_secretsmanager_vpce_sg.id]            # ✅ Optional argument, but required for endpoints of type Interface.
  tags                = {                                                              # ✅ Optional argument — recommended to keep.
    "Name"            = "webapp_secretsmanager"
    "AppName"         = "Python FastAPI Web App"
  }
  vpc_endpoint_type   = "Interface"                                                    # ✅ Optional argument — recommended to keep.

}

# terraform provider information.
provider "aws" {

  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key

}

# AWS Default Security Group Update.
resource "aws_default_security_group" "update" {

  lifecycle {
    create_before_destroy = true
    prevent_destroy       = true
    ignore_changes        = [
      tags
    ]
  }

  vpc_id = data.aws_vpc.default.id

  ingress {
    cidr_blocks = [data.aws_vpc.default.cidr_block]
    description = "PostgreSQL inbound traffic rule."
    protocol    = "tcp"
    to_port     = 5432
    from_port   = 5432
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "All outbound traffic rule."
    protocol    = "all"
    to_port     = 0
    from_port   = 0
  }

}

# Creation of AWS IAM Role for WebApp Lambda Function.
module "webapp_aws_iam_role" {

  source                = "./terraform/aws/iam/role"

  assume_role_policy    = data.aws_iam_policy_document.webapp_lambda_iam_role.json  # Required argument.
  description           = "AWS IAM Role for WebApp Lambda."                         # Optional argument, but keep it.
  force_detach_policies = true                                                      # Optional argument, but keep it.
  name                  = "WebAppLambdaIAMRole"                                     # Optional argument, but keep it.

}

# Creation of AWS IAM Policy for WebApp Lambda Function.
module "webapp_aws_iam_policy" {

  source      = "./terraform/aws/iam/policy"

  description = "AWS IAM Policy for WebApp Lambda."                               # Optional argument, but keep it.
  name        = "WebAppLambdaIAMPolicy"                                           # Optional argument, but keep it.
  path        = "/"                                                               # Optional argument, but keep it.
  policy      = data.aws_iam_policy_document.webapp_lambda_monitoring_policy.json # Required argument.

}



# Creation of AWS IAM Role Policy attachment for WebApp Lambda Function.
module "webapp_aws_iam_role_policy_attachment" {

  source     = "./terraform/aws/iam/role_policy_attachment"

  depends_on = [
    module.webapp_aws_iam_role,
    module.webapp_aws_iam_policy,
  ]

  role       = module.webapp_aws_iam_role.name  # Required argument.
  policy_arn = module.webapp_aws_iam_policy.arn # Required argument.

}



module "webapp_aws_s3_bucket" {

  source = "./terraform/aws/s3/bucket"

  bucket = var.webapp_lambda_src_s3_bucket_name                                 # Optional argument, but keep it.
  acl    = "private"                                                            # Optional argument, but keep it.
  policy = data.aws_iam_policy_document.webapp_lambda_src_s3_bucket_policy.json # Optional argument, but keep it.
  tags   = {                                                                    # Optional argument, but keep it.
    "Name"            = "WebApplication"
    "AppName"         = "Python FastAPI Web App"
    "DeveloperName"   = "Balaji Pothula"
    "DeveloperEmail"  = "balan.pothula@gmail.com"
  }

}



# Creation of AWS S3 Bucket Object for WebApp Lambda Function.
module "webapp_aws_s3_bucket_object" {

  source      = "./terraform/aws/s3/bucket_object"

  depends_on  = [
    module.webapp_aws_s3_bucket,
  ]

  bucket      = module.webapp_aws_s3_bucket.id                # Required argument.
  key         = "/${local.yyyymmdd}/${local.webapp_zip}"      # Required argument.
  acl         = "private"                                     # Optional argument, but keep it.
  etag        = filemd5(data.archive_file.webapp.output_path) # Optional argument, but keep it.
  source_code = data.archive_file.webapp.output_path          # Optional argument, but keep it.
  tags        = {                                             # Optional argument, but keep it.
    "Name"            = "WebApp"
    "AppName"         = "Python FastAPI Web App"
    "DeveloperName"   = "Balaji Pothula"
    "DeveloperEmail"  = "balan.pothula@gmail.com"
  }

}



# Creation of AWS Lambda Layer Version for WebApp Lambda Function.
module "webapp_aws_lambda_layer_version" {

  source                   = "./terraform/aws/lambda/layer_version"

  layer_name               = "webapp"                          # Required argument.
  compatible_architectures = ["arm64", "x86_64"]               # Optional argument, but keep it.
  compatible_runtimes      = ["python3.9"]                     # Optional argument, but keep it.
  description              = "Python Library."                 # Optional argument, but keep it.
  filename                 = local.layer_zip                   # Optional argument, 🤜💥🤛 conflicts with `s3_bucket`, `s3_key` and `s3_object_version`.
  license_info             = "Apache License 2.0"              # Optional argument, but keep it.
//s3_bucket                = var.s3_bucket                     # Optional argument, conflicts with filename.
//s3_key                   = var.s3_key                        # Optional argument, conflicts with filename.
//s3_object_version        = var.s3_object_version             # Optional argument, conflicts with filename.
  source_code_hash         = filebase64sha256(local.layer_zip) # Optional argument, but keep it.

}



# Creation of AWS Lambda Function for WebApp.
module "webapp_aws_lambda_function" {

  source                         = "./terraform/aws/lambda/function"

  depends_on                     = [
    module.webapp_aws_s3_bucket,
    module.webapp_aws_s3_bucket_object,
    module.webapp_aws_iam_role_policy_attachment,
    module.webapp_aws_lambda_layer_version,
    module.webapp_aws_secretsmanager_secret,
  ]

  function_name                  = "webapp"                                     # Required argument, ❗ modification creates new resource.
  role                           = module.webapp_aws_iam_role.arn               # Required argument.
  description                    = "WebApp Lambda Function"                     # Optional argument, ✓ but keep it.
  environment_variables          = {                                            # Optional argument, ✓ but keep it.
    region = data.aws_region.current.name,
    secret = module.webapp_aws_secretsmanager_secret.id
  }
  handler                        = "lambda_function.lambda_handler"             # Optional argument, but keep it.
  layers                         = [module.webapp_aws_lambda_layer_version.arn] # Optional argument, but keep it.
  memory_size                    = 512                                          # Optional argument, but keep it.
  package_type                   = "Zip"                                        # Optional argument, but keep it.
  publish                        = false                                        # Optional argument, but keep it.
  reserved_concurrent_executions = -1                                           # Optional argument, but keep it.
  runtime                        = "python3.9"                                  # Optional argument, but keep it.
  s3_bucket                      = module.webapp_aws_s3_bucket.id               # Optional argument, but keep it.
  s3_key                         = "${local.yyyymmdd}/${local.webapp_zip}"      # Optional argument, conflicts with filename and image_uri.
  tags                           = {                                            # Optional argument, but keep it.
    "Name"            = "webapp"
    "AppName"         = "Python FastAPI Web Application"
    "DeveloperName"   = "Balaji Pothula"
    "DeveloperEmail"  = "balan.pothula@gmail.com"
  }
  timeout                        = 60                                           # Optional argument, but keep it.

}



# Creation of AWS CloudWatch Log Group for WebApp Lambda Function.
module "webapp_aws_cloudwatch_log_group" {

  source            = "./terraform/aws/cloudwatch/log_group"

  depends_on        = [
    module.webapp_aws_lambda_function,
  ]

  name              = "/aws/lambda/${module.webapp_aws_lambda_function.function_name}" # Optional argument, but keep it.
  retention_in_days = 1                                                                # Optional argument, but keep it.
  tags              = {                                                                # Optional argument, but keep it.
    "Name"            = "WebApp"
    "AppName"         = "Python FastAPI Web App"
    "DeveloperName"   = "Balaji Pothula"
    "DeveloperEmail"  = "balan.pothula@gmail.com"
  }

}



# Creation of AWS API Gateway V2 API for WebApp Lambda Function.
module "webapp_aws_apigatewayv2_api" {

  source        = "./terraform/aws/apigatewayv2/api"

  name          = "webapp"    # Required argument.
  protocol_type = "HTTP"      # Required argument.

}



# Creation of AWS API Gateway V2 Stage for WebApp Lambda Function.
module "webapp_aws_apigatewayv2_stage" {

  source      = "./terraform/aws/apigatewayv2/stage"

  depends_on  = [
    module.webapp_aws_apigatewayv2_api,
  ]

  api_id      = module.webapp_aws_apigatewayv2_api.id # Required argument.
  name        = "$default"                            # Required argument.
  auto_deploy = true                                  # Optional argument, but keep it.

}



# Creation of AWS API Gateway V2 Integration for WebApp Lambda Function.
module "webapp_aws_apigatewayv2_integration" {

  source             = "./terraform/aws/apigatewayv2/integration"

  depends_on         = [
    module.webapp_aws_lambda_function,
    module.webapp_aws_apigatewayv2_api,
  ]

  api_id             = module.webapp_aws_apigatewayv2_api.id # Required argument.
  integration_type   = "AWS_PROXY"                           # Required argument.
  integration_uri    = module.webapp_aws_lambda_function.arn # Optional argument, but keep it.
  integration_method = "ANY"                                 # Optional argument, but keep it.

}



# Creation of AWS Lambda Permission to invoke WebApp Lambda Function by AWS API Gateway V2.
module "webapp_aws_lambda_permission" {

  source        = "./terraform/aws/lambda/permission"

  depends_on    = [
    module.webapp_aws_lambda_function,
    module.webapp_aws_apigatewayv2_api,
  ]

  action        = "lambda:InvokeFunction"                                     # Required argument.
  function_name = module.webapp_aws_lambda_function.function_name             # Required argument.
  principal     = "apigateway.amazonaws.com"                                  # Required argument.
  statement_id  = "AllowExecutionFromAPIGateway"                              # Optional argument.
  source_arn    = "${module.webapp_aws_apigatewayv2_api.execution_arn}/*/*"   # Optional argument.

}



# Creation of AWS API Gateway V2 Route for WebApp Lambda Function - Index - Route.
module "webapp_aws_apigatewayv2_route_index" {

  source        = "./terraform/aws/apigatewayv2/route"

  depends_on    = [
    module.webapp_aws_apigatewayv2_api,
    module.webapp_aws_apigatewayv2_integration,
  ]

  api_id        = module.webapp_aws_apigatewayv2_api.id                           # Required argument.
  route_key     = "GET /"                                                         # Required argument.
  target        = "integrations/${module.webapp_aws_apigatewayv2_integration.id}" # Optional argument, but keep it.

}


/*
# Creation of AWS API Gateway V2 Route for WebApp Lambda Function - Put Song - Route.
module "webapp_aws_apigatewayv2_route_put_song" {

  source        = "./terraform/aws/apigatewayv2/route"

  depends_on    = [
    module.webapp_aws_apigatewayv2_api,
    module.webapp_aws_apigatewayv2_integration,
  ]

  api_id        = module.webapp_aws_apigatewayv2_api.id                           # Required argument.
  route_key     = "PUT /song"                                                     # Required argument.
  target        = "integrations/${module.webapp_aws_apigatewayv2_integration.id}" # Optional argument, but keep it.

}



# Creation of AWS API Gateway V2 Route for WebApp Lambda Function - Get Songs - Route.
module "webapp_aws_apigatewayv2_route_get_songs" {

  source        = "./terraform/aws/apigatewayv2/route"

  depends_on    = [
    module.webapp_aws_apigatewayv2_api,
    module.webapp_aws_apigatewayv2_integration,
  ]

  api_id        = module.webapp_aws_apigatewayv2_api.id                           # Required argument.
  route_key     = "GET /songs"                                                    # Required argument.
  target        = "integrations/${module.webapp_aws_apigatewayv2_integration.id}" # Optional argument, but keep it.

}



# Creation of AWS API Gateway V2 Route for WebApp Lambda Function - Put Song Rating - Route.
module "webapp_aws_apigatewayv2_route_put_song_rating" {

  source        = "./terraform/aws/apigatewayv2/route"

  depends_on    = [
    module.webapp_aws_apigatewayv2_api,
    module.webapp_aws_apigatewayv2_integration,
  ]

  api_id        = module.webapp_aws_apigatewayv2_api.id                           # Required argument.
  route_key     = "PUT /song/rating"                                              # Required argument.
  target        = "integrations/${module.webapp_aws_apigatewayv2_integration.id}" # Optional argument, but keep it.

}



# Creation of AWS API Gateway V2 Route for WebApp Lambda Function - Get Song Rating - Route.
module "webapp_aws_apigatewayv2_route_get_song_rating" {

  source        = "./terraform/aws/apigatewayv2/route"

  depends_on    = [
    module.webapp_aws_apigatewayv2_api,
    module.webapp_aws_apigatewayv2_integration,
  ]

  api_id        = module.webapp_aws_apigatewayv2_api.id                           # Required argument.
  route_key     = "GET /song/rating/{songId}"                                     # Required argument.
  target        = "integrations/${module.webapp_aws_apigatewayv2_integration.id}" # Optional argument, but keep it.

}



# Creation of AWS API Gateway V2 Route for WebApp Lambda Function - Get Songs Search - Route.
module "webapp_aws_apigatewayv2_route_get_songs_search" {

  source        = "./terraform/aws/apigatewayv2/route"

  depends_on    = [
    module.webapp_aws_apigatewayv2_api,
    module.webapp_aws_apigatewayv2_integration,
  ]

  api_id        = module.webapp_aws_apigatewayv2_api.id                           # Required argument.
  route_key     = "GET /songs/search"                                             # Required argument.
  target        = "integrations/${module.webapp_aws_apigatewayv2_integration.id}" # Optional argument, but keep it.

}



# Creation of AWS API Gateway V2 Route for WebApp Lambda Function - Get Songs Average Difficulty - Route.
module "webapp_aws_apigatewayv2_route_get_songs_avg_difficulty" {

  source        = "./terraform/aws/apigatewayv2/route"

  depends_on    = [
    module.webapp_aws_apigatewayv2_api,
    module.webapp_aws_apigatewayv2_integration,
  ]

  api_id        = module.webapp_aws_apigatewayv2_api.id                           # Required argument.
  route_key     = "GET /songs/avg/difficulty"                                     # Required argument.
  target        = "integrations/${module.webapp_aws_apigatewayv2_integration.id}" # Optional argument, but keep it.

}
*/


resource "aws_db_subnet_group" "webapp_db_subnet_group" {
  name       = "webapp-db-subnet-group"
  subnet_ids = data.aws_subnets.available.ids
  description = "WebApp Aurora Serverless v2 PostgreSQL Subnet Group."
}



resource "aws_rds_cluster" "webapp_aws_rds_cluster" {
  cluster_identifier      = "webapp-rds-cluster"
  engine                  = "aurora-postgresql"
  engine_version          = "15.3"
  enable_http_endpoint    = true
  database_name           = var.database_name
  master_username         = var.master_username
  master_password         = var.master_password
  db_subnet_group_name    = aws_db_subnet_group.webapp_db_subnet_group.name
  vpc_security_group_ids  = [aws_default_security_group.update.id]
  backup_retention_period = 7
  engine_mode             = "provisioned"
  storage_encrypted       = true
  skip_final_snapshot     = true

  serverlessv2_scaling_configuration {
    min_capacity = 0.5
    max_capacity = 2.0
  }
}



resource "aws_rds_cluster_instance" "webapp_aws_rds_cluster_instance" {
  identifier              = "webapp-rds-cluster-instance"
  cluster_identifier      = aws_rds_cluster.webapp_aws_rds_cluster.id
  instance_class          = "db.serverless"
  engine                  = aws_rds_cluster.webapp_aws_rds_cluster.engine
  engine_version          = aws_rds_cluster.webapp_aws_rds_cluster.engine_version
  publicly_accessible     = false
}



# Creation of AWS Secrets Manager Secret for
# Amazon Aurora Serverless PostgreSQL Relational Database RDS Cluster.
module "webapp_aws_secretsmanager_secret" {

  source                         = "./terraform/aws/secretsmanager/secret"

  depends_on                     = [
    aws_rds_cluster.webapp_aws_rds_cluster,
  ]

  description                    = "WebApp Secrets Manager"    # Optional argument, but keep it.
  force_overwrite_replica_secret = false                       # Optional argument, but keep it.
  name                           = "webapp_db-creds"           # Optional argument, conflicts with name_prefix.
  recovery_window_in_days        = 7                           # Optional argument, but keep it.
  tags                           = {                           # Optional argument, but keep it.
    "Name"            = "WebApp"
    "AppName"         = "Python FastAPI Web App"
    "DeveloperName"   = "Balaji Pothula"
    "DeveloperEmail"  = "balan.pothula@gmail.com"
  }

}



# Creation of AWS Secrets Manager Version for
# Amazon Aurora Serverless PostgreSQL Relational Database RDS Cluster.
module "webapp_aws_secretsmanager_secret_version" {

  source        = "./terraform/aws/secretsmanager/secret_version"

  depends_on    = [
    module.webapp_aws_secretsmanager_secret,
    aws_rds_cluster.webapp_aws_rds_cluster,
  ]

  secret_id     = module.webapp_aws_secretsmanager_secret.id # Required argument.
  secret_string = jsonencode({                               # Optional argument, but required if secret_binary is not set.                             
    dbInstanceIdentifier = aws_rds_cluster.webapp_aws_rds_cluster.id
    engine               = aws_rds_cluster.webapp_aws_rds_cluster.engine
    host                 = aws_rds_cluster.webapp_aws_rds_cluster.endpoint
    port                 = aws_rds_cluster.webapp_aws_rds_cluster.port
    resourceId           = aws_rds_cluster.webapp_aws_rds_cluster.cluster_resource_id
    database             = var.database_name
    username             = var.master_username
    password             = var.master_password
    dialect              = "postgresql"
    driver               = "psycopg"
    schema               = "public"
    echo                 = "False"
    connect_timeout      = 30
  }) 

}


/*
# Creation of AWS VPC Endpoint for WebApp Lambda Function
# to access AWS Secrets Manager service.
module "webapp_aws_vpc_endpoint" {

  source              = "./terraform/aws/vpc/endpoint"

  service_name        = "com.amazonaws.${data.aws_region.current.name}.secretsmanager" # Required argument.
  vpc_id              = data.aws_vpc.default.id                                        # Required argument.
  private_dns_enabled = false                                                          # Optional argument, but applicable for endpoints of type Interface.
  subnet_ids          = data.aws_subnets.available.ids                                 # Optional argument, but applicable for endpoints of type GatewayLoadBalancer and Interface.
  security_group_ids  = data.aws_security_groups.default.ids                           # Optional argument, but required for endpoints of type Interface.
  tags                = {                                                              # Optional argument, but keep it.
    "Name"            = "webapp_secretsmanager"
    "AppName"         = "Python FastAPI Web App"
    "DeveloperName"   = "Balaji Pothula"
    "DeveloperEmail"  = "balan.pothula@gmail.com"
  }
  vpc_endpoint_type   = "Interface"                                                    # Optional argument, but keep it.

}



/*
# Creation of Amazon Aurora Serverless PostgreSQL
# Relational Database RDS Cluster for WebApp Lambda Function.
module "webapp_aws_rds_cluster" {

  source                       = "./terraform/aws/rds/cluster"

  allow_major_version_upgrade  = true                                      # Optional argument, but keep it.
  apply_immediately            = true                                      # Optional argument, but keep it.
  backup_retention_period      = 1                                         # Optional argument, but keep it.
  cluster_identifier           = "webapp"                                  # Optional argument, but keep it.
  copy_tags_to_snapshot        = true                                      # Optional argument, but keep it.
  database_name                = var.database_name                         # Optional argument, but keep it.
  deletion_protection          = false                                     # Optional argument, but keep it.
  enable_http_endpoint         = true                                      # Optional argument, but keep it.
  engine                       = "aurora-postgresql"                       # Optional argument, but keep it.
 #engine_mode                  = "serverless-v2"                           # Optional argument, comment it.
  engine_version               = "16.1"                                    # Optional argument, but keep it.
  final_snapshot_identifier    = "webapp-snapshot-at-${local.datetime}"    # Optional argument, but keep it.
  master_password              = var.master_password                       # Required argument.
  master_username              = var.master_username                       # Required argument.
  port                         = "5432"                                    # Optional argument, but keep it.
  preferred_backup_window      = "00:00-00:59"                             # Optional argument, but keep it.
  preferred_maintenance_window = "sun:01:00-sun:02:00"                     # Optional argument, but keep it.
  skip_final_snapshot          = true                                      # Optional argument, but keep it.
  storage_encrypted            = true                                      # Optional argument, but keep it.
  tags                         = {                                         # Optional argument, but keep it.
    "Name"            = "WebApp"
    "AppName"         = "Python FastAPI Web App"
    "DeveloperName"   = "Balaji Pothula"
    "DeveloperEmail"  = "balan.pothula@gmail.com"
  }

}
*/

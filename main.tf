provider "aws" {

  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key

}

# Data Source: aws_region
data "aws_region" "current" {
}

data "aws_caller_identity" "current" {
}

# Data Source: aws_vpc
data "aws_vpc" "default" {
  default = true
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

# Data Source: aws_subnet
data "aws_subnet" "default" {
  for_each = data.aws_subnet_ids.available.ids
  id       = each.value
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
data "archive_file" "yousician" {
  type        = "zip"
  source_file = local.yousician_src
  output_path = "./${local.yousician_zip}"
}

locals {
  timestamp     = timestamp()
  yyyymmdd      = formatdate("YYYY/MM/DD",          local.timestamp)   
  datetime      = formatdate("YYYY-MM-DD-hh-mm-ss", local.timestamp)
  layer_zip     = "./python/lib/layer.zip"
  yousician_src = "./python/src/yousician_lambda_function.py"
  yousician_zip = "yousician-${local.datetime}.zip"
}

# Update AWS Default Security Group Rules.
resource "aws_default_security_group" "update" {

  vpc_id = data.aws_vpc.default.id

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "API Gateway inbound traffic rule."
    protocol    = "tcp"
    to_port     = 80
    from_port   = 80
  }

  ingress {
    cidr_blocks = [for subnet in data.aws_subnet.default : subnet.cidr_block]
    description = "Secrets Manager inbound traffic rule."
    protocol    = "tcp"
    to_port     = 443
    from_port   = 443
  }

  ingress {
    cidr_blocks = [for subnet in data.aws_subnet.default : subnet.cidr_block]
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

# Creation of AWS IAM Role for Yousician Lambda Function.
module "yousician_aws_iam_role" {

  source                = "./terraform/aws/iam/role"

  assume_role_policy    = file("./json/YousicianLambdaIAMRole.json") # Required argument.
  description           = "AWS IAM Role for Yousician Lambda."       # Optional argument, but keep it.
  force_detach_policies = true                                       # Optional argument, but keep it.
  name                  = "YousicianLambdaIAMRole"                   # Optional argument, but keep it.

}

# Creation of AWS IAM Policy for Yousician Lambda Function.
module "yousician_aws_iam_policy" {

  source      = "./terraform/aws/iam/policy"

  description = "AWS IAM Policy for Yousician Lambda."       # Optional argument, but keep it.
  name        = "YousicianLambdaIAMPolicy"                   # Optional argument, but keep it.
  path        = "/"                                          # Optional argument, but keep it.
  policy      = file("./json/YousicianLambdaIAMPolicy.json") # Required argument.

}

# Creation of AWS IAM Role Policy attachment for Yousician Lambda Function.
module "yousician_aws_iam_role_policy_attachment" {

  source     = "./terraform/aws/iam/role_policy_attachment"

  depends_on = [
    module.yousician_aws_iam_role,
    module.yousician_aws_iam_policy,
  ]

  role       = module.yousician_aws_iam_role.name  # Required argument.
  policy_arn = module.yousician_aws_iam_policy.arn # Required argument.

}

# Creation of AWS S3 Bucket for Yousician Lambda Function.
# Creation of AWS S3 Bucket for Yousician RDS Credentials Rotator Lambda Function.
module "yousician_aws_s3_bucket" {

  source = "./terraform/aws/s3/bucket"

  bucket = "yousician-aws-s3-bucket"                # Optional argument, but keep it.
  acl    = "private"                                # Optional argument, but keep it.
  policy = file("./json/YousicianS3IAMPolicy.json") # Optional argument, but keep it.
  tags   = {                                        # Optional argument, but keep it.
    "Name"            = "yousician"
    "AppName"         = "Yousician Web App"
    "DeveloperName"   = "Balaji Pothula"
    "DeveloperEmail"  = "balaji@yousician.com"
  }

}

# Creation of AWS S3 Bucket Object for Yousician Lambda Function.
module "yousician_aws_s3_bucket_object" {

  source      = "./terraform/aws/s3/bucket_object"

  depends_on  = [
    module.yousician_aws_s3_bucket,
  ]

  bucket      = module.yousician_aws_s3_bucket.id                # Required argument.
  key         = "/${local.yyyymmdd}/${local.yousician_zip}"      # Required argument.
  acl         = "private"                                        # Optional argument, but keep it.
  etag        = filemd5(data.archive_file.yousician.output_path) # Optional argument, but keep it.
  source_code = data.archive_file.yousician.output_path          # Optional argument, but keep it.
  tags        = {                                                # Optional argument, but keep it.
    "Name"            = "yousician"
    "AppName"         = "Yousician Web App"
    "DeveloperName"   = "Balaji Pothula"
    "DeveloperEmail"  = "balaji@yousician.com"
  }

}

# Creation of AWS Lambda Layer Version for Yousician Lambda Function.
module "yousician_aws_lambda_layer_version" {

  source                   = "./terraform/aws/lambda/layer_version"

  layer_name               = "yousician"                       # Required argument.
  compatible_architectures = ["arm64", "x86_64"]               # Optional argument, but keep it.
  compatible_runtimes      = ["python3.7"]                     # Optional argument, but keep it.
  description              = "Python Library."                 # Optional argument, but keep it.
  filename                 = local.layer_zip                   # Optional argument, conflicts with s3_bucket, s3_key and s3_object_version.
  license_info             = "Apache License 2.0"              # Optional argument, but keep it.
//runtime                  = "python3.7"                       # Optional argument, but keep it.
//s3_bucket                = var.s3_bucket                     # Optional argument, conflicts with filename.
//s3_key                   = var.s3_key                        # Optional argument, conflicts with filename.
//s3_object_version        = var.s3_object_version             # Optional argument, conflicts with filename.
  source_code_hash         = filebase64sha256(local.layer_zip) # Optional argument, but keep it.

}

# Creation of AWS Lambda Function for Yousician.
module "yousician_aws_lambda_function" {

  source                         = "./terraform/aws/lambda/function"

  depends_on                     = [
    module.yousician_aws_s3_bucket,
    module.yousician_aws_s3_bucket_object,
    module.yousician_aws_iam_role_policy_attachment,
    module.yousician_aws_lambda_layer_version,
  ]

  function_name                  = "yousician"                                     # Required argument.
  role                           = module.yousician_aws_iam_role.arn               # Required argument.
  description                    = "Yousician Lambda Function."                    # Optional argument, but keep it.
  environment_variables          = {                                               # Optional argument, but keep it.
    region = data.aws_region.current.name,
    secret = "yousician"
  }
  handler                        = "yousician_lambda_function.lambda_handler"      # Optional argument, but keep it.
  layers                         = [module.yousician_aws_lambda_layer_version.arn] # Optional argument, but keep it.
  memory_size                    = 128                                             # Optional argument, but keep it.
  package_type                   = "Zip"                                           # Optional argument, but keep it.
  publish                        = false                                           # Optional argument, but keep it.
  reserved_concurrent_executions = -1                                              # Optional argument, but keep it.
  runtime                        = "python3.7"                                     # Optional argument, but keep it.
  s3_bucket                      = module.yousician_aws_s3_bucket.id               # Optional argument, but keep it.
  s3_key                         = "${local.yyyymmdd}/${local.yousician_zip}"      # Optional argument, conflicts with filename and image_uri.
  tags                           = {                                               # Optional argument, but keep it.
    "Name"            = "yousician"
    "AppName"         = "Yousician Web App"
    "DeveloperName"   = "Balaji Pothula"
    "DeveloperEmail"  = "balaji@yousician.com"
  }
  timeout                        = 60                                              # Optional argument, but keep it.

}

# Creation of AWS CloudWatch Log Group for Yousician Lambda Function.
module "yousician_aws_cloudwatch_log_group" {

  source            = "./terraform/aws/cloudwatch/log_group"

  depends_on        = [
    module.yousician_aws_lambda_function,
  ]

  name              = "/aws/lambda/${module.yousician_aws_lambda_function.function_name}" # Optional argument, but keep it.
  retention_in_days = 14                                                                  # Optional argument, but keep it.
  tags              = {                                                                   # Optional argument, but keep it.
    "Name"            = "yousician"
    "AppName"         = "Yousician Web App"
    "DeveloperName"   = "Balaji Pothula"
    "DeveloperEmail"  = "balaji@yousician.com"
  }

}

# Creation of AWS API Gateway V2 API for Yousician Lambda Function.
module "yousician_aws_apigatewayv2_api" {

  source        = "./terraform/aws/apigatewayv2/api"

  name          = "yousician" # Required argument.
  protocol_type = "HTTP"      # Required argument.

}

# Creation of AWS API Gateway V2 Stage for Yousician Lambda Function.
module "yousician_aws_apigatewayv2_stage" {

  source      = "./terraform/aws/apigatewayv2/stage"

  depends_on  = [
    module.yousician_aws_apigatewayv2_api,
  ]

  api_id      = module.yousician_aws_apigatewayv2_api.id # Required argument.
  name        = "$default"                               # Required argument.
  auto_deploy = true                                     # Optional argument, but keep it.

}

# Creation of AWS API Gateway V2 Integration for Yousician Lambda Function.
module "yousician_aws_apigatewayv2_integration" {

  source             = "./terraform/aws/apigatewayv2/integration"

  depends_on         = [
    module.yousician_aws_lambda_function,
    module.yousician_aws_apigatewayv2_api,
  ]

  api_id             = module.yousician_aws_apigatewayv2_api.id # Required argument.
  integration_type   = "AWS_PROXY"                              # Required argument.
  integration_uri    = module.yousician_aws_lambda_function.arn # Optional argument, but keep it.
  integration_method = "ANY"                                    # Optional argument, but keep it.

}

# Creation of AWS API Gateway V2 Route for Yousician Lambda Function - Index - Route.
module "yousician_aws_apigatewayv2_route_index" {

  source        = "./terraform/aws/apigatewayv2/route"

  depends_on    = [
    module.yousician_aws_apigatewayv2_api,
    module.yousician_aws_apigatewayv2_integration,
  ]

  api_id        = module.yousician_aws_apigatewayv2_api.id                           # Required argument.
  route_key     = "GET /"                                                            # Required argument.
  target        = "integrations/${module.yousician_aws_apigatewayv2_integration.id}" # Optional argument, but keep it.

}

# Creation of AWS API Gateway V2 Route for Yousician Lambda Function - Put Song - Route.
module "yousician_aws_apigatewayv2_route_put_song" {

  source        = "./terraform/aws/apigatewayv2/route"

  depends_on    = [
    module.yousician_aws_apigatewayv2_api,
    module.yousician_aws_apigatewayv2_integration,
  ]

  api_id        = module.yousician_aws_apigatewayv2_api.id                           # Required argument.
  route_key     = "PUT /song"                                                        # Required argument.
  target        = "integrations/${module.yousician_aws_apigatewayv2_integration.id}" # Optional argument, but keep it.

}

# Creation of AWS API Gateway V2 Route for Yousician Lambda Function - Get Songs - Route.
module "yousician_aws_apigatewayv2_route_get_songs" {

  source        = "./terraform/aws/apigatewayv2/route"

  depends_on    = [
    module.yousician_aws_apigatewayv2_api,
    module.yousician_aws_apigatewayv2_integration,
  ]

  api_id        = module.yousician_aws_apigatewayv2_api.id                           # Required argument.
  route_key     = "GET /songs"                                                       # Required argument.
  target        = "integrations/${module.yousician_aws_apigatewayv2_integration.id}" # Optional argument, but keep it.

}

# Creation of AWS API Gateway V2 Route for Yousician Lambda Function - Put Song Rating - Route.
module "yousician_aws_apigatewayv2_route_put_song_rating" {

  source        = "./terraform/aws/apigatewayv2/route"

  depends_on    = [
    module.yousician_aws_apigatewayv2_api,
    module.yousician_aws_apigatewayv2_integration,
  ]

  api_id        = module.yousician_aws_apigatewayv2_api.id                           # Required argument.
  route_key     = "PUT /song/rating"                                                 # Required argument.
  target        = "integrations/${module.yousician_aws_apigatewayv2_integration.id}" # Optional argument, but keep it.

}

# Creation of AWS API Gateway V2 Route for Yousician Lambda Function - Get Song Rating - Route.
module "yousician_aws_apigatewayv2_route_get_song_rating" {

  source        = "./terraform/aws/apigatewayv2/route"

  depends_on    = [
    module.yousician_aws_apigatewayv2_api,
    module.yousician_aws_apigatewayv2_integration,
  ]

  api_id        = module.yousician_aws_apigatewayv2_api.id                           # Required argument.
  route_key     = "GET /song/rating/{songId}"                                        # Required argument.
  target        = "integrations/${module.yousician_aws_apigatewayv2_integration.id}" # Optional argument, but keep it.

}

# Creation of AWS API Gateway V2 Route for Yousician Lambda Function - Get Songs Search - Route.
module "yousician_aws_apigatewayv2_route_get_songs_search" {

  source        = "./terraform/aws/apigatewayv2/route"

  depends_on    = [
    module.yousician_aws_apigatewayv2_api,
    module.yousician_aws_apigatewayv2_integration,
  ]

  api_id        = module.yousician_aws_apigatewayv2_api.id                           # Required argument.
  route_key     = "GET /songs/search"                                                # Required argument.
  target        = "integrations/${module.yousician_aws_apigatewayv2_integration.id}" # Optional argument, but keep it.

}

# Creation of AWS API Gateway V2 Route for Yousician Lambda Function - Get Songs Average Difficulty - Route.
module "yousician_aws_apigatewayv2_route_get_songs_avg_difficulty" {

  source        = "./terraform/aws/apigatewayv2/route"

  depends_on    = [
    module.yousician_aws_apigatewayv2_api,
    module.yousician_aws_apigatewayv2_integration,
  ]

  api_id        = module.yousician_aws_apigatewayv2_api.id                           # Required argument.
  route_key     = "GET /songs/avg/difficulty"                                        # Required argument.
  target        = "integrations/${module.yousician_aws_apigatewayv2_integration.id}" # Optional argument, but keep it.

}

# Creation of AWS Lambda Permission to invoke Yousician Lambda Function by AWS API Gateway V2.
module "yousician_aws_lambda_permission" {

  source        = "./terraform/aws/lambda/permission"

  depends_on    = [
    module.yousician_aws_lambda_function,
    module.yousician_aws_apigatewayv2_api,
  ]

  action        = "lambda:InvokeFunction"                                      # Required argument.
  function_name = module.yousician_aws_lambda_function.function_name           # Required argument.
  principal     = "apigateway.amazonaws.com"                                   # Required argument.
  statement_id  = "AllowExecutionFromAPIGateway"                               # Optional argument.
  source_arn    = "${module.yousician_aws_apigatewayv2_api.execution_arn}/*/*" # Optional argument.

}


# Creation of Amazon Aurora Serverless PostgreSQL
# Relational Database RDS Cluster for Yousician Lambda Function.
module "yousician_aws_rds_cluster" {

  source                       = "./terraform/aws/rds/cluster"

  allow_major_version_upgrade  = true                                      # Optional argument, but keep it.
  apply_immediately            = true                                      # Optional argument, but keep it.
  backup_retention_period      = 1                                         # Optional argument, but keep it.
  cluster_identifier           = "yousician"                               # Optional argument, but keep it.
  copy_tags_to_snapshot        = true                                      # Optional argument, but keep it.
  database_name                = var.database_name                         # Optional argument, but keep it.
  deletion_protection          = false                                     # Optional argument, but keep it.
  enable_http_endpoint         = true                                      # Optional argument, but keep it.
  engine                       = "aurora-postgresql"                       # Optional argument, but keep it.
  engine_mode                  = "serverless"                              # Optional argument, but keep it.
  engine_version               = "10.14"                                   # Optional argument, but keep it.
  final_snapshot_identifier    = "yousician-snapshot-at-${local.datetime}" # Optional argument, but keep it.
  master_password              = var.master_password                       # Required argument.
  master_username              = var.master_username                       # Required argument.
  port                         = "5432"                                    # Optional argument, but keep it.
  preferred_backup_window      = "00:00-00:59"                             # Optional argument, but keep it.
  preferred_maintenance_window = "sun:01:00-sun:02:00"                     # Optional argument, but keep it.
  skip_final_snapshot          = true                                      # Optional argument, but keep it.
  storage_encrypted            = true                                      # Optional argument, but keep it.
  tags                         = {                                         # Optional argument, but keep it.
    "Name"            = "yousician"
    "AppName"         = "Yousician Web App"
    "DeveloperName"   = "Balaji Pothula"
    "DeveloperEmail"  = "balaji@yousician.com"
  }

}

# Creation of AWS Secrets Manager Secret for
# Amazon Aurora Serverless PostgreSQL Relational Database RDS Cluster.
module "yousician_aws_secretsmanager_secret" {

  source                         = "./terraform/aws/secretsmanager/secret"

  depends_on                     = [
    module.yousician_aws_rds_cluster,
  ]

  description                    = "Yousician Secrets Manager" # Optional argument, but keep it.
  force_overwrite_replica_secret = false                       # Optional argument, but keep it.
  name                           = "yousician"                 # Optional argument, conflicts with name_prefix.
  recovery_window_in_days        = 7                           # Optional argument, but keep it.
  tags                           = {                           # Optional argument, but keep it.
    "Name"            = "yousician"
    "AppName"         = "Yousician Web App"
    "DeveloperName"   = "Balaji Pothula"
    "DeveloperEmail"  = "balaji@yousician.com"
  }

}

# Creation of AWS Secrets Manager Version for
# Amazon Aurora Serverless PostgreSQL Relational Database RDS Cluster.
module "yousician_aws_secretsmanager_secret_version" {

  source        = "./terraform/aws/secretsmanager/secret_version"

  depends_on    = [
    module.yousician_aws_secretsmanager_secret,
    module.yousician_aws_rds_cluster,
  ]

  secret_id     = module.yousician_aws_secretsmanager_secret.id # Required argument.
  secret_string = jsonencode({                                  # Optional argument, but required if secret_binary is not set.                             
    dbInstanceIdentifier = module.yousician_aws_rds_cluster.id
    engine               = module.yousician_aws_rds_cluster.engine
    host                 = module.yousician_aws_rds_cluster.endpoint
    port                 = module.yousician_aws_rds_cluster.port
    resourceId           = module.yousician_aws_rds_cluster.cluster_resource_id
    database             = var.database_name
    username             = var.master_username
    password             = var.master_password
    dialect              = "postgresql"
    driver               = "psycopg2"
    schema               = "public"
    echo                 = "False"
    connect_timeout      = 30
  }) 

}


# Creation of AWS VPC Endpoint for Yousician Lambda Function
# to access AWS Secrets Manager service.
module "yousician_aws_vpc_endpoint" {

  source              = "./terraform/aws/vpc/endpoint"

  service_name        = "com.amazonaws.${data.aws_region.current.name}.secretsmanager" # Required argument.
  vpc_id              = data.aws_vpc.default.id                                        # Required argument.
  private_dns_enabled = true                                                           # Optional argument, but applicable for endpoints of type Interface.
  subnet_ids          = data.aws_subnet_ids.available.ids                              # Optional argument, but applicable for endpoints of type GatewayLoadBalancer and Interface.
  security_group_ids  = data.aws_security_groups.default.ids                           # Optional argument, but required for endpoints of type Interface.
  tags                = {                                                              # Optional argument, but keep it.
    "Name"            = "yousician_secretsmanager"
    "AppName"         = "Yousician Web App"
    "DeveloperName"   = "Balaji Pothula"
    "DeveloperEmail"  = "balaji@yousician.com"
  }
  vpc_endpoint_type   = "Interface"                                                    # Optional argument, but keep it.

}


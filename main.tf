/*
provider "github" {

  owner = "balan.pothula@gmail.com"
  token = var.token_github

}

data "github_actions_secrets" "webapp" {
  full_name = "balajipothula/webapp"
}
*/
# terraform provider information.
provider "aws" {

  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key

}

# Data Source: aws_region
data "aws_region" "current" {
}

# Data Source: aws_caller_identity
data "aws_caller_identity" "current" {
}

# Data Source: aws_partition
data "aws_partition" "current" {}

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
  owners      = ["self"]
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
  datetime   = formatdate("YYYY-MM-DD-hh-mm-ss", local.timestamp)
  layer_zip  = "./python/lib/layer.zip"
  webapp_src = "./python/src/lambda_function.py"
  webapp_zip = "webapp-${local.datetime}.zip"
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
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH inbound traffic rule."
    protocol    = "tcp"
    to_port     = 22
    from_port   = 22
  }

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
    description = "NFS inbound traffic rule."
    protocol    = "tcp"
    to_port     = 2049
    from_port   = 2049
  }

  ingress {
    cidr_blocks = [for subnet in data.aws_subnet.default : subnet.cidr_block]
    description = "PostgreSQL inbound traffic rule."
    protocol    = "tcp"
    to_port     = 5432
    from_port   = 5432
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "Jenkins inbound traffic rule."
    protocol    = "tcp"
    to_port     = 8080
    from_port   = 8080
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "All outbound traffic rule."
    protocol    = "all"
    to_port     = 0
    from_port   = 0
  }

}

/*
# Creation of AWS EFS (Elastic File System) for WebApp.
module "webapp_aws_efs_file_system" {

  source                                = "./terraform/aws/efs/file_system"

//availability_zone_name                = "eu-central-1a"                         # Optional argument, but comment it for Region wise spread of EFS.
  creation_token                        = "webapp"                                # Optional argument, but keep it.
  encrypted                             = false                                   # Optional argument, but keep it.
//kms_key_id                            = var.kms_key_id                          # Optional argument, but required if encrypted set true.
/*
  lifecycle_policy {                                                              # Optional block, but keep it.
    transition_to_ia                    = var.transition_to_ia                    # Optional block argument, but keep it.
    transition_to_primary_storage_class = var.transition_to_primary_storage_class # Optional block argument, but keep it.
  }

  performance_mode                      = "generalPurpose"                        # Optional argument, but keep it.
//provisioned_throughput_in_mibps       = 8                                       # Optional argument, but only applicable with throughput_mode set to provisioned.
  tags                                  = {                                       # Optional argument, but keep it.
    "Name"           = "WebApp"
    "AppName"        = "WebApp"
    "DeveloperName"  = "Balaji Pothula"
    "DeveloperEmail" = "balan.pothula@gmail.com"
  }
//throughput_mode                       = var.throughput_mode                     # Optional argument, if value is provisioned, it will impact provisioned_throughput_in_mibps.

}
*/

/*
# Mounting of AWS EFS (Elastic File System) target for WebApp.
module "webapp_aws_efs_mount_target" {

  source          = "./terraform/aws/efs/mount_target"

  depends_on      = [
    module.webapp_aws_efs_file_system,
  ]

  for_each        = data.aws_subnet_ids.available.ids

  file_system_id  = module.webapp_aws_efs_file_system.id # Required argument.
  subnet_id       = each.key                             # Required argument.
//ip_address      = var.ip_address                       # Optional argument, but keep it.
  security_groups = data.aws_security_groups.default.ids # Optional argument, but keep it.

}
*/

/*
# Creation of AWS EC2 (Elastic Compute Cloud) Instance for WebApp.
module "webapp_aws_instance" {

  source                               = "./terraform/aws/instance"

  ami                                  = lookup(var.ami_map, var.region) # Optional argument, but keep it.
//ami                                  = "ami-00e232b942edaf8f9"         # Optional argument, but keep it.
//associate_public_ip_address          = false                           # Optional argument, but keep it.
//availability_zone                    = "eu-central-1a"                 # Optional argument, but keep it.
//cpu_core_count                       = 1                               # Optional argument, will cause the resource to be destroyed and re-created.
//cpu_threads_per_core                 = 1                               # Optional argument, will cause the resource to be destroyed and re-created.
//disable_api_termination              = false                           # Optional argument, but keep it.
//ebs_optimized                        = false                           # Optional argument, but keep it.
/*
  ebs_block_device                     = [{                              # Optional block, but keep it.
      delete_on_termination            = true                            # Optional block argument, but keep it.
      device_name                      = "/dev/xvda"                     # Optional block argument, but keep it.
      encrypted                        = false                           # Optional block argument, but keep it.
      volume_size                      = 8                               # Optional block argument, but keep it.
      volume_type                      = "gp2"                           # Optional block argument, but keep it.
  }]

//hibernation                          = false                           # Optional argument, but keep it.
//instance_initiated_shutdown_behavior = "stop"                          # Optional argument, but keep it.
  instance_type                        = "t2.micro"                      # Optional argument, but keep it.
//ipv6_address_count                   = 1                               # Optional argument, but keep it.
  key_name                             = "Terraform"                     # Optional argument, but keep it.
  monitoring                           = false                           # Optional argument, but keep it.

  root_block_device                    = [{                              # Optional block, but keep it.
      delete_on_termination            = true                            # Optional block argument, but keep it.
      device_name                      = "/dev/xvda"                     # Optional block argument, but keep it.
      encrypted                        = false                           # Optional block argument, but keep it.
      iops                             = 100                             # Optional block argument, but keep it.
      throughput                       = 0                               # Optional block argument, but keep it.
      volume_size                      = 8                               # Optional block argument, but keep it.
      volume_type                      = "gp2"                           # Optional block argument, but keep it.
  }]

/*
  security_groups                      = [                               # Optional argument, but keep it.
    "default",
  ]

//subnet_id                            = "subnet-a54b1ecf"               # Optional argument, but keep it.

  tags                                 = {                               # Optional argument, but keep it.
    "Name"           = "WebApp"
    "AppName"        = "WebApp"
    "DeveloperName"  = "Balaji Pothula"
    "DeveloperEmail" = "balan.pothula@gmail.com"
  }

//tenancy                              = "default"                       # Optional argument, but keep it.
  user_data                            = file("./shell/user_data.sh")    # Optional argument, but keep it.

  vpc_security_group_ids               = [                               # Optional argument, but keep it.
    "sg-086a967f",
  ]          

}
*/

# Creation of AWS IAM Role for WebApp Lambda Function.
module "webapp_aws_iam_role" {

  source                = "./terraform/aws/iam/role"

  assume_role_policy    = file("./json/WebAppLambdaIAMRole.json") # Required argument.
  description           = "AWS IAM Role for WebApp Lambda."       # Optional argument, but keep it.
  force_detach_policies = true                                    # Optional argument, but keep it.
  name                  = "WebAppLambdaIAMRole"                   # Optional argument, but keep it.

}

# Creation of AWS IAM Policy for WebApp Lambda Function.
module "webapp_aws_iam_policy" {

  source      = "./terraform/aws/iam/policy"

  description = "AWS IAM Policy for WebApp Lambda."       # Optional argument, but keep it.
  name        = "WebAppLambdaIAMPolicy"                   # Optional argument, but keep it.
  path        = "/"                                       # Optional argument, but keep it.
  policy      = file("./json/WebAppLambdaIAMPolicy.json") # Required argument.

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

# Creation of AWS S3 Bucket for WebApp Lambda Function.
# Creation of AWS S3 Bucket for WebApp RDS Credentials Rotator Lambda Function.
module "webapp_aws_s3_bucket" {

  source = "./terraform/aws/s3/bucket"

  bucket = "webapp-aws-lambda-src-s3-bucket"     # Optional argument, but keep it.
  acl    = "private"                             # Optional argument, but keep it.
  policy = file("./json/WebAppS3IAMPolicy.json") # Optional argument, but keep it.
  tags   = {                                     # Optional argument, but keep it.
    "Name"            = "WebApp"
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
  compatible_runtimes      = ["python3.7"]                     # Optional argument, but keep it.
  description              = "Python Library."                 # Optional argument, but keep it.
  filename                 = local.layer_zip                   # Optional argument, conflicts with s3_bucket, s3_key and s3_object_version.
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
  //module.webapp_aws_secretsmanager_secret,
  ]

  function_name                  = "webapp"                                     # Required argument.
  role                           = module.webapp_aws_iam_role.arn               # Required argument.
  description                    = "WebApp Lambda Function"                     # Optional argument, but keep it.
  environment_variables          = {                                            # Optional argument, but keep it.
    region = data.aws_region.current.name,
  //secret = module.webapp_aws_secretsmanager_secret.id
  }
  handler                        = "lambda_function.lambda_handler"             # Optional argument, but keep it.
  layers                         = [module.webapp_aws_lambda_layer_version.arn] # Optional argument, but keep it.
  memory_size                    = 128                                          # Optional argument, but keep it.
  package_type                   = "Zip"                                        # Optional argument, but keep it.
  publish                        = false                                        # Optional argument, but keep it.
  reserved_concurrent_executions = -1                                           # Optional argument, but keep it.
  runtime                        = "python3.7"                                  # Optional argument, but keep it.
  s3_bucket                      = module.webapp_aws_s3_bucket.id               # Optional argument, but keep it.
  s3_key                         = "${local.yyyymmdd}/${local.webapp_zip}"      # Optional argument, conflicts with filename and image_uri.
  tags                           = {                                            # Optional argument, but keep it.
    "Name"            = "webapp"
    "AppName"         = "Python FastAPI Web App"
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
  retention_in_days = 14                                                               # Optional argument, but keep it.
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

  action        = "lambda:InvokeFunction"                                   # Required argument.
  function_name = module.webapp_aws_lambda_function.function_name           # Required argument.
  principal     = "apigateway.amazonaws.com"                                # Required argument.
  statement_id  = "AllowExecutionFromAPIGateway"                            # Optional argument.
  source_arn    = "${module.webapp_aws_apigatewayv2_api.execution_arn}/*/*" # Optional argument.

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
  engine_mode                  = "serverless"                              # Optional argument, but keep it.
  engine_version               = "10.14"                                   # Optional argument, but keep it.
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

# Creation of AWS Secrets Manager Secret for
# Amazon Aurora Serverless PostgreSQL Relational Database RDS Cluster.
module "webapp_aws_secretsmanager_secret" {

  source                         = "./terraform/aws/secretsmanager/secret"

  depends_on                     = [
    module.webapp_aws_rds_cluster,
  ]

  description                    = "WebApp Secrets Manager"    # Optional argument, but keep it.
  force_overwrite_replica_secret = false                       # Optional argument, but keep it.
  name                           = "webapplication_secret"     # Optional argument, conflicts with name_prefix.
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
    module.webapp_aws_rds_cluster,
  ]

  secret_id     = module.webapp_aws_secretsmanager_secret.id # Required argument.
  secret_string = jsonencode({                               # Optional argument, but required if secret_binary is not set.                             
    dbInstanceIdentifier = module.webapp_aws_rds_cluster.id
    engine               = module.webapp_aws_rds_cluster.engine
    host                 = module.webapp_aws_rds_cluster.endpoint
    port                 = module.webapp_aws_rds_cluster.port
    resourceId           = module.webapp_aws_rds_cluster.cluster_resource_id
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

# Creation of AWS VPC Endpoint for WebApp Lambda Function
# to access AWS Secrets Manager service.
module "webapp_aws_vpc_endpoint" {

  source              = "./terraform/aws/vpc/endpoint"

  service_name        = "com.amazonaws.${data.aws_region.current.name}.secretsmanager" # Required argument.
  vpc_id              = data.aws_vpc.default.id                                        # Required argument.
  private_dns_enabled = true                                                           # Optional argument, but applicable for endpoints of type Interface.
  subnet_ids          = data.aws_subnet_ids.available.ids                              # Optional argument, but applicable for endpoints of type GatewayLoadBalancer and Interface.
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
# Creation of AWS ECR (Elastic Container Registry) Repository for WebApp.
module "webapp_aws_ecr_repository" {

  source                       = "./terraform/aws/ecr/repository"

  name                         = "webapp"    # Required argument.

  encryption_configuration     = [{          # Optional configuration block, but keep it.
      encryption_type = "AES256"             # Optional block argument but keep it.
    //kms_key         = ""                   # Optional block argument, but will become mandatory when encryption_type is KMS.
  }]

  image_tag_mutability         = "IMMUTABLE" # Optional argument, but keep it.

  image_scanning_configuration = [{          # Optional configuration block, but keep it. 
      scan_on_push = true                    # Required block argument.
  }]

  tags                         = {           # Optional argument, but keep it.
    "Name"            = "WebApp"
    "AppName"         = "Python FastAPI Web App"
    "DeveloperName"   = "Balaji Pothula"
    "DeveloperEmail"  = "balan.pothula@gmail.com"
  }

}

/*
# Creation of AWS ECS  (Elastic Container Service) Cluster for WebApp.
module "webapp_aws_ecs_cluster" {

  source                             = "./terraform/aws/ecs/cluster"

  name                               = "webapp" # Required argument.

  capacity_providers                 = [        # Optional argument, but keep it.
    "FARGATE",
  ]
/*
  configuration                      = [{       # Optional configuration block, but keep it.

    execute_command_configuration = [{          # Optional configuration block, but keep it.

      kms_key_id        = null                  # Optional argument, but keep it.
      logging           = "OVERRIDE"            # Optional block argument, but keep it.

      log_configuration = [{                    # Optional configuration block, but keep it.
        cloud_watch_encryption_enabled = false  # Optional block argument, but keep it.
        cloud_watch_log_group_name     = null   # Optional block argument, but keep it.
        s3_bucket_name                 = null   # Optional block argument, but keep it.
        s3_bucket_encryption_enabled   = null   # Optional block argument, but keep it.
        s3_key_prefix                  = null   # Optional block argument, but keep it.
      }]

    }]

  }]

  default_capacity_provider_strategy = [{       # Optional configuration block.
    capacity_provider = "webapp"                # Required block argument.
    weight            = 50                      # Optional block argument.
    base              = 3                       # Optional block argument.
  }]

  setting                            = [{       # Optional configuration block, but keep it.
    name  = "containerInsights"                 # Required block argument.
    value = "disabled"                          # Required block argument.
  }]

  tags                               = {        # Optional argument, but keep it.
    "Name"            = "WebApp"
    "AppName"         = "Python FastAPI Web App"
    "DeveloperName"   = "Balaji Pothula"
    "DeveloperEmail"  = "balan.pothula@gmail.com"
  }

}

*/

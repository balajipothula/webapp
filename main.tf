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

locals {
  timestamp = timestamp()
  yyyy      = formatdate("YYYY",                local.timestamp)
  mm        = formatdate("MM",                  local.timestamp)
  dd        = formatdate("DD",                  local.timestamp)    
  date      = formatdate("YYYY.MM.DD",          local.timestamp)
  datetime  = formatdate("YYYY-MM-DD-hh-mm-ss", local.timestamp)
  root      = path.root
  absroot   = abspath(path.root)
}

#  WebApp AWS S3 Bucket Creation Module.
module "webapp_aws_s3_bucket" {

  source = "./terraform/aws/s3/bucket"

  bucket = "webapp-aws-s3-bucket"                # Optional argument but keep it.
  acl    = "private"                             # Optional argument but keep it.
  policy = file("./json/WebAppS3IAMPolicy.json") # Optional argument but keep it.

  tags   = {                                     # Optional argument but keep it.
    "AppName"        = "WebApp"
    "Division"       = "Platform"
    "DeveloperName"  = "Balaji Pothula"
    "DeveloperEmail" = "balan.pothula@gmail.com"
  }

}

#  WebApp AWS S3 Bucket Object Creation Module.
module "webapp_aws_s3_bucket_object" {

  source     = "./terraform/aws/s3/bucket_object"

  depends_on = [
    module.webapp_aws_s3_bucket,
  ]

  bucket     = module.webapp_aws_s3_bucket.id            # Required argument.
  key        = "/${local.yyyy}/${local.mm}/${local.dd}/" # Required argument.
  acl        = "private"                                 # Optional argument but keep it.
  content    = file("./terraform/lambda_function.py")    # Optional argument but keep it.
//source     = "./python/lambda_function.py"             # Optional argument but keep it.
  etag       = filemd5("./terraform/lambda_function.py") # Optional argument but keep it.
  tags       = {                                         # Optional argument but keep it.
    "AppName"        = "WebApp"
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

  source     = "./terraform/aws/iam/role_policy_attachment"

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

  function_name                  = "webapp"                         # Required argument.
  role                           = module.webapp_aws_iam_role.arn   # Required argument.
  description                    = "WebApp Lambda Function."        # Optional argument but keep it.
  handler                        = "lambda_function.lambda_handler" # Optional argument but keep it.
  memory_size                    = 128                              # Optional argument but keep it.
  package_type                   = "Zip"                            # Optional argument but keep it.
  publish                        = false                            # Optional argument but keep it.
  reserved_concurrent_executions = -1                               # Optional argument but keep it.
  runtime                        = "python3.8"                      # Optional argument but keep it.
  s3_bucket                      = module.webapp_aws_s3_bucket.id   # Optional argument but keep it.
  s3_key                         = "2022/01/23/webapp.zip"          # Optional argument but keep it, Conflicts with filename and image_uri.
  tags                           = {                                # Optional argument but keep it.
    "AppName"        = "WebAppFastAPI"
    "Division"       = "Platform"
    "DeveloperName"  = "Balaji Pothula"
    "DeveloperEmail" = "balan.pothula@gmail.com"
  }
  timeout                        = 30                               # Optional argument but keep it.

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
/*
#  WebApp AWS RDS Cluster Creation Module.
module "webapp_aws_rds_cluster" {

  source                              = "./terraform/aws/rds/cluster"

  allow_major_version_upgrade         = true                                   # Optional argument but keep it.
  apply_immediately                   = true                                   # Optional argument but keep it.
  backup_retention_period             = 1                                      # Optional argument but keep it.
  cluster_identifier                  = "webapp"                               # Optional argument but keep it.
  copy_tags_to_snapshot               = true                                   # Optional argument but keep it.
  database_name                       = "webapp_db"                            # Optional argument but keep it.
  deletion_protection                 = false                                  # Optional argument but keep.
  enable_http_endpoint                = true                                   # Optional argument but keep it.
  engine                              = "aurora-postgresql"                    # Optional argument but keep it.
  engine_mode                         = "serverless"                           # Optional argument but keep it.
  engine_version                      = "10.14"                                # Optional argument but keep it.
  final_snapshot_identifier           = "webapp-snapshot-at-${local.datetime}" # Optional argument but keep it.
  master_password                     = "WebApp#2022"                          # Required argument.
  master_username                     = "webapp"                               # Required argument.
  port                                = "5432"                                 # Optional argument but keep it.
  preferred_backup_window             = "01:00-02:00"                          # Optional argument but keep it.
  preferred_maintenance_window        = "sun:01:00-sun:02:00"                  # Optional argument but keep it.
  skip_final_snapshot                 = true                                   # Optional argument but keep it.
  storage_encrypted                   = true                                   # Optional argument but keep it.
  tags                                = {                                      # Optional argument but keep it.
    "AppName"           = "Generic"
    "Division"          = "Data Quality"
    "Developer"         = "Balaji Pothula"
    "DeveloperEmail"    = "Balaji.Pothula@techie.com"
    "Manager"           = "Ram"
    "ManagerEmail"      = "Ram@techie.com"
    "ServiceOwner"      = "Ali"
    "ServiceOwnerEmail" = "Ali@techie.com"
    "ProductOwner"      = "Raj"
    "ProductOwnerEmail" = "Raj@techie.com"
  }

}
*/
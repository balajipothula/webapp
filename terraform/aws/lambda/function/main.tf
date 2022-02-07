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

# Resource  type : aws_lambda_function
# Resource  name : generic
# Attribute name : function_name
# Argument       : var.function_name
# Variable  name : function_name
resource "aws_lambda_function" "generic" {

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

  dynamic "environment" {
    for_each = length(keys(var.environment_variables)) == 0 ? [] : [true]
    content {
      variables = var.environment_variables
    }
  }

/*
  file_system_config {                                                  # Optional argument block.
    arn                          = var.efs_arn                          # Required block argument.
    local_mount_path             = var.local_mount_path                 # Required block argument.
  }
*/
//filename                       = var.filename                         # Optional argument, conflicts with image_uri, s3_bucket, s3_key, and s3_object_version.
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
  layers                         = var.layers                           # Optional argument.
  memory_size                    = var.memory_size                      # Optional argument but keep it.
  package_type                   = var.package_type                     # Optional argument but keep it.
  publish                        = var.publish                          # Optional argument but keep it.
  reserved_concurrent_executions = var.reserved_concurrent_executions   # Optional argument but keep it.
  runtime                        = var.runtime                          # Optional argument but keep it.
  s3_bucket                      = var.s3_bucket                        # Optional argument but keep it.
  s3_key                         = var.s3_key                           # Optional argument but keep it, conflicts with filename and image_uri.
//s3_object_version              = var.s3_object_version                # Optional argument, conflicts with filename and image_uri.
//source_code_hash               = var.source_code_hash                 # Optional argument.
  tags                           = var.tags                             # Optional argument but keep it.
  timeout                        = var.timeout                          # Optional argument but keep it.
/*
  tracing_config {                                                      # Optional argument block.
    mode                         = var.mode                             # Required block argument.
  }
*/

  vpc_config {                                                          # Optional argument block but keep it.
    security_group_ids           = data.aws_security_groups.default.ids # Required block argument.
    subnet_ids                   = data.aws_subnet_ids.available.ids    # Required block argument.
  }

}

# Data Source: aws_region
data "aws_region" "current" {
}

data "aws_vpc" "default" {
}

# Data Source: aws_subnet_ids
data "aws_subnet_ids" "available" {
  vpc_id = data.aws_vpc.default.id
}

# Declare the local values.
locals {
  local_tags = {
    Name        = (var.Name        != "" ? var.Name        : "Current Lambda Function")
    Environment = (var.Environment != "" ? var.Environment : "Development")
  }
  tags = merge(var.variable_tags, local.local_tags)
}

# Resource  type : aws_lambda_function
# Resource  name : current
# Attribute name : function_name
# Argument       : var.function_name
# Variable  name : function_name
resource "aws_lambda_function" "current" {

  function_name                  = var.function_name                  # Required argument.
  role                           = var.role                           # Required argument.
//architectures                  = var.architectures                  # Optional argument.
//code_signing_config_arn        = var.code_signing_config_arn        # Optional argument.
/*
  dead_letter_config {                                                # Optional argument block.
    target_arn                   = var.target_arn                     # Required block argument.
  }
*/
  description                    = var.aws_lambda_function__description                    # Optional argument but keep it.

  environment {                                                       # Optional argument block but keep it.
    variables                    = var.variables                      # Optional block argument.
  }
/*
  file_system_config {                                                # Optional argument block.
    arn                          = var.efs_arn                        # Required block argument.
    local_mount_path             = var.local_mount_path               # Required block argument.
  }
*/
//filename                       = var.filename                       # Optional argument, Conflicts with image_uri, s3_bucket, s3_key, and s3_object_version.
  handler                        = var.handler                        # Optional argument but keep it.
/*
  image_config {                                                      # Optional argument block.
    command                      = var.command                        # Optional block argument.
    entry_point                  = var.entry_point                    # Optional block argument.
    working_directory            = var.working_directory              # Optional block argument.
  }
*/
//image_uri                      = var.image_uri                      # Conflicts with filename, s3_bucket, s3_key, and s3_object_version.
//kms_key_arn                    = var.kms_key_arn                    # Optional argument.
//layers                         = var.layers                         # Optional argument.
  memory_size                    = var.memory_size                    # Optional argument but keep it.
  package_type                   = var.package_type                   # Optional argument but keep it.
  publish                        = var.publish                        # Optional argument but keep it.
  reserved_concurrent_executions = var.reserved_concurrent_executions # Optional argument but keep it.
  runtime                        = var.runtime                        # Optional argument but keep it.
  s3_bucket                      = var.s3_bucket                      # Optional argument but keep it.
  s3_key                         = var.s3_key                         # Optional argument but keep it, Conflicts with filename and image_uri.
//s3_object_version              = var.s3_object_version              # Optional argument, Conflicts with filename and image_uri.
//source_code_hash               = var.source_code_hash               # Optional argument.
  tags                           = local.tags                         # Optional argument but keep it.
  timeout                        = var.timeout                        # Optional argument but keep it.
/*
  tracing_config {                                                    # Optional argument block.
    mode                         = var.mode                           # Required block argument.
  }
*/
  vpc_config {                                                        # Optional argument block but keep it.
  //subnet_ids                   = var.subnet_ids                     # Required block argument.
    subnet_ids                   = data.aws_subnet_ids.available.ids  # Required block argument.
    security_group_ids           = var.security_group_ids             # Required block argument.
  }

}
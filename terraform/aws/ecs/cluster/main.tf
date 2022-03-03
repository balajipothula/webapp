# Resource  type : aws_ecs_cluster
# Resource  name : generic
# Attribute name : name
# Argument       : var.name
# Variable  name : name
resource "aws_ecs_cluster" "job_log_web_ui_cluster" {

  capacity_providers                   = var.capacity_providers             # Optional argument, but keep it.

  configuration {                                                           # Optional configuration block, but keep it.
    execute_command_configuration {                                         # Optional configuration block, but keep it.
      kms_key_id                       = var.kms_key_id                     # Optional argument, but keep it.
      log_configuration {                                                   # Optional configuration block, but keep it.
        cloud_watch_encryption_enabled = var.cloud_watch_encryption_enabled # Optional block argument, but keep it.
      //cloud_watch_log_group_name     = var.cloud_watch_log_group_name     # Optional block argument, but keep it.
        s3_bucket_name                 = var.s3_bucket_name                 # Optional block argument, but keep it.
        s3_bucket_encryption_enabled   = var.s3_bucket_encryption_enabled   # Optional block argument, but keep it.
        s3_key_prefix                  = var.s3_key_prefix                  # Optional block argument, but keep it.
      }
      logging                          = var.logging                        # Optional block argument, but keep it.
    }
  }

/*
  default_capacity_provider_strategy {                                      # Optional configuration block.
    capacity_provider                 = var.capacity_provider               # Required block argument.
    weight                            = var.weight                          # Optional block argument.
    base                              = var.base                            # Optional block argument.
  }
*/

  name                                = var.name                            # Required argument.

  setting {                                                                 # Optional configuration block, but keep it.
    name                              = var.setting_name                    # Required block argument.
    value                             = var.setting_value                   # Required block argument.
  }

  tags                                = var.tags                            # Optional argument but keep it.

}

# Resource  type : aws_ecs_cluster
# Resource  name : generic
# Attribute name : name
# Argument       : var.name
# Variable  name : name
resource "aws_ecs_cluster" "generic" {

  name                                 = var.name                           # Required argument.

  capacity_providers                   = var.capacity_providers             # Optional argument, but keep it.

  dynamic "configuration" {
    for_each = var.configuration
    content {
    }
  }

  dynamic "default_capacity_provider_strategy" {                            # Optional configuration block.
    for_each = var.default_capacity_provider_strategy                       # Reading all default_capacity_provider_strategy configurations.
    content {
      capacity_provider = var.capacity_provider                             # Required block argument.
      weight            = var.weight                                        # Optional block argument.
      base              = var.base                                          # Optional block argument.
    }   
  }

  dynamic "setting" {                                                       # Optional block, but keep it.
    for_each = var.setting                                                  # Reading all setting configurations.
    content {
      name  = var.setting_name                                              # Required block argument.
      value = var.setting_value                                             # Required block argument.
    }
  }

  tags                                = var.tags                            # Optional argument but keep it.

}

# exoscale provider information.
terraform {

  # Terraform binary version.
  required_version = "1.4.5"

  required_providers {

    exoscale = {
      source  = "exoscale/exoscale"
      version = "0.48.0"
    }

  }

}

/*
 * Resource type  : exoscale_database
 * Resource name  : generic
 * Attribute name : zone
 * Argument name  : var.zone
 * Variable name  : zone
 */
resource "exoscale_database" "generic" {

  zone                   = var.zone                   # Required argument, ❗ modification creates new resource.
  name                   = var.name                   # Required argument, ❗ modification creates new resource.
  type                   = var.type                   # Required argument, ❗ modification creates new resource.
  plan                   = var.plan                   # Required argument.
  maintenance_dow        = var.maintenance_dow        # Optional argument, ✓ but keep it.
  maintenance_time       = var.maintenance_time       # Optional argument, ✓ but keep it.
  termination_protection = var.termination_protection # Optional argument, ✓ but keep it.
  # Optional block, MySQL Database service type specific arguments. 
  dynamic "mysql" {
    # Reading all mysql configurations.
    for_each = var.mysql_block
    content {
      admin_username  = mysql.value.admin_username  # Optional `mysql` block argument, ✓ but keep it.
      admin_password  = mysql.value.admin_password  # Optional `mysql` block argument, ✓ but keep it.
      backup_schedule = mysql.value.backup_schedule # Optional `mysql` block argument, ✓ but keep it.
      ip_filter       = mysql.value.ip_filter       # Optional `mysql` block argument, ✓ but keep it.
      mysql_settings  = mysql.value.mysql_settings  # Optional `mysql` block argument, ✓ but keep it.
      version         = mysql.value.mysql_version   # Optional `mysql` block argument, ✓ but keep it.
    }
  }
  # Operation Timeouts:
  # `timeouts` block arguments allows you to customize how long
  # certain operations are allowed to take before being considered to have failed.
  timeouts {
    create = "5m"
    delete = "5m"
    read   = "5m"
    update = "5m"
  }

}

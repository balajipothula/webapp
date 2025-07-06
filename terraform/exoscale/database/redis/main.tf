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
  # Optional block, REDIS (REmote DIctionary Server) Database service type specific arguments.
  dynamic "redis" {
    # Reading all redis configurations.
    for_each = var.redis_block
    content {
      ip_filter      = redis.value.ip_filter      # Optional `redis` block argument, ✓ but keep it.
      redis_settings = redis.value.redis_settings # Optional `redis` block argument, ✓ but keep it.
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

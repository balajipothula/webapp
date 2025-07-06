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
 * Data Source type : exoscale_domain_record
 * Data Source name : generic
 * Attribute name   : name
 * Argument name    : var.name
 * Variable name    : name
 */
data "exoscale_domain_record" "generic" {
  name = var.name    # Required argument.
  dynamic "filter" { # Required block.

    for_each = var.filter # Reading all `filter` configurations.

    content {

      name          = var.name          # Optional `filter` block argument.
      id            = var.id            # Optional `filter` block argument.
      record_type   = var.record_type   # Optional `filter` block argument.
      content_regex = var.content_regex # Optional `filter` block argument.

    }

  }

}

/*
 * Resource type  : exoscale_domain_record
 * Resource name  : generic
 * Attribute name : name
 * Argument name  : var.name
 * Variable name  : name
 */
resource "exoscale_domain_record" "generic" {

  domain      = var.domain      # Required argument.
  name        = var.name        # Required argument.
  content     = var.content     # Required argument.
  record_type = var.record_type # Required argument.
  prio        = var.prio        # Optional argument.
  ttl         = var.ttl         # Optional argument.

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

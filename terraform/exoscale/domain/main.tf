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
 * Data Source type : exoscale_domain
 * Data Source name : generic
 * Attribute name   : name
 * Argument name    : var.name
 * Variable name    : name
 */
data "exoscale_domain" "generic" {
  name = var.name # Required argument.
}

/*
 * Resource type  : exoscale_domain
 * Resource name  : generic
 * Attribute name : name
 * Argument name  : var.name
 * Variable name  : name
 */
resource "exoscale_domain" "generic" {

  name = var.name # Required argument.

  # Operation Timeouts:
  # `timeouts` block arguments allows you to customize how long
  # certain operations are allowed to take before being considered to have failed.
  timeouts {
    create = "5m"
    delete = "5m"
    read   = "5m"
  }

}

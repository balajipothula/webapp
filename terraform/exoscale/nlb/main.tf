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
 * Data Source type : exoscale_nlb
 * Data Source name : generic
 * Attribute name   : zone
 * Argument name    : var.zone
 * Variable name    : zone
 */
/*
data "exoscale_nlb" "generic" {
  zone = var.zone # Required argument.
  name = var.name # Optional argument, conflicts with `id`.
}
*/
/*
 * Resource type  : exoscale_nlb
 * Resource name  : generic
 * Attribute name : zone
 * Argument name  : var.zone
 * Variable name  : zone
 */
resource "exoscale_nlb" "generic" {

  zone        = var.zone        # Required argument.
  name        = var.name        # Required argument.
  description = var.description # Optional argument.
  labels      = var.labels      # Optional argument.

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

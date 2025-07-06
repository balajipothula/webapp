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
 * Data Source type : exoscale_anti_affinity_group
 * Data Source name : generic
 * Attribute name   : id
 * Argument name    : var.id
 * Variable name    : id
 */

/*
data "exoscale_anti_affinity_group" "generic" {
  name = var.name # Optional argument, 🤜💥🤛 conflicts with `id`, ✓ but keep it.
}
*/

/*
 * Resource type  : exoscale_anti_affinity_group
 * Resource name  : generic
 * Attribute name : name
 * Argument name  : var.name
 * Variable name  : name
 */
resource "exoscale_anti_affinity_group" "generic" {

  # Importing exoscale provider.
  provider = exoscale

  name        = var.name        # Required argument,❗ modification creates new resource.
  description = var.description # Optional argument,❗ modification creates new resource.

  # Operation Timeouts:
  # `timeouts` block arguments allows you to customize how long
  # certain operations are allowed to take before being considered to have failed.
  timeouts {
    create = "5m"
    delete = "5m"
    read   = "5m"
  }

}

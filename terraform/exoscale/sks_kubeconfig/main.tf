/*
 * ⚠ WARNING ⚠ 
 * This resource stores sensitive information in your Terraform state.
 * Please be sure to correctly understand implications and how to mitigate potential risks before using it.
 */

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
resource "exoscale_sks_kubeconfig" "generic" {

  cluster_id            = var.cluster_id            # Required argument.
  zone                  = var.zone                  # Required argument.
  groups                = var.groups                # Required argument.
  user                  = var.user                  # Required argument.
  ttl_seconds           = var.ttl_seconds           # Optional argument.
  early_renewal_seconds = var.early_renewal_seconds # Optional argument.

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

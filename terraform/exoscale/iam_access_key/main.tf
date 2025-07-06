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
 * Resource type  : exoscale_iam_access_key
 * Resource name  : generic
 * Attribute name : name
 * Argument name  : var.name
 * Variable name  : name
 */
resource "exoscale_iam_access_key" "generic" {

  name       = var.name       # Required argument.
  operations = var.operations # Optional argument.
  resources  = var.resources  # Optional argument.
  tags       = var.tags       # Optional argument.

  # Operation Timeouts:
  # `timeouts` block arguments allows you to customize how long
  # certain operations are allowed to take before being considered to have failed.
  timeouts {
    create = "5m"
    delete = "5m"
    read   = "5m"
  }

}

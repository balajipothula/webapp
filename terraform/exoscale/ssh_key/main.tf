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
 * Resource type  : exoscale_ssh_key
 * Resource name  : generic
 * Attribute name : name
 * Argument name  : var.name
 * Variable name  : name
 */
resource "exoscale_ssh_key" "generic" {

  # Importing exoscale provider.
  provider = exoscale

  name       = var.name                                        # Required argument.
  public_key = file("${path.module}/balaji@significo.com.pub") # Required argument.

  # Operation Timeouts:
  # `timeouts` block arguments allows you to customize how long
  # certain operations are allowed to take before being considered to have failed.
  timeouts {
    create = "5m"
    delete = "5m"
    read   = "5m"
  }

}

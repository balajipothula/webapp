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
 * Resource type  : exoscale_sks_cluster
 * Resource name  : generic
 * Attribute name : zone
 * Argument name  : var.zone
 * Variable name  : zone
 */
resource "exoscale_sks_cluster" "generic" {

  zone           = var.zone           # Required argument,❗modification creates new resource.
  name           = var.name           # Required argument.
  description    = var.description    # Optional argument.
  auto_upgrade   = var.auto_upgrade   # Optional argument.
  cni            = var.cni            # Optional argument.
  exoscale_ccm   = var.exoscale_ccm   # Optional argument.
  metrics_server = var.metrics_server # Optional argument.
  service_level  = var.service_level  # Optional argument.
  version        = var.sks_version    # Optional argument.
  labels         = var.labels         # Optional argument.
  /*
  dynamic "oidc" {                    # Optional block.

    for_each = var.oidc # Reading all `oidc` configurations.

    content {

      client_id       = var.client_id       # Required `oidc` block argument.
      issuer_url      = var.issuer_url      # Required `oidc` block argument.
      groups_claim    = var.groups_claim    # Optional `oidc` block argument.
      groups_prefix   = var.groups_prefix   # Optional `oidc` block argument.
      required_claim  = var.required_claim  # Optional `oidc` block argument.
      username_claim  = var.username_claim  # Optional `oidc` block argument.
      username_prefix = var.username_prefix # Optional `oidc` block argument.

    }

  }
  */

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

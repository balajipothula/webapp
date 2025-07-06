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
 * Resource type  : exoscale_sks_nodepool
 * Resource name  : generic
 * Attribute name : zone
 * Argument name  : var.zone
 * Variable name  : zone
 */
resource "exoscale_sks_nodepool" "generic" {

  cluster_id              = var.cluster_id              # Required argument,❗ modification creates new resource.
  zone                    = var.zone                    # Required argument,❗ modification creates new resource.
  name                    = var.name                    # Required argument.
  instance_type           = var.instance_type           # Required argument,❗ modification stops or restarts.
  size                    = var.size                    # Required argument.
  description             = var.description             # Optional argument, ✓ but keep it.
  deploy_target_id        = var.deploy_target_id        # Optional argument.
  instance_prefix         = var.instance_prefix         # Optional argument, ✓ but keep it.
  disk_size               = var.disk_size               # Optional argument, ✓ but keep it.
  labels                  = var.labels                  # Optional argument, ✓ but keep it.
  taints                  = var.taints                  # Optional argument.
  anti_affinity_group_ids = var.anti_affinity_group_ids # Optional argument, ✓ but keep it.
  private_network_ids     = var.private_network_ids     # Optional argument, ✓ but keep it.
  security_group_ids      = var.security_group_ids      # Optional argument, ✓ but keep it.

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

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
 * Data Source type : exoscale_template
 * Data Source name : generic
 * Attribute name   : zone
 * Argument name    : var.zone
 * Variable name    : zone
 */
data "exoscale_template" "generic" {
  zone       = var.zone                        # Required argument.
  name       = "Linux Ubuntu 22.04 LTS 64-bit" # Optional argument, conflicts with `id`.
  visibility = var.visibility                  # Optional argument.
}
/*
data "exoscale_instance_pool" "generic" {
  zone = var.zone # Required argument.
  name = var.name # Optional argument.
}

data "exoscale_instance_pool_list" "generic" {
  zone = var.zone # Required argument.
}
*/
/*
 * Resource type  : exoscale_instance_pool
 * Resource name  : generic
 * Attribute name : zone
 * Argument name  : var.zone
 * Variable name  : zone
 */
resource "exoscale_instance_pool" "generic" {

  zone               = var.zone               # Required argument.
  name               = var.name               # Required argument.
  instance_type      = var.instance_type      # Required argument.
  size               = var.size               # Required argument.
  template_id        = var.template_id        # Required argument.
  description        = var.description        # Optional argument.
  deploy_target_id   = var.deploy_target_id   # Optional argument.
  disk_size          = var.disk_size          # Optional argument.
  instance_prefix    = var.instance_prefix    # Optional argument.
  ipv6               = var.ipv6               # Optional argument.
  key_pair           = var.key_pair           # Optional argument.
  labels             = var.labels             # Optional argument.
  user_data          = var.user_data          # Optional argument.
  affinity_group_ids = var.affinity_group_ids # Optional argument.
  elastic_ip_ids     = var.elastic_ip_ids     # Optional argument.
  network_ids        = var.network_ids        # Optional argument.
  security_group_ids = var.security_group_ids # Optional argument.
  state              = var.state              # Optional argument.

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

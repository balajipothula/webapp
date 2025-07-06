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
  zone       = var.zone          # Required argument.
  name       = var.template_name # Optional argument, 🤜💥🤛 conflicts with `id`, ✓ but keep it.
  visibility = var.visibility    # Optional argument, ✓ but keep it.
}

/*
 * Resource type  : exoscale_compute_instance
 * Resource name  : generic
 * Attribute name : zone
 * Argument name  : var.zone
 * Variable name  : zone
 */
resource "exoscale_compute_instance" "generic" {

  # Importing exoscale provider.
  provider = exoscale

  zone               = var.zone                          # Required argument,❗ modification creates new resource.
  name               = var.name                          # Required argument.
  template_id        = data.exoscale_template.generic.id # Required argument,❗ modification creates new resource.
  type               = var.type                          # Required argument.
  disk_size          = var.disk_size                     # Optional argument,❗ modification stops or restarts instance.
  ipv6               = var.ipv6                          # Optional argument, ✓ but keep it.
  labels             = var.labels                        # Optional argument, ✓ but keep it.
  state              = var.state                         # Optional argument, ✓ but keep it.
  elastic_ip_ids     = var.elastic_ip_ids                # Optional argument.
  private            = var.private                       # Optional argument, ✓ but keep it.
  user_data          = var.user_data                     # Optional argument.
  security_group_ids = var.security_group_ids            # Optional argument, ✓ but keep it.
  # Optional block.
  dynamic "network_interface" {
    # Reading all `network_interface` configurations.
    for_each = var.network_interface_block
    content {
      network_id = network_interface.value.network_id # Required block argument.
      ip_address = network_interface.value.ip_address # Optional block argument.
    }
  }
  ssh_key     = var.ssh_key     # Optional argument, ✓ but keep it.
  reverse_dns = var.reverse_dns # Optional argument.
  #anti_affinity_group_ids = var.anti_affinity_group_ids      # Optional argument,❗ modification creates new resource, ⓘ set at creation time.
  #deploy_target_id        = var.deploy_target_id             # Optional argument,❗ modification creates new resource.

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

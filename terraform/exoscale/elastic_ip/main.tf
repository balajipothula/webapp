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
 * Data Source type : exoscale_elastic_ip
 * Data Source name : generic
 * Attribute name   : zone
 * Argument name    : var.zone
 * Variable name    : zone
 */

/*
data "exoscale_elastic_ip" "generic" {
  zone       = var.zone       # Required argument,❗ modification creates new resource.
  id         = var.id         # Optional argument, 🤜💥🤛 conflicts with `ip_address`, `labels`.
  ip_address = var.ip_address # Optional argument, 🤜💥🤛 conflicts with `id`, `labels`.
  labels     = var.labels     # Optional argument, 🤜💥🤛 conflicts with `ip_address`, `id`.
}
*/

/*
 * Resource type  : exoscale_elastic_ip
 * Resource name  : generic
 * Attribute name : zone
 * Argument name  : var.zone
 * Variable name  : zone
 */
resource "exoscale_elastic_ip" "generic" {

  # Importing exoscale provider.
  provider = exoscale

  zone           = var.zone           # Required argument,❗ modification creates new resource.
  description    = var.description    # Optional argument.
  address_family = var.address_family # Optional argument,❗ modification creates new resource.
  labels         = var.labels         # Optional argument.
  reverse_dns    = var.reverse_dns    # Optional argument.
  # Optional block.
  dynamic "healthcheck" {
    # Reading all `healthcheck` configurations.
    for_each = var.healthcheck_block
    content {
      mode            = healthcheck.value.mode            # Required `healthcheck` block argument.
      port            = healthcheck.value.port            # Required `healthcheck` block argument.
      uri             = healthcheck.value.uri             # Optional `healthcheck` block argument, ✓ but keep it.
      interval        = healthcheck.value.interval        # Optional `healthcheck` block argument, ✓ but keep it.
      timeout         = healthcheck.value.timeout         # Optional `healthcheck` block argument.
      tls_skip_verify = healthcheck.value.tls_skip_verify # Optional `healthcheck` block argument.
      strikes_ok      = healthcheck.value.strikes_ok      # Optional `healthcheck` block argument.
      strikes_fail    = healthcheck.value.strikes_fail    # Optional `healthcheck` block argument.
      tls_sni         = healthcheck.value.tls_sni         # Optional `healthcheck` block argument.
    }
  }
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

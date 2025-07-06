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
 * Resource type  : exoscale_nlb_service
 * Resource name  : generic
 * Attribute name : nlb_id
 * Argument name  : var.nlb_id
 * Variable name  : nlb_id
 */
resource "exoscale_nlb_service" "generic" {

  nlb_id           = var.nlb_id           # Required argument.
  zone             = var.zone             # Required argument.
  name             = var.name             # Required argument.
  instance_pool_id = var.instance_pool_id # Required argument.
  port             = var.port             # Required argument.
  target_port      = var.target_port      # Required argument.
  description      = var.description      # Optional argument.
  protocol         = var.protocol         # Optional argument.
  strategy         = var.strategy         # Optional argument.
  healthcheck {                           # Required argument block
    port = 80
  }

  /*
  dynamic "healthcheck" {                 # Optional block.

    for_each = var.healthcheck # Reading all `healthcheck` configurations.

    content {

      port     = var.healthcheck_port # Required `healthcheck` block argument.
      interval = var.interval         # Optional `healthcheck` block argument.
      mode     = var.mode             # Optional `healthcheck` block argument.
      retries  = var.retries          # Optional `healthcheck` block argument.
      timeout  = var.timeout          # Optional `healthcheck` block argument.
      tls_sni  = var.tls_sni          # Optional `healthcheck` block argument.
      uri      = var.uri              # Optional `healthcheck` block argument.

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

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
resource "exoscale_database" "generic" {

  zone                   = var.zone                   # Required argument, ❗ modification creates new resource.
  name                   = var.name                   # Required argument, ❗ modification creates new resource.
  type                   = var.type                   # Required argument, ❗ modification creates new resource.
  plan                   = var.plan                   # Required argument.
  maintenance_dow        = var.maintenance_dow        # Optional argument, ✓ but keep it.
  maintenance_time       = var.maintenance_time       # Optional argument, ✓ but keep it.
  termination_protection = var.termination_protection # Optional argument, ✓ but keep it.
  # Optional block, Apache Kafka service type specific arguments.
  dynamic "kafka" {
    # Reading all kafka configurations.
    for_each = var.kafka_block
    content {
      enable_cert_auth         = kafka.value.enable_cert_auth         # Optional `kafka` block argument, ✓ but keep it.
      enable_kafka_connect     = kafka.value.enable_kafka_connect     # Optional `kafka` block argument, ✓ but keep it.
      enable_kafka_rest        = kafka.value.enable_kafka_rest        # Optional `kafka` block argument, ✓ but keep it.
      enable_sasl_auth         = kafka.value.enable_kafka_connect     # Optional `kafka` block argument, ✓ but keep it.
      enable_schema_registry   = kafka.value.enable_schema_registry   # Optional `kafka` block argument, ✓ but keep it.
      ip_filter                = kafka.value.ip_filter                # Optional `kafka` block argument, ✓ but keep it.
      kafka_connect_settings   = kafka.value.kafka_connect_settings   # Optional `kafka` block argument, ✓ but keep it.
      kafka_rest_settings      = kafka.value.kafka_rest_settings      # Optional `kafka` block argument, ✓ but keep it.
      kafka_settings           = kafka.value.kafka_settings           # Optional `kafka` block argument, ✓ but keep it.
      schema_registry_settings = kafka.value.schema_registry_settings # Optional `kafka` block argument, ✓ but keep it.
      version                  = kafka.value.kafka_version            # Optional `kafka` block argument, ✓ but keep it.
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

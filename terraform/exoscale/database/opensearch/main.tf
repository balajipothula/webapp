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
  # Optional block, OpenSearch Database service type specific arguments.
  dynamic "opensearch" {
    # Reading all `opensearch` configurations.
    for_each = var.opensearch_block
    content {
      fork_from_service           = opensearch.value.fork_from_service           # Optional `opensearch` block argument, ❗ modification creates new resource.
      ip_filter                   = opensearch.value.ip_filter                   # Optional `opensearch` block argument, ✓ but keep it.
      keep_index_refresh_interval = opensearch.value.keep_index_refresh_interval # Optional `opensearch` block argument, ✓ but keep it.
      max_index_count             = opensearch.value.max_index_count             # Optional `opensearch` block argument, ✓ but keep it.
      recovery_backup_name        = opensearch.value.recovery_backup_name        # Optional `opensearch` block argument, ✓ but keep it.
      settings                    = opensearch.value.settings                    # Optional `opensearch` block argument, ✓ but keep it.
      version                     = opensearch.value.opensearch_version          # Optional `opensearch` block argument, ✓ but keep it.
      # Optional block.
      dynamic "dashboards" {
        # Reading all `opensearch > dashboards` configurations.
        for_each = opensearch.value.opensearch_dashboards_block
        content {
          enabled            = dashboards.value.enabled            # Optional `opensearch > dashboards` block argument, ✓ but keep it.
          max_old_space_size = dashboards.value.max_old_space_size # Optional `opensearch > dashboards` block argument, ✓ but keep it.
          request_timeout    = dashboards.value.request_timeout    # Optional `opensearch > dashboards` block argument, ✓ but keep it.
        }
      }
      # Optional block.
      dynamic "index_pattern" {
        # Reading all `opensearch > index_pattern` configurations.
        for_each = opensearch.value.opensearch_index_pattern_block
        content {
          max_index_count   = index_pattern.value.max_index_count   # Optional `opensearch > index_pattern` block argument, ✓ but keep it.
          pattern           = index_pattern.value.pattern           # Optional `opensearch > index_pattern` block argument, ✓ but keep it.
          sorting_algorithm = index_pattern.value.sorting_algorithm # Optional `opensearch > index_pattern` block argument, ✓ but keep it.
        }
      }
      # Optional block.
      dynamic "index_template" {
        # Reading all `opensearch > index_template` configurations.
        for_each = opensearch.value.opensearch_index_template_block
        content {
          mapping_nested_objects_limit = index_template.value.mapping_nested_objects_limit # Optional `opensearch > index_template` block argument, ✓ but keep it.
          number_of_replicas           = index_template.value.number_of_replicas           # Optional `opensearch > index_template` block argument, ✓ but keep it.
          number_of_shards             = index_template.value.number_of_shards             # Optional `opensearch > index_template` block argument, ✓ but keep it.
        }
      }
    }
  }

}

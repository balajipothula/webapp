# $ exo zone ↵
variable "zone" {
  type        = string
  default     = "de-fra-1"
  description = "The Exoscale Zone name."
  validation {
    condition     = can(regex("^[a-z]+-[a-z]+-[1-9]$", var.zone))
    error_message = "Error: zone must consist of lower case alphabets, hyphens and numbers only."
  }
  validation {
    condition     = lower(var.zone) == var.zone
    error_message = "Error: zone value must be in all lower case."
  }
  sensitive = false
}

variable "name" {
  type        = string
  default     = "generic"
  description = "The name of the database service."
  validation {
    condition     = (null != var.name)
    error_message = "Error: name value must not null and must consist of alphabets, hyphens and numbers only."
  }
  sensitive = false
}

variable "type" {
  type        = string
  default     = "opensearch"
  description = "The type of the database service."
  validation {
    condition     = ("opensearch" == var.type)
    error_message = "Error: type value must be `opensearch` only."
  }
  sensitive = false
}

# $ exo dbaas type show opensearch --plans ↵
variable "plan" {
  type        = string
  default     = "startup-4"
  description = "The plan of the database service."
  validation {
    condition     = contains(toset(["hobbyist-2", "startup-4", "business-4", "premium-4", "startup-8", "business-8", "premium-8", "startup-16", "business-16", "premium-16", "startup-32", "business-32", "premium-32", "startup-64", "business-64", "premium-64", "startup-128", "business-128", "premium-128", "startup-225", "business-225", "premium-225"]), var.plan)
    error_message = "Error: plan value must be `hobbyist-2`, `startup-4`, `business-4`, `premium-4`, `startup-8`, `business-8`, `premium-8`, `startup-16`, `business-16`, `premium-16`, `startup-32`, `business-32`, `premium-32`, `startup-64`, `business-64`, `premium-64`, `startup-128`, `business-128`, `premium-128`, `startup-225`, `business-225` or `premium-225` only."
  }
  sensitive = false
}

variable "maintenance_dow" {
  type        = string
  default     = "sunday"
  description = "The day of week to perform the automated database service maintenance."
  validation {
    condition     = contains(toset(["never", "sunday", "monday", "tuesday", "wednesday", "thursday", "friday", "saturday"]), var.maintenance_dow)
    error_message = "Error: maintenance_dow value must be `never`, `sunday`, `monday`, `tuesday`, `wednesday`, `thursday`, `friday` or `saturday` only."
  }
  sensitive = false
}

variable "maintenance_time" {
  type        = string
  default     = "02:00:00"
  description = "The time of day to perform the automated database service maintenance."
  sensitive   = false
}

variable "termination_protection" {
  type        = bool
  default     = true
  description = "The database service protection boolean flag against termination / power-off."
  validation {
    condition     = contains(toset([true, false]), var.termination_protection)
    error_message = "Error: termination_protection value must be `true` or `false` only."
  }
  sensitive = false
}

variable "opensearch_block" {
  type = list(object({
    fork_from_service           = string
    ip_filter                   = set(string)
    keep_index_refresh_interval = bool
    max_index_count             = number
    recovery_backup_name        = string
    settings                    = string
    opensearch_version          = string
    opensearch_dashboards_block = list(object({
      enabled            = bool
      max_old_space_size = number
      request_timeout    = number
    }))
    opensearch_index_pattern_block = list(object({
      max_index_count   = number
      pattern           = string
      sorting_algorithm = string
    }))
    opensearch_index_template_block = list(object({
      mapping_nested_objects_limit = number
      number_of_replicas           = number
      number_of_shards             = number
    }))
  }))
  default     = []
  description = "opensearch database service type specific arguments."
  validation {
    condition     = (length(var.opensearch_block) == 1)
    error_message = "Error: opensearch_block variable list length must be `1`."
  }
  validation {
    condition     = alltrue([for opensearch in var.opensearch_block : contains(toset(["1", "2"]), opensearch.opensearch_version)])
    error_message = "Error: version value must be `1` or `2` only."
  }
  validation {
    condition     = (length(var.opensearch_block[0].opensearch_dashboards_block) == 1)
    error_message = "Error: opensearch_dashboards_block variable list length must be `1`."
  }
  validation {
    condition     = alltrue([for dashboards in var.opensearch_block[0].opensearch_dashboards_block : contains(toset([true, false]), dashboards.enabled)])
    error_message = "Error: enabled value must be `true` or `false` only."
  }
  validation {
    condition     = alltrue([for index_pattern in var.opensearch_block[0].opensearch_index_pattern_block : contains(toset(["alphabetical", "creation_date"]), index_pattern.sorting_algorithm)])
    error_message = "Error: enabled value must be `true` or `false` only."
  }
  validation {
    condition     = alltrue([for index_template in var.opensearch_block[0].opensearch_index_template_block : (0 <= index_template.mapping_nested_objects_limit && index_template.mapping_nested_objects_limit <= 100000)])
    error_message = "Error: enabled value must be `true` or `false` only."
  }
  validation {
    condition     = alltrue([for index_template in var.opensearch_block[0].opensearch_index_template_block : (0 <= index_template.number_of_replicas && index_template.number_of_replicas <= 29)])
    error_message = "Error: enabled value must be `true` or `false` only."
  }
  validation {
    condition     = alltrue([for index_template in var.opensearch_block[0].opensearch_index_template_block : (1 <= index_template.number_of_shards && index_template.number_of_shards <= 1024)])
    error_message = "Error: enabled value must be `true` or `false` only."
  }
  sensitive = false
}

/*
# `opensearch` configuration block argument.
variable "fork_from_service" {
  type        = string
  default     = ""
  description = "Service name."
  validation {
    condition     = var.fork_from_service != null
    error_message = "Error: fork_from_service value must not null."
  }
  sensitive = false
}

# `opensearch` configuration block argument.
variable "recovery_backup_name" {
  type        = string
  default     = ""
  description = "Recovery backup name."
  validation {
    condition     = var.recovery_backup_name != null
    error_message = "Error: recovery_backup_name value must not null."
  }
  sensitive = false
}

# `opensearch` > `index_pattern` configuration block argument.
variable "max_index_count" {
  type        = number
  default     = 3
  description = "Recovery backup name."
  validation {
    condition     = 0 <= var.max_index_count && var.max_index_count <= 9
    error_message = "Error: max_index_count value must in between 0 to 9."
  }
  sensitive = false
}

# `opensearch` > `index_pattern` configuration block argument.
variable "pattern" {
  type        = string
  default     = ""
  description = "fnmatch pattern."
  validation {
    condition     = var.pattern != null
    error_message = "Error: pattern value must not null."
  }
  sensitive = false
}

# `opensearch` > `index_pattern` configuration block argument.
variable "sorting_algorithm" {
  type        = string
  default     = "creation_date"
  description = "Sorting algorithm."
  validation {
    condition     = contains(toset(["alphabetical", "creation_date"]), var.sorting_algorithm)
    error_message = "Error: sorting_algorithm value must be `alphabetical` or `creation_date` only."
  }
  sensitive = false
}

# `opensearch` > `index_template` configuration block argument.
variable "mapping_nested_objects_limit" {
  type        = number
  default     = 10000
  description = "The maximum number of nested JSON (JavaScript Object Notation) objects that a single document can contain across all nested types."
  validation {
    condition     = 0 <= var.mapping_nested_objects_limit && var.mapping_nested_objects_limit <= 100000
    error_message = "Error: mapping_nested_objects_limit value must in between 0 to 100000."
  }
  sensitive = false
}

# `opensearch` > `index_template` configuration block argument.
variable "number_of_replicas" {
  type        = number
  default     = 3
  description = "The number of replicas each primary shard has."
  validation {
    condition     = 0 <= var.number_of_replicas && var.number_of_replicas <= 29
    error_message = "Error: number_of_replicas value must in between 0 to 29."
  }
  sensitive = false
}

# `opensearch` > `index_template` configuration block argument.
variable "number_of_shards" {
  type        = number
  default     = 3
  description = "The number of primary shards that an index should have."
  validation {
    condition     = 1 <= var.number_of_shards && var.number_of_shards <= 1024
    error_message = "Error: number_of_shards value must in between 1 to 1024."
  }
  sensitive = false
}

# `opensearch` configuration block argument.
variable "opensearch_ip_filter" {
  type        = set(string)
  default     = []
  description = "A list of CIDR blocks to allow incoming connections from."
  sensitive   = false
}

# `opensearch` configuration block argument.
variable "keep_index_refresh_interval" {
  type        = bool
  default     = true
  description = "Aiven automation resets index.refresh_interval to default value for every index to be sure that indices are always visible to search."
  validation {
    condition     = contains(toset([true, false]), var.keep_index_refresh_interval)
    error_message = "Error: keep_index_refresh_interval value must be `true` or `false` only."
  }
  sensitive = false
}

# `opensearch` configuration block argument.
variable "max_index_count" {
  type        = number
  default     = 0
  description = "Maximum number of indexes to keep before deleting the oldest one."
  validation {
    condition     = 0 <= var.max_index_count && var.max_index_count <= 10
    error_message = "Error: max_index_count value must in between 1 to 10."
  }
  sensitive = false
}

# `opensearch` > `dashboards` configuration block argument.
variable "enabled" {
  type        = string
  default     = ""
  description = ""
  sensitive   = false
}

# `opensearch` > `dashboards` configuration block argument.
variable "max_old_space_size" {
  type        = string
  default     = ""
  description = ""
  sensitive   = false
}

# `opensearch` > `dashboards` configuration block argument.
variable "request_timeout" {
  type        = string
  default     = ""
  description = ""
  sensitive   = false
}

# `opensearch` configuration block argument.
# $ exo dbaas type show opensearch ↵
variable "opensearch_version" {
  type        = string
  default     = "2"
  description = "OpenSearch major version."
  validation {
    condition     = contains(toset(["1", "2"]), var.opensearch_version)
    error_message = "Error: opensearch_version value must be `1`, or `2` only."
  }
  sensitive = false
}
*/

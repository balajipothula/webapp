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
  default     = "kafka"
  description = "The type of the database service."
  validation {
    condition     = ("kafka" == var.type)
    error_message = "Error: type value must be `kafka` only."
  }
  sensitive = false
}

# $ exo dbaas type show pg --plans ↵
variable "plan" {
  type        = string
  default     = "startup-2"
  description = "The plan of the database service."
  validation {
    condition     = contains(toset(["startup-2", "business-4", "business-8", "business-16", "business-32", "premium-6x-8", "premium-6x-16", "premium-6x-32", "premium-9x-8", "premium-9x-16", "premium-9x-32", "premium-15x-8", "premium-15x-16", "premium-15x-32", "premium-30x-8", "premium-30x-16", "premium-30x-32"]), var.plan)
    error_message = "Error: plan value must be `startup-2`, `business-4`, `business-8`, `business-16`, `business-32`, `premium-6x-8`, `premium-6x-16`, `premium-6x-32`, `premium-9x-8`, `premium-9x-16`, `premium-9x-32`, `premium-15x-8`, `premium-15x-16`, `premium-15x-32`, `premium-30x-8`, `premium-30x-16` or `premium-30x-32` only."
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

# `kafka` configuration block variable.
variable "kafka_block" {
  type = list(object({
    enable_cert_auth         = bool
    enable_kafka_connect     = bool
    enable_kafka_rest        = bool
    enable_sasl_auth         = bool
    enable_schema_registry   = bool
    ip_filter                = set(string)
    kafka_connect_settings   = string
    kafka_rest_settings      = string
    kafka_settings           = string
    schema_registry_settings = string
    kafka_version            = string
  }))
  default     = []
  description = "kafka database service type specific arguments."
  validation {
    condition     = (length(var.kafka_block) == 1)
    error_message = "Error: kafka_block variable list length must be `1`."
  }
  validation {
    condition     = alltrue([for kafka in var.kafka_block : contains(toset([true, false]), kafka.enable_cert_auth)])
    error_message = "Error: enable_cert_auth value must be `true` or `false` only."
  }
  validation {
    condition     = alltrue([for kafka in var.kafka_block : contains(toset([true, false]), kafka.enable_kafka_connect)])
    error_message = "Error: enable_kafka_connect value must be `true` or `false` only."
  }
  validation {
    condition     = alltrue([for kafka in var.kafka_block : contains(toset([true, false]), kafka.enable_kafka_rest)])
    error_message = "Error: enable_kafka_rest value must be `true` or `false` only."
  }
  validation {
    condition     = alltrue([for kafka in var.kafka_block : contains(toset([true, false]), kafka.enable_sasl_auth)])
    error_message = "Error: enable_sasl_auth value must be `true` or `false` only."
  }
  validation {
    condition     = alltrue([for kafka in var.kafka_block : contains(toset([true, false]), kafka.enable_schema_registry)])
    error_message = "Error: enable_schema_registry value must be `true` or `false` only."
  }
  validation {
    condition     = alltrue([for kafka in var.kafka_block : contains(toset(["3.3", "3.4"]), kafka.kafka_version)])
    error_message = "Error: version value must be `3.3` or `3.4` only."
  }
  sensitive = false
}

/*
# `kafka` configuration block argument.
variable "enable_cert_auth" {
  type        = bool
  default     = true
  description = "Enable certificate-based authentication method."
  validation {
    condition     = contains(toset([true, false]), var.enable_cert_auth)
    error_message = "Error: enable_cert_auth value must be `true` or `false` only."
  }
  sensitive = false
}

# `kafka` configuration block argument.
variable "enable_kafka_connect" {
  type        = bool
  default     = true
  description = "Enable Kafka Connect."
  validation {
    condition     = contains(toset([true, false]), var.enable_kafka_connect)
    error_message = "Error: enable_kafka_connect value must be `true` or `false` only."
  }
  sensitive = false
}

# `kafka` configuration block argument.
variable "enable_kafka_rest" {
  type        = bool
  default     = true
  description = "Enable Kafka REST (REpresentational State Transfer)."
  validation {
    condition     = contains(toset([true, false]), var.enable_kafka_rest)
    error_message = "Error: enable_kafka_rest value must be `true` or `false` only."
  }
  sensitive = false
}

# `kafka` configuration block argument.
variable "enable_sasl_auth" {
  type        = bool
  default     = true
  description = "Enable SASL-based authentication method."
  validation {
    condition     = contains(toset([true, false]), var.enable_sasl_auth)
    error_message = "Error: enable_sasl_auth value must be `true` or `false` only."
  }
  sensitive = false
}

# `kafka` configuration block argument.
variable "enable_schema_registry" {
  type        = bool
  default     = true
  description = "Enable Schema Registry."
  validation {
    condition     = contains(toset([true, false]), var.enable_schema_registry)
    error_message = "Error: enable_schema_registry value must be `true` or `false` only."
  }
  sensitive = false
}

# `kafka` configuration block argument.
variable "ip_filter" {
  type        = set(string)
  default     = []
  description = "A list of CIDR blocks to allow incoming connections from."
  sensitive   = false
}

# `kafka` configuration block argument.
# $ exo dbaas type show kafka --settings=kafka-connect ↵
variable "kafka_connect_settings" {
  type        = string
  default     = null
  description = "Kafka Connect configuration settings in JSON (JavaScript Object Notation) format."
  sensitive   = false
}

# `kafka` configuration block argument.
# $ exo dbaas type show kafka --settings=kafka-rest ↵
variable "kafka_rest_settings" {
  type        = string
  default     = null
  description = "Kafka REST (REpresentational State Transfer) configuration settings in JSON (JavaScript Object Notation) format."
  sensitive   = false
}

# `kafka` configuration block argument.
# $ exo dbaas type show kafka --settings=kafka ↵
variable "kafka_settings" {
  type        = string
  default     = null
  description = "Kafka configuration settings in JSON (JavaScript Object Notation) format."
  sensitive   = false
}

# `kafka` configuration block argument.
# $ exo dbaas type show kafka --settings=schema-registry ↵
variable "schema_registry_settings" {
  type        = string
  default     = null
  description = "Schema Registry configuration settings in JSON (JavaScript Object Notation) format."
  sensitive   = false
}

# `kafka` configuration block argument.
# $ exo dbaas type show kafka ↵
variable "kafka_version" {
  type        = string
  default     = "3.4"
  description = "Kafka major version."
  validation {
    condition     = contains(toset(["3.3", "3.4"]), var.kafka_version)
    error_message = "Error: version value must be `3.3` or `3.4` only."
  }
  sensitive = false
}
*/

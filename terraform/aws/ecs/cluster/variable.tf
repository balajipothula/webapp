variable "capacity_providers" {
  type        = list(string)
  default     = ["FARGATE", "FARGATE_SPOT"]
  description = "List of short names of one or more capacity providers to associate with the cluster."
  validation {
    condition     = var.capacity_providers != null && 0 < length(var.capacity_providers)
    error_message = "Error: capacity_providers value must not null."
  }
  sensitive   = false
}

variable "configuration" {

  type = list(object({

    execute_command_configuration = list(object({

      kms_key_id        = string
      logging           = string

      log_configuration = list(object({
        cloud_watch_encryption_enabled = bool
      //cloud_watch_log_group_name     = string
      //s3_bucket_name                 = string
      //s3_bucket_encryption_enabled   = string
      //s3_key_prefix                  = string
      }))

    }))

  }))

  default     = []
  description = "The execute command configuration for the cluster."
  sensitive   = false

}

variable "default_capacity_provider_strategy" {
  type        = list(map(string))
  default     = []
  description = "Configuration block for capacity provider strategy to use by default for the cluster."
  sensitive   = false
}

// configuration > execute_command_configuration configuration block argument.
variable "kms_key_id" {
  type        = string
  default     = " "
  description = "The details of the execute command configuration."
  validation {
    condition     = var.kms_key_id != null
    error_message = "Error: kms_key_id value must not null."
  }
  sensitive   = false
}

// configuration > execute_command_configuration configuration block argument.
variable "logging" {
  type        = string
  default     = "OVERRIDE"
  description = "The details of the execute command configuration."
  validation {
    condition     = var.logging != null && contains(toset(["DEFAULT", "NONE", "OVERRIDE"]), var.logging)
    error_message = "Error: logging value must not null."
  }
  sensitive   = false
}

// configuration > execute_command_configuration > log_configuration configuration block argument.
variable "cloud_watch_encryption_enabled" {
  type        = bool
  default     = false
  description = "Whether or not to enable encryption on the CloudWatch logs."
  validation {
    condition     = var.cloud_watch_encryption_enabled != null && contains(toset([true, false]), var.cloud_watch_encryption_enabled)
    error_message = "Error: cloud_watch_encryption_enabled value must be either true or false."
  }
  sensitive   = false
}

// configuration > execute_command_configuration > log_configuration configuration block argument.
variable "cloud_watch_log_group_name" {
  type        = string
  default     = " "
  description = "The name of the CloudWatch log group to send logs to."
  validation {
    condition     = var.cloud_watch_log_group_name != null
    error_message = "Error: capacity_provider value must not null."
  }
  sensitive   = false
}

// configuration > execute_command_configuration > log_configuration configuration block argument.
variable "s3_bucket_name" {
  type        = string
  default     = "job-log-s3-bucket"
  description = "The name of the S3 bucket to send logs to."
  validation {
    condition     = var.s3_bucket_name != null # && trimspace(var.s3_bucket_name) != ""
    error_message = "Error: capacity_provider value must not null."
  }
  sensitive   = false
}

// configuration > execute_command_configuration > log_configuration configuration block argument.
variable "s3_bucket_encryption_enabled" {
  type        = bool
  default     = false
  description = "Whether or not to enable encryption on the logs sent to S3."
  validation {
    condition     = var.s3_bucket_encryption_enabled != null && contains(toset([true, false]), var.s3_bucket_encryption_enabled)
    error_message = "Error: enable value must be either true or false."
  }
  sensitive   = false
}

// configuration > execute_command_configuration > log_configuration configuration block argument.
variable "s3_key_prefix" {
  type        = string
  default     = "job-log-web-ui-cluster-log"
  description = "An optional folder in the S3 bucket to place logs in."
  validation {
    condition     = var.s3_key_prefix != null # && trimspace(var.s3_key_prefix) != ""
    error_message = "Error: capacity_provider value must not null."
  }
  sensitive   = false
}

// default_capacity_provider_strategy configuration block argument.
variable "capacity_provider" {
  type        = string
  default     = "generic"
  description = "The short name of the capacity provider."
  validation {
    condition     = var.capacity_provider != null
    error_message = "Error: capacity_provider value must not null."
  }
  sensitive   = false
}

// default_capacity_provider_strategy configuration block argument.
variable "weight" {
  type        = number
  default     = 50
  description = "The relative percentage of the total number of launched tasks that should use the specified capacity provider."
  validation {
    condition     = var.weight != null && 50 <= var.weight && var.weight <= 75
    error_message = "Error: weight value must not null."
  }
  sensitive   = false
}

// default_capacity_provider_strategy configuration block argument.
variable "base" {
  type        = number
  default     = 3
  description = "The number of tasks, at a minimum, to run on the specified capacity provider."
  validation {
    condition     = var.base != null && 3 <= var.base && var.base <= 9
    error_message = "Error: weight value must not null."
  }
  sensitive   = false
}

variable "name" {
  type        = string
  default     = "job_log_web_ui_cluster"
  description = "Name of the cluster."
  validation {
    condition     = var.name != null && 1 <= length(var.name) && length(var.name) <= 255
    error_message = "Error: name value must not null, name lenght must be between 1 and 255 and name must start with alphabets."
  }
  sensitive   = false
}

variable "setting" {
  type        = list(map(string))
  default     = []
  description = "Configuration block with cluster settings."
  sensitive   = false
}

// setting configuration block argument.
variable "setting_name" {
  type        = string
  default     = "containerInsights"
  description = "Name of the setting to manage."
  validation {
    condition     = var.setting_name != null && var.setting_name == "containerInsights"
    error_message = "Error: setting_name value must not null."
  }
  sensitive   = false
}

// setting configuration block argument.
variable "setting_value" {
  type        = string
  default     = "disabled"
  description = "The value to assign to the setting."
  validation {
    condition     = var.setting_value != null && contains(toset(["disabled", "enabled"]), var.setting_value)
    error_message = "Error: setting_value value must not null."
  }
  sensitive   = false
}

variable "tags" {
  type        = map(string)
  default     = {
    "Name" = "Generic"
  }
  description = "A map of tags to assign to the database cluster."
  validation {
    condition     = 1 <= length(var.tags) && length(var.tags) <= 50
    error_message = "Error: tags at least one or more expected upto 50."
  }
  sensitive   = false
}

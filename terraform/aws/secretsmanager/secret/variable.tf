variable "description" {
  type        = string
  default     = "Generic Secrets Manager"
  description = "Description of the secret."
  validation {
    condition     = var.description != null && 0 < length(var.description) && length(var.description) < 65
    error_message = "Error: description length must be in between 1 and 64 only."
  }
  sensitive = false
}

variable "force_overwrite_replica_secret" {
  type        = bool
  default     = false
  description = "Specify whether to overwrite a secret with the same name in the destination Region."
  validation {
    condition     = var.force_overwrite_replica_secret != null && contains(tolist([true, false]), var.force_overwrite_replica_secret)
    error_message = "Error: force_overwrite_replica_secret must not null and value either true or false only."
  }
  sensitive = false
}

variable "kms_key_id" {
  type        = string
  default     = "aws/secretsmanager"
  description = "ARN or Id of the AWS KMS key to be used to encrypt the secret values in the versions stored in this secret."
  validation {
    condition     = var.kms_key_id != null
    error_message = "Error: kms_key_id must not null."
  }
  sensitive = false
}

variable "name" {
  type        = string
  default     = "generic"
  description = "Friendly name of the new secret."
  validation {
    condition     = var.name != null && 0 < length(var.name) && length(var.name) < 33
    error_message = "Error: name must not null and length must be in between 1 and 32 only."
  }
  sensitive = false
}

variable "name_prefix" {
  type        = string
  default     = "generic-"
  description = "Creates a unique name beginning with the specified prefix."
  validation {
    condition     = var.name_prefix != null && 0 < length(var.name_prefix) && length(var.name_prefix) < 17
    error_message = "Error: name_prefix must not null and length must be in between 1 and 16 only."
  }
  sensitive = false
}

variable "recovery_window_in_days" {
  type        = number
  default     = 7
  description = "The target backtrack window, in seconds. Only available for aurora engine currently. To disable backtracking, set this value to 0. Must be between 0 and 259200"
  validation {
    condition     = var.recovery_window_in_days != null && 6 < var.recovery_window_in_days && var.recovery_window_in_days < 31
    error_message = "Error: recovery_window_in_days value must not null, in between 7 and 30 days."
  }
  sensitive   = false
}

variable "tags" {
  type = map(string)
  default = {
    "AppName"        = "WebAppFastAPI"
    "Division"       = "Platform"
    "DeveloperName"  = "Balaji Pothula"
    "DeveloperEmail" = "balan.pothula@gmail.com"
  }
  validation {
    condition     = var.tags != null && 0 < length(var.tags) && length(var.tags) < 51
    error_message = "Error: tags at least one or more expected upto 50."
  }
  sensitive = false
}

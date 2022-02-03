variable "name" {
  type        = string
  default     = null
  description = "The name of the log group."
  sensitive = false
}

variable "name_prefix" {
  type        = string
  default     = "webapp-"
  description = "Creates a unique name beginning with the specified prefix."
  validation {
    condition     = var.name_prefix != null && 0 <= length(var.name_prefix) && length(var.name_prefix) <= 64
    error_message = "Error: name_prefix must not null and length must be in between 1 and 64 only."
  }
  sensitive = false
}

variable "retention_in_days" {
  type        = number
  default     = 14
  description = "Specifies the number of days you want to retain log events in the specified log group."
  validation {
    condition     = var.retention_in_days != null && contains(tolist([0, 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, 3653]), var.retention_in_days)
    error_message = "Error: retention_in_days must not null and value must be 0, 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, 3653."
  }
  sensitive = false
}

variable "kms_key_id" {
  type        = string
  default     = ""
  description = "The ARN of the KMS Key to use when encrypting log data."
  validation {
    condition     = var.kms_key_id != null
    error_message = "Error: kms_key_id must not null."
  }
  sensitive = false
}

variable "tags" {
  type = map(string)
  default = {
    "AppName"        = "WebAppFastAPI"
    "Division"       = "Platform"
    "DeveloperName"  = "Balaji Pothula"
    "DeveloperEmail" = "balan.pothula@gmail.com"
  }
  description = "A map of tags to assign to the Lambda Function." 
  validation {
    condition     = var.tags != null && 0 < length(var.tags) && length(var.tags) < 51
    error_message = "Error: tags at least one or more expected upto 50."
  }
  sensitive = false
}

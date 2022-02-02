variable "secret_id" {
  type        = string
  default     = "generic"
  description = "Specifies the secret to which you want to add a new version."
  validation {
    condition     = var.secret_id != null
    error_message = "Error: secret_id must not null."
  }
  sensitive = false
}

variable "rotation_lambda_arn" {
  type        = string
  default     = null
  description = "Specifies text data that you want to encrypt and store in this version of the secret." 
  sensitive   = true
}

variable "automatically_after_days" {
  type        = number
  default     = 15
  description = "Specifies the number of days between automatic scheduled rotations of the secret."
  validation {
    condition     = var.automatically_after_days != null && 0 < var.automatically_after_days && var.automatically_after_days < 31
    error_message = "Error: automatically_after_days value must not null and value must be in between 1 to 30."
  }
  sensitive = false
}

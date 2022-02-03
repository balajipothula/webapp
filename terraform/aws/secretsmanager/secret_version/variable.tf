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

# Note: secret_string is a JSON string with map structure.
variable "secret_string" {
  type        = string
  default     = null
  description = "Specifies text data that you want to encrypt and store in this version of the secret." 
  sensitive   = true
}

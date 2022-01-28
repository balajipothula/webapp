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

variable "secret_string" {
  type = map(string)
  default = {
    "dbInstanceIdentifier" = "generic"
    "engine"               = "aurora-postgresql"
  }
  description = "Specifies text data that you want to encrypt and store in this version of the secret." 
  sensitive = true
}

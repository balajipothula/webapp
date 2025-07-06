variable "name" {
  type        = string
  default     = "pub-key-name"
  description = "The SSH (Secure SHell) key name."
  validation {
    condition     = var.name != null
    error_message = "Error: name value must not null."
  }
  sensitive = false
}

variable "public_key" {
  type        = string
  default     = ""
  description = " The SSH (Secure SHell) public key that will be authorized in compute instances."
  validation {
    condition     = var.public_key != null
    error_message = "Error: public_key value must not null."
  }
  sensitive = false
}

variable "name" {
  type        = string
  default     = "generic"
  description = "The security group name."
  validation {
    condition     = var.name != null && length(regexall("[^a-z-a-z-0-9]", var.name)) == 0
    error_message = "Error: name value must not null and must consist of alphabets, hyphens and numbers only."
  }
  sensitive = false
}

variable "description" {
  type        = string
  default     = "generic"
  description = "A free-form text describing the group."
  validation {
    condition     = var.description != null
    error_message = "Error: description value must not null."
  }
  sensitive = false
}

variable "external_sources" {
  type        = list(string)
  default     = ["0.0.0.0/0"]
  description = "A list of external network sources, in CIDR notation."
  sensitive   = false
}


variable "exoscale_api_key" {
  type        = string
  default     = null
  description = "Exoscale API Key which is stored in GitHub secrets."
  sensitive   = true
}

variable "exoscale_api_secret" {
  type        = string
  default     = null
  description = "Exoscale API Secret which is stored in GitHub secrets."
  sensitive   = true
}

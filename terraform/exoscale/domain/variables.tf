variable "name" {
  type        = string
  default     = "generic"
  description = "The DNS (Domain Name System) domain name."
  validation {
    condition     = var.name != null
    error_message = "Error: name value must not null."
  }
  sensitive = false
}

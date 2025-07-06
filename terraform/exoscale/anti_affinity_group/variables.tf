variable "name" {
  type        = string
  default     = "webapp"
  description = "The anti-affinity group name."
  validation {
    condition     = can(regex("^[a-z][a-z0-9-]+$", var.name))
    error_message = "Error: name must start with lower case alphabets, consist of lower case alphabets, hyphens and numbers only."
  }
  sensitive = false
}

variable "description" {
  type        = string
  default     = "WebApp Anti Affinity Group"
  description = "Anti Affinity Group description."
  validation {
    condition     = (8 <= length(var.description) && length(var.description) <= 64)
    error_message = "Error: description must have minimum `8` and maximum `64` characters."
  }
  sensitive = false
}

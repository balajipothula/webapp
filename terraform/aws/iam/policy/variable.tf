variable "description" {
  type        = string
  default     = "AWS IAM Policy Module."
  description = "Description of the IAM policy."
  validation {
    condition     = var.description != null && length(var.description) <= 256
    error_message = "Error: description must not be null and must be 256 characters or fewer."
  }
  sensitive = false
}

variable "name_prefix" {
  type        = string
  default     = "generic"
  description = "Creates a unique name beginning with the specified prefix."
  validation {
    condition     = length(var.name_prefix) <= 16
    error_message = "Error: name_prefix must be null or up to 16 characters."
  }
  sensitive = false
}

variable "name" {
  type        = string
  default     = "generic-aws-iam-policy"
  description = "The name of the policy."
  validation {
    condition     = can(var.name) && length(var.name) <= 256
    error_message = "Error: name must be 256 characters or fewer."
  }
  sensitive = false
}

variable "path" {
  type        = string
  default     = "/"
  description = "Path in which to create the policy."
  validation {
    condition     = can(var.path) && var.path == "/"
    error_message = "Error: path must be '/' exactly."
  }
  sensitive = false
}

variable "policy" {
  type        = string
  default     = null
  description = "The policy document."
  validation {
    condition     = can(var.policy) && 0 < length(var.policy)
    error_message = "Error: policy must not be null or empty."
  }
  sensitive = false
}

variable "tags" {
  type        = map(string)
  default     = {
    AppName  = "WebAppFastAPI"
    Division = "Platform"
  }
  description = "Map of tags to assign to the IAM policy."
  validation {
    condition     = can(var.tags) && 0 < length(var.tags) && length(var.tags) < 51
    error_message = "Error: tags map must contain 1 to 50 items."
  }
  sensitive = false
}

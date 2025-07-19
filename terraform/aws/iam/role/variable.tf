variable "assume_role_policy" {
  type        = string
  default     = null
  description = "Policy that grants an entity permission to assume the role."
  sensitive   = false
}

variable "description" {
  type        = string
  default     = "AWS IAM Role Module."
  description = "Description of the role."
  validation {
    condition     = var.description != null && length(var.description) <= 256
    error_message = "Error: description must not be null and must be 256 characters or fewer."
  }
  sensitive = false
}

variable "force_detach_policies" {
  type        = bool
  default     = true
  description = "Whether to force detaching any policies the role has before destroying it."
  validation {
    condition     = var.force_detach_policies != null && contains(tolist([true, false]), var.force_detach_policies)
    error_message = "Error: force_detach_policies must not be null. Value must be either true or false."
  }
  sensitive = false
}

variable "name" {
  type        = string
  default     = "GenericIAMRole"
  description = "Name of the IAM role."
  validation {
    condition     = var.name != null && 0 <= length(var.name) && length(var.name) <= 256
    error_message = "Error: name must not be null and its length must not exceed 256 characters."
  }
  sensitive = false
}

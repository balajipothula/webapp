variable "assume_role_policy" {
  type        = string
  default     = null
  description = "Policy that grants an entity permission to assume the role."
  sensitive = false
}

variable "description" {
  type        = string
  default     = "AWS IAM Role Module."
  description = "Description of the role."
  validation {
    condition     = var.description != null && 0 <= length(var.description) && length(var.description) <= 256
    error_message = "Error: description value must not null and description lenght not more than 256 charecters."
  }
  sensitive = false
}

variable "force_detach_policies" {
  type        = bool
  default     = true
  description = "Whether to force detaching any policies the role has before destroying it."
  validation {
    condition     = var.force_detach_policies != null && contains(tolist([true, false]), var.force_detach_policies)
    error_message = "Error: force_detach_policies value must not null and publish value either true or false only."
  }
  sensitive = false
}

variable "name" {
  type        = string
  default     = "GenericIAMRole"
  description = "Description of the role."
  validation {
    condition     = var.name != null && 0 <= length(var.name) && length(var.name) <= 256
    error_message = "Error: name value must not null and name lenght not more than 256 charecters."
  }
  sensitive = false
}

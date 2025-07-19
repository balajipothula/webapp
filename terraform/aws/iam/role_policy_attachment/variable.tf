variable "name" {
  type        = string
  default     = "RolePolicyAttachment"
  description = "The name of the attachment."
  validation {
    condition     = can(var.name) && 0 < length(var.name)
    error_message = "name must not be empty."
  }
  sensitive = false
}

variable "users" {
  type        = list(string)
  default     = []
  description = "User(s) the policy should be applied to."
  sensitive   = false
}

variable "roles" {
  type        = list(string)
  default     = []
  description = "Role(s) the policy should be applied to."
  sensitive   = false
}

variable "groups" {
  type        = list(string)
  default     = []
  description = " Group(s) the policy should be applied to."
  sensitive   = false
}

variable "policy_arn" {
  type        = string
  default     = "arn:aws:iam::aws:policy/AdministratorAccess"
  description = "ARN of the policy you want to apply."
  validation {
    condition     = can(var.policy_arn) && startswith(var.policy_arn, "arn:")
    error_message = "policy_arn not null and that starts with 'arn:'"
  }
  sensitive   = false
}

variable "role" {
  type        = string
  default     = null
  description = "The name of the IAM role to which the policy should be applied"
  sensitive = false
}

variable "policy_arn" {
  type        = string
  default     = "arn:aws:iam::aws:policy/AdministratorAccess"
  description = "The ARN of the policy you want to apply."
  validation {
    condition     = var.policy_arn != null
    error_message = "Error: policy_arn value must not null."
  }
  sensitive = false
}

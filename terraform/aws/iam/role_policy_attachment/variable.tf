variable "role" {
  type        = string
  default     = "WebAppLambdaIAMRole"
  description = "The name of the IAM role to which the policy should be applied"
  validation {
    condition     = var.role != null && 0 <= length(var.role) && length(var.role) <= 64
    error_message = "Error: role value must not null and length not more than 64 charecters."
  }
  sensitive = false
}

variable "policy_arn" {
  type        = string
  default     = "arn:aws:iam::304501768659:policy/WebAppLambdaIAMPolicy"
  description = "The ARN of the policy you want to apply."
  validation {
    condition     = var.name != null
    error_message = "Error: policy_arn value must not null."
  }
  sensitive = false
}

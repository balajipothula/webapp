# Resource  type : aws_ecrpublic_repository_policy
# Resource  name : generic
# Variable  name : repository_name

variable "repository_name" {
  type        = string
  default     = "ecrpublic-repo-generic"
  description = "Name of the repository."
  validation {
    condition     = var.repository_name != null && 0 < length(var.repository_name) && length(var.repository_name) < 257
    error_message = "Error: repository_name must be between 1 and 256 characters."
  }
  sensitive = false
}

variable "policy" {
  type        = string
  default     = null
  description = "The policy document."
  validation {
    condition     = var.policy != null
    error_message = "Error: policy must be not null."
  }
  sensitive = false
}

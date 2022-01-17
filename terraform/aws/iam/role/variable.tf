variable "account_id" {
  type        = number
  default     = null
  description = "AWS Account ID which is stored in HashiCorp Terraform Cloud."
  sensitive   = true
}

variable "access_key" {
  type        = string
  default     = null
  description = "AWS_ACCESS_KEY_ID which is stored in HashiCorp Terraform Cloud."
  sensitive   = true
}

variable "secret_key" {
  type        = string
  default     = null
  description = "AWS_SECRET_ACCESS_KEY which is stored in HashiCorp Terraform Cloud."
  sensitive   = true
}

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
  default     = "WebAppLambdaRole"
//default     = "AWS_IAM_Role_Generic"
  description = "Description of the role."
  validation {
    condition     = var.name != null && 0 <= length(var.description) && length(var.description) <= 256
    error_message = "Error: name value must not null and description lenght not more than 256 charecters."
  }
  sensitive = false
}
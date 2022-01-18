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

variable "region" {
  type        = string
  default     = "eu-central-1"
  description = "AWS Region to launch your resources."
  validation {
    condition     = var.region != null && length(regexall("[^a-z-a-z-0-9]", var.region)) == 0
    error_message = "Error: region value must not null and region must consist of alphabets, hyphens and numbers only."
  }
  sensitive   = true
}

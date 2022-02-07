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

variable "master_username" {
  type        = string
  default     = "webapp"
  description = "Username for the PostgreSQL master database user, which is stored in HashiCorp Terraform Cloud."
  sensitive   = true
}

variable "master_password" {
  type        = string
  default     = "WebApp#2022"
  description = "Password for the PostgreSQL master database user, which is stored in HashiCorp Terraform Cloud."
  sensitive   = true
}

variable "database_name" {
  type        = string
  default     = "yousician_db"
  validation {
    condition     = var.database_name != null && 5 < length(var.database_name) && length(var.database_name) < 33
    error_message = "Error: database_name value must not null, lenght must be in between 6 to 32 and suffix must be _db."
  }
  description = "Database name for the PostgreSQL database, which is stored in HashiCorp Terraform Cloud."
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

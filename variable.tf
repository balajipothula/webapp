variable "token_github" {
  type        = string
//default     = null
  default     = "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"
  description = "GitHub token configured in 'webapp' repository."
//sensitive   = true
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

variable "access_key" {
  type        = string
//default     = null
  default     = "AKIA2J3BLS3MBV3PLYPW"
  description = "AWS_ACCESS_KEY_ID which is stored in HashiCorp Terraform Cloud."
  sensitive   = true
}

variable "secret_key" {
  type        = string
//default     = null
  default     = "r4veASwIACv/NSPza4Jo59W8yPk4dVkDC7OHP9oU"
  description = "AWS_SECRET_ACCESS_KEY which is stored in HashiCorp Terraform Cloud."
  sensitive   = true
}

# User defined argument.
variable "ami_map" {
  type        = map(string)
  default     = {
    "eu-central-1" = "ami-0d271bb6d5ee95925"
    "us-east-1"    = "ami-0fe78f0c5bf927432"
  }
  description = "A map of AWS Regions and AMI Names." 
  validation {
    condition     = var.ami_map != null && 0 < length(var.ami_map) && length(var.ami_map) < 11
    error_message = "Error: ami_map at least one or more expected upto 10."
  }
  sensitive   = false
}

variable "master_username" {
  type        = string
  default     = "webapp"
  description = "Username for the PostgreSQL master database user, which is stored in HashiCorp Terraform Cloud."
  sensitive   = true
}

variable "master_password" {
  type        = string
  default     = "WebApplication"
  description = "Password for the PostgreSQL master database user, which is stored in HashiCorp Terraform Cloud."
  sensitive   = true
}

variable "database_name" {
  type        = string
  default     = "webapp_db"
  validation {
    condition     = var.database_name != null && 5 < length(var.database_name) && length(var.database_name) < 33
    error_message = "Error: database_name value must not null, lenght must be in between 6 to 32 and suffix must be _db."
  }
  description = "Database name for the PostgreSQL database, which is stored in HashiCorp Terraform Cloud."
  sensitive   = true
}

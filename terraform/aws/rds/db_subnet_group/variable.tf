variable "name" {
  type        = string
  default     = "rds-db-subnet-group"
  description = "The name of the DB subnet group."
  validation {
    condition     = 0 < length(var.name)
    error_message = "Error: name must not be empty."
  }
  sensitive = false
}

variable "name_prefix" {
  type        = string
  default     = null
  description = "Creates a unique name beginning with the specified prefix."
  sensitive = false
}

variable "description" {
  type        = string
  default     = "AWS RDS Database subnet group."
  description = "The description of the DB subnet group."
  validation {
    condition     = var.description != null
    error_message = "Error: description must not be null."
  }
  sensitive = false
}

variable "subnet_ids" {
  type        = list(string)
  description = "A list of VPC subnet IDs."
  validation {
    condition     = 0 < length(var.subnet_ids)
    error_message = "Error: At least one subnet ID must be provided."
  }
  sensitive = false
}

variable "tags" {
  type = map(string)
  default = {
    AppName        = "WebAppFastAPI"
    Division       = "Platform"
    DeveloperName  = "Balaji Pothula"
    DeveloperEmail = "balan.pothula@gmail.com"
  }
  description = "A map of tags to assign to the resource."
  validation {
    condition     = var.tags != null && 0 < length(var.tags) && length(var.tags) < 51
    error_message = "Error: tags at least one or more expected up to 50."
  }
  sensitive = false
}

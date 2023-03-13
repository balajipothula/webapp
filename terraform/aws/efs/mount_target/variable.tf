variable "file_system_id" {
  type        = string
  default     = "generic"
  description = "The ID of the file system for which the mount target is intended."
  validation {
    condition     = var.file_system_id != null && 0 < length(var.file_system_id) && length(var.file_system_id) < 65
    error_message = "Error: file_system_id value must not null, length must be in between 1 and 64 only."
  }
  sensitive = false
}

variable "subnet_id" {
  type        = string
  default     = "subnet-03fa50f3076b205e6"
  description = "The ID of the subnet to add the mount target in."
  validation {
    condition     = var.subnet_id != null
    error_message = "Error: subnet_id value must not null."
  }
  sensitive = false
}

variable "ip_address" {
  type        = string
  default     = "10.11.12.13"
  description = "The address at which the file system may be mounted via the mount target."
  validation {
    condition     = var.ip_address != null
    error_message = "Error: ip_address value must not null."
  }
  sensitive = false
}

variable "security_groups" {
  type    = list(string)
  default = [
    "sg-086a967f",
  ]
  description = "A list of up to five VPC security group IDs in effect for the mount target."
  validation {
    condition     = var.security_groups != null && 0 < length(var.security_groups) && length(var.security_groups) < 6
    error_message = "Error: security_groups value must not null and security_groups length must be in between 1 and 5."
  }
  sensitive = false
}

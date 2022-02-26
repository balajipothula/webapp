variable "availability_zone_name" {
  type        = string
  default     = "eu-central-1a"
  description = "AWS Availability Zone in which to create the file system."
  validation {
    condition     = var.availability_zone_name != null && 1 <= length(var.availability_zone_name) && length(var.availability_zone_name) <= 64
    error_message = "Error: availability_zone_name value must not null, length must be in between 1 and 64 only."
  }
  sensitive = false
}

variable "creation_token" {
  type        = string
  default     = "generic"
  description = "A unique name used as reference when creating the Elastic File System to ensure idempotent file system creation."
  validation {
    condition     = var.creation_token != null && 0 < length(var.creation_token) && length(var.creation_token) < 65
    error_message = "Error: creation_token value must not null, length must be in between 1 and 64 only."
  }
  sensitive = false
}

variable "encrypted" {
  type        = bool
  default     = false
  description = "Whether to associate a public IP address with an instance in a VPC."
  validation {
    condition     = var.encrypted != null && contains(tolist([true, false]), var.encrypted)
    error_message = "Error: publish value must not null and value either true or false only."
  }
  sensitive = false
}

variable "kms_key_id" {
  type        = string
  default     = ""
  description = "The ARN for the KMS encryption key."
  validation {
    condition     = var.kms_key_id != null
    error_message = "Error: kms_key_id value must not null."
  }
  sensitive = false
}

variable "lifecycle_policy" {
  type        = string
  default     = "TransitionToIA"
  description = "A file system lifecycle policy object."
  validation {
    condition     = var.lifecycle_policy != null && contains(tolist(["TransitionToIA", "TransitionToPrimaryStorageClass"]), var.lifecycle_policy)
    error_message = "Error: lifecycle_policy value must not null and value either TransitionToIA or TransitionToPrimaryStorageClass only."
  }
  sensitive = false
}

variable "performance_mode" {
  type        = string
  default     = "generalPurpose"
  description = "The file system performance mode."
  validation {
    condition     = var.performance_mode != null && contains(tolist(["generalPurpose", "maxIO"]), var.performance_mode)
    error_message = "Error: performance_mode value must not null and value either generalPurpose or maxIO only."
  }
  sensitive = false
}

variable "memoprovisioned_throughput_in_mibpsry_size" {
  type        = number
  default     = 8
  description = "Amount of memory (in MB) allocate to Lambda Function for runtime."
  validation {
    condition     = var.memoprovisioned_throughput_in_mibpsry_size != null && 8 <= var.memoprovisioned_throughput_in_mibpsry_size && var.memoprovisioned_throughput_in_mibpsry_size <= 128
    error_message = "Error: memoprovisioned_throughput_in_mibpsry_size value must not null."
  }
  sensitive = false
}

variable "tags" {
  type = map(string)
  default = {
    "AppName"        = "WebAppFastAPI"
    "Division"       = "Platform"
    "DeveloperName"  = "Balaji Pothula"
    "DeveloperEmail" = "balan.pothula@gmail.com"
  }
  description = "A map of tags to assign to the Lambda Function." 
  validation {
    condition     = var.tags != null && 0 < length(var.tags) && length(var.tags) < 51
    error_message = "Error: tags at least one or more expected upto 50."
  }
  sensitive = false
}

variable "throughput_mode" {
  type        = string
  default     = "bursting"
  description = "Throughput mode for the file system."
  validation {
    condition     = var.throughput_mode != null && contains(tolist(["bursting", "provisioned"]), var.throughput_mode)
    error_message = "Error: throughput_mode value must not null and value either bursting or provisioned only."
  }
  sensitive = false
}

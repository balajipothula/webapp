# Resource  type : aws_s3_bucket
# Resource  name : generic
# Variable  name : bucket
variable "bucket" {
  type        = string
  default     = "aws-s3-bucket-generic"
  description = "The name of the bucket."
  validation {
    condition     = var.bucket != null && 0 <= length(var.bucket) && length(var.bucket) <= 63
    error_message = "Error: bucket length must be in between 1 and 63 only."
  }
  sensitive = false
}

variable "bucket_prefix" {
  type        = string
  default     = "aws-s3-bucket-"
  description = "The name of the bucket."
  validation {
    condition     = var.bucket_prefix != null && 0 <= length(var.bucket_prefix) && length(var.bucket_prefix) <= 37
    error_message = "Error: bucket_prefix length must be in between 1 and 37 only."
  }
  sensitive = false
}

variable "force_destroy" {
  type        = bool
  default     = false
  description = "Whether to force delete all objects when destroying the bucket."
  validation {
    condition     = var.force_destroy == null || contains([true, false], var.force_destroy)
    error_message = "Error: force_destroy must be either true or false."
  }
  sensitive = false
}

variable "object_lock_enabled" {
  type        = bool
  default     = false
  description = "Indicates whether this bucket has an Object Lock configuration enabled."
  validation {
    condition     = var.force_destroy == null || contains([true, false], var.force_destroy)
    error_message = "Error: object_lock_enabled must be either true or false."
  }
  sensitive = false
}

variable "tags" {
  type = map(string)
  default = {
    AppName        = "WebAppFastAPI"
    Division       = "Platform"
  }
  description = "Map of tags to assign to the bucket."
  validation {
    condition     = var.tags != null && 0 < length(var.tags) && length(var.tags) < 51
    error_message = "Error: tags must contain between 1 and 50 entries."
  }
  sensitive = false
}

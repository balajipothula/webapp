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

variable "acl" {
  type        = string
  default     = "private"
  description = "The canned ACL to apply."
  validation {
    condition     = var.acl != null && contains(tolist(["authenticated-read", "aws-exec-read", "log-delivery-write", "private", "public-read", "public-read-write"]), var.acl)
    error_message = "Error: acl must not null and value must be authenticated-read, aws-exec-read, log-delivery-write, private, public-read, public-read-write."
  }
  sensitive = false
}

variable "policy" {
  type        = string
  default     = null
  description = "A valid bucket policy JSON document."
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
  validation {
    condition     = var.tags != null && 0 < length(var.tags) && length(var.tags) < 51
    error_message = "Error: tags at least one or more expected upto 50."
  }
  sensitive = false
}

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

variable "key" {
  type        = string
  default     = "v2022.01.20.18.30"
  description = "Name of the object once it is in the bucket."
  validation {
    condition     = var.key != null && 0 <= length(var.key) && length(var.key) <= 63
    error_message = "Error: key length must be in between 1 and 63 only."
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

variable "content" {
  type        = string
  default     = null
  description = "Path to a file that will be read and uploaded as raw bytes for the object content."
  sensitive = false
}

variable "etag" {
  type        = string
  default     = null
  description = "Triggers updates when the value changes."
  sensitive = false
}

variable "source_code" {
  type        = string
  default     = null
  description = "Triggers updates when the value changes."
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

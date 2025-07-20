# Resource type : aws_s3_object
# Resource name : generic
# Variable name : bucket

variable "bucket" {
  type        = string
  default     = null
  description = "Name of the bucket to put the file in."
  validation {
    condition     = var.bucket != null && 0 < length(var.bucket)
    error_message = "Error: bucket is required."
  }
  sensitive = false
}

variable "key" {
  type        = string
  default     = null
  description = "Name of the object once it is in the bucket."
  validation {
    condition     = var.key != null && 0 < length(var.key)
    error_message = "Error: key is required."
  }
  sensitive = false
}

variable "acl" {
  type        = string
  default     = null
  description = "Canned ACL to apply."
  validation {
    condition     = var.acl == null || contains(["private","public-read","public-read-write","aws-exec-read","authenticated-read","bucket-owner-read","bucket-owner-full-control"], var.acl)
    error_message = "Error: acl must be one of private, public-read, public-read-write, aws-exec-read, authenticated-read, bucket-owner-read, bucket-owner-full-control."
  }
  sensitive = false
}

variable "bucket_key_enabled" {
  type        = bool
  default     = false
  description = "Whether or not to use Amazon S3 Bucket Keys for SSE-KMS."
  validation {
    condition     = var.bucket_key_enabled == null || contains([true, false], var.bucket_key_enabled)
    error_message = "Error: bucket_key_enabled must be true or false."
  }
  sensitive = false
}

variable "cache_control" {
  type        = string
  default     = null
  description = "Caching behavior along the request/reply chain Read w3c cache_control for further details."
  sensitive   = false
}

variable "checksum_algorithm" {
  type        = string
  default     = null
  description = "Indicates the algorithm used to create the checksum for the object."
  validation {
    condition     = var.checksum_algorithm == null || contains(["CRC32","CRC32C","SHA1","SHA256"], var.checksum_algorithm)
    error_message = "Error: checksum_algorithm must be CRC32, CRC32C, SHA1, or SHA256."
  }
  sensitive = false
}

variable "content_base64" {
  type        = string
  default     = null
  description = "Base64-encoded data that will be decoded and uploaded as raw bytes for the object content."
  sensitive   = false
}

variable "content_disposition" {
  type        = string
  default     = null
  description = "Presentational information for the object."
  sensitive   = false
}

variable "content_encoding" {
  type        = string
  default     = null
  description = "Content encodings that have been applied to the object."
  sensitive   = false
}

variable "content_language" {
  type        = string
  default     = null
  description = "Language the content is in, e.g., en-US or en-GB."
  sensitive   = false
}

variable "content_type" {
  type        = string
  default     = null
  description = "Standard MIME type describing the format of the object data."
  sensitive   = false
}

variable "content" {
  type        = string
  default     = null
  description = "Literal string value to use as the object content."
  sensitive   = false
}

variable "etag" {
  type        = string
  default     = null
  description = "Triggers updates when the value changes."
  sensitive   = false
}

variable "force_destroy" {
  type        = bool
  default     = false
  description = "Whether to allow the object to be deleted by removing any legal hold on any object version."
  validation {
    condition     = var.force_destroy == null || contains([true, false], var.force_destroy)
    error_message = "Error: force_destroy must be true or false."
  }
  sensitive = false
}

variable "kms_key_id" {
  type        = string
  default     = null
  description = "ARN of the KMS Key to use for object encryption."
  sensitive   = false
}

variable "metadata" {
  type        = map(string)
  default     = null
  description = "Map of keys/values to provision metadata."
  sensitive   = false
}

variable "object_lock_legal_hold_status" {
  type        = string
  default     = null
  description = "Legal hold status that you want to apply to the specified object."
  validation {
    condition     = var.object_lock_legal_hold_status == null || contains(["ON","OFF"], var.object_lock_legal_hold_status)
    error_message = "Error: object_lock_legal_hold_status must be ON or OFF."
  }
  sensitive = false
}

variable "object_lock_mode" {
  type        = string
  default     = null
  description = "Object lock retention mode that you want to apply to this object."
  validation {
    condition     = var.object_lock_mode == null || contains(["GOVERNANCE","COMPLIANCE"], var.object_lock_mode)
    error_message = "Error: object_lock_mode must be GOVERNANCE or COMPLIANCE."
  }
  sensitive = false
}

variable "object_lock_retain_until_date" {
  type        = string
  default     = null
  description = "Date and time, in RFC3339 format, when this object's object lock will expire."
  sensitive   = false
}

variable "override_provider" {
  type        = any
  default     = null
  description = "Override provider-level configuration options."
  sensitive   = false
}

variable "server_side_encryption" {
  type        = string
  default     = null
  description = "Server-side encryption of the object in S3."
  validation {
    condition     = var.server_side_encryption == null || contains(["AES256","aws:kms"], var.server_side_encryption)
    error_message = "Error: server_side_encryption must be AES256 or aws:kms."
  }
  sensitive = false
}

variable "source_hash" {
  type        = string
  default     = null
  description = "Triggers updates like etag but useful to address etag encryption limitations."
  sensitive   = false
}

variable "source_path" {
  type        = string
  default     = null
  description = "Path to a file that will be read and uploaded as raw bytes for the object content."
  sensitive   = false
}

variable "storage_class" {
  type        = string
  default     = null
  description = "Storage Class for the object."
  sensitive   = false
}

variable "tags" {
  type        = map(string)
  default     = null
  description = "Map of tags to assign to the object."
  sensitive   = false
}

variable "website_redirect" {
  type        = string
  default     = null
  description = "Target URL for website redirect."
  sensitive   = false
}

# Resource  type : aws_s3_bucket
# Resource  name : generic
# Variable  name : bucket
variable "bucket" {
  type        = string
  default     = "aws-s3-bucket-generic"
  description = "Name of the bucket to which to apply the policy."
  validation {
    condition     = var.bucket != null && 0 <= length(var.bucket) && length(var.bucket) <= 63
    error_message = "Error: bucket name length must be in between 1 and 63 only."
  }
  sensitive = false
}

variable "policy" {
  type        = string
  default     = null
  description = "Text of the policy."
  validation {
    condition     = var.policy != null
    error_message = "Error: policy is not null and limited to 20 KB in size."
  }
  sensitive = false
}

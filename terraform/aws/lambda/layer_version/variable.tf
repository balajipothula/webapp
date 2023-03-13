variable "layer_name" {
  type        = string
  default     = "generic"
  description = "Unique name for your Lambda Layer"
  validation {
    condition     = var.layer_name != null && 0 < length(var.layer_name) && length(var.layer_name) < 65
    error_message = "Error: layer_name length must be in between 1 and 64 only."
  }
  sensitive   = false
}

variable "compatible_architectures" {
  type        = list(string)
  default     = ["arm64", "x86_64"]
  description = "List of Architectures this layer is compatible with."
  validation {
    condition     = var.compatible_architectures != null && 0 < length(var.compatible_architectures) && length(var.compatible_architectures) < 3
    error_message = "Error: architectures value must not null and valid list items are arm64 and x86_64."
  }
  sensitive   = false
}

variable "compatible_runtimes" {
  type        = list(string)
  default     = ["python2.7", "python3.6", "python3.7", "python3.8", "python3.9" ]
  description = "List of Runtimes this layer is compatible with."
  validation {
    condition     = var.compatible_runtimes != null && 0 < length(var.compatible_runtimes) && length(var.compatible_runtimes) < 6
    error_message = "Error: compatible_runtimes value must not null and length must be in between 1 and 5."
  }
  sensitive   = false
}

variable "description" {
  type        = string
  default     = "Lambda Function Library Layer."
  description = "Description of what your Lambda Layer does."
  validation {
    condition     = var.description != null && 0 <= length(var.description) && length(var.description) <= 256
    error_message = "Error: description value must not null and description lenght not more than 256 charecters."
  }
  sensitive   = false
}

variable "filename" {
  type        = string
  default     = "generic.zip"
  description = "Path to the function's deployment package within the local filesystem."
  validation {
    condition     = var.filename != null
    error_message = "Error: filename value must not null."
  }
  sensitive   = false
}

variable "license_info" {
  type        = string
  default     = "https://opensource.org/licenses/MIT"
  description = "License info for your Lambda Layer."
  validation {
    condition     = var.license_info != null
    error_message = "Error: license_info value must not null."
  }
  sensitive   = false
}

variable "s3_bucket" {
  type        = string
  default     = "webapplication-aws-s3-bucket"
  description = "S3 bucket location containing the function's deployment package, This bucket must reside in the same AWS region where you are creating the Lambda function."
  validation {
    condition     = var.s3_bucket != null
    error_message = "Error: s3_bucket value must not null."
  }
  sensitive   = false
}

variable "s3_key" {
  type        = string
  default     = "/generic/"
  description = "S3 key of an object containing the function's deployment package."
  validation {
    condition     = var.s3_key != null
    error_message = "Error: s3_key value must not null."
  }
  sensitive   = false
}

variable "s3_object_version" {
  type        = string
  default     = "L4kqtJlcpXroDTDmpUMLUo"
  description = "Object version containing the function's deployment package."
  validation {
    condition     = var.s3_object_version != null
    error_message = "Error: s3_object_version value must not null."
  }
  sensitive   = false
}

variable "skip_destroy" {
  type        = bool
  default     = false
  description = "Whether to retain the old version of a previously deployed Lambda Layer."
  validation {
    condition     = var.skip_destroy != null && contains(tolist([true, false]), var.skip_destroy)
    error_message = "Error: skip_destroy value must not null and skip_destroy value either true or false only."
  }
  sensitive   = false
}

variable "source_code_hash" {
  type        = string
  default     = null
  description = "Used to trigger updates."
  sensitive   = false
}

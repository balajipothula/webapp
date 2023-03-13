variable "function_name" {
  type        = string
  default     = "generic"
  description = "Unique name of the Lambda Function."
  validation {
    condition     = var.function_name != null && 0 < length(var.function_name) && length(var.function_name) < 65
    error_message = "Error: function_name length must be in between 1 and 64 only."
  }
  sensitive = false
}

variable "role" {
  type        = string
  default     = "arn:aws:iam:::role/LambdaIAMRole"
  description = "ARN of the Lambda function's execution role."
  validation {
    condition     = var.role != null
    error_message = "Error: role value must not null."
  }
  sensitive = false
}

variable "architectures" {
  type        = list(string)
  default     = ["x86_64"]
  description = "Instruction set architecture for your Lambda function."
  validation {
    condition     = var.architectures != null
    error_message = "Error: architectures value must not null and Valid values are [\"arm64\"] and [\"x86_64\"]."
  }
  sensitive = false
}

variable "code_signing_config_arn" {
  type        = string
  default     = ""
  description = "ARN of a code-signing configuration, enable code signing for this function."
  validation {
    condition     = var.code_signing_config_arn != null
    error_message = "Error: code_signing_config_arn value must not null."
  }
  sensitive = false
}

// dead_letter_config configuration block argument.
variable "target_arn" {
  type        = string
  default     = ""
  description = "ARN of an SNS topic or SQS queue to notify when an invocation fails."
  validation {
    condition     = var.target_arn != null
    error_message = "Error: role value must not null."
  }
  sensitive = false
}

variable "description" {
  type        = string
  default     = "Lambda Function Module."
  description = "Description of what Lambda Function does."
  validation {
    condition     = var.description != null && 0 < length(var.description) && length(var.description) < 256
    error_message = "Error: description value must not null and description lenght not more than 256 charecters."
  }
  sensitive = false
}

variable "environment_variables" {
  type        = map(string)
  description = "Map of environment variables that are accessible from the function code during execution."
  default = {
    environment = "dev"
  }
}

// file_system_config configuration block argument.
variable "efs_arn" {
  type        = string
  default     = ""
  description = "ARN of the Amazon EFS Access Point that provides access to the file system."
  validation {
    condition     = var.efs_arn != null
    error_message = "Error: efs_arn value must not null."
  }
  sensitive = false
}

// file_system_config configuration block argument.
variable "local_mount_path" {
  type        = string
  default     = "/mnt/"
  description = "Path where the function can access the file system."
  validation {
    condition     = var.local_mount_path != null
    error_message = "Error: local_mount_path value must not null and must start with /mnt/."
  }
  sensitive = false
}

variable "filename" {
  type        = string
  default     = ""
  description = "Path to the function's deployment package within the local filesystem."
  validation {
    condition     = var.filename != null
    error_message = "Error: filename value must not null."
  }
  sensitive = false
}

variable "handler" {
  type        = string
  default     = "lambda_function.lambda_handler"
  description = "Function entrypoint in your code."
  validation {
    condition     = var.handler != null
    error_message = "Error: handler value must not null."
  }
  sensitive = false
}

// image_config configuration block argument.
variable "command" {
  type = list(string)
  default = [
    "",
    "",
  ]
  description = "Parameters that you want to pass in with entry_point."
  validation {
    condition     = var.command != null
    error_message = "Error: command value must not null."
  }
  sensitive = false
}

// image_config configuration block argument.
variable "entry_point" {
  type = list(string)
  default = [
    "",
    "",
  ]
  description = "Entry point to your application."
  validation {
    condition     = var.entry_point != null
    error_message = "Error: entry_point value must not null."
  }
  sensitive = false
}

// image_config configuration block argument.
variable "working_directory" {
  type        = string
  default     = ""
  description = "Working directory."
  validation {
    condition     = var.working_directory != null
    error_message = "Error: working_directory value must not null."
  }
  sensitive = false
}

variable "image_uri" {
  type        = string
  default     = ""
  description = "ECR image URI containing the function's deployment package."
  validation {
    condition     = var.image_uri != null
    error_message = "Error: image_uri value must not null."
  }
  sensitive = false
}

variable "kms_key_arn" {
  type        = string
  default     = ""
  description = "ARN of the KMS key that is used to encrypt environment variables."
  validation {
    condition     = var.kms_key_arn != null
    error_message = "Error: kms_key_arn value must not null."
  }
  sensitive = false
}

variable "layers" {
  type = list(string)
  default = [
    "",
    "",
    "",
  ]
  description = "List of Lambda Layer Version ARNs to attach Lambda Function."
  validation {
    condition     = var.layers != null && 0 < length(var.layers) && length(var.layers) < 6
    error_message = "Error: layers value must not null."
  }
  sensitive = false
}

variable "memory_size" {
  type        = number
  default     = 128
  description = "Amount of memory (in MB) allocate to Lambda Function for runtime."
  validation {
    condition     = var.memory_size != null && 128 <= var.memory_size && var.memory_size <= 10240
    error_message = "Error: layers value must not null."
  }
  sensitive = false
}

variable "package_type" {
  type        = string
  default     = "Zip"
  description = "The Lambda Function deployment package type, Valid options are either Image or Zip."
  validation {
    condition     = var.package_type != null && contains(tolist(["Image", "Zip"]), var.package_type)
    error_message = "Error: package_type value must not null and package_type either Image or Zip."
  }
  sensitive = false
}

variable "publish" {
  type        = bool
  default     = false
  description = "New Lambda Function version creation / change publish."
  validation {
    condition     = var.publish != null && contains(tolist([true, false]), var.publish)
    error_message = "Error: publish value must not null and publish value either true or false only."
  }
  sensitive = false
}

variable "reserved_concurrent_executions" {
  type        = number
  default     = -1
  description = "Amount of reserved concurrent executions for Lambda Function."
  validation {
    condition     = var.reserved_concurrent_executions != null && contains(tolist([-1, 0]), var.reserved_concurrent_executions)
    error_message = "Error: reserved_concurrent_executions value must not null and reserved_concurrent_executions value either -1 or 0 only."
  }
  sensitive = false
}

variable "runtime" {
  type        = string
  default     = "python3.7"
  description = "Lambda Function execution runtime environment."
  validation {
    condition     = var.runtime != null && contains(tolist(["python3.7", "python3.8", "python3.9"]), var.runtime)
    error_message = "Error: runtime value must not null and runtime value is python3.7 or python3.8 or python3.9."
  }
  sensitive = false
}

variable "s3_bucket" {
  type        = string
  default     = "job-log-s3-bucket"
  description = "S3 Bucket name to store artifacts."
  validation {
    condition     = var.s3_bucket != null
    error_message = "Error: s3_bucket value must not null and both Lambda Function and S3 must in same region."
  }
  sensitive = false
}

variable "s3_key" {
  type        = string
  default     = "v1.0.3/job-log.zip"
  description = "S3 key of an object containing the Lambda Function's deployment package."
  validation {
    condition     = var.s3_key != null
    error_message = "Error: s3_key value must not null."
  }
  sensitive = false
}

variable "s3_object_version" {
  type        = string
  default     = ""
  description = "Object version containing the Lambda Function's deployment package."
  validation {
    condition     = var.s3_object_version != null
    error_message = "Error: s3_object_version value must not null."
  }
  sensitive = false
}

variable "source_code_hash" {
  type        = string
  default     = ""
  description = "Used to trigger updates."
  validation {
    condition     = var.source_code_hash != null
    error_message = "Error: source_code_hash value must not null."
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

variable "timeout" {
  type        = number
  default     = 30
  description = "Amount of time (in seconds) Lambda Function has to run in seconds."
  validation {
    condition     = var.timeout != null && 30 <= var.timeout && var.timeout <= 900
    error_message = "Error: timeout value must not null and timeout value must be in between 30 and 900."
  }
  sensitive = false
}

// tracing_config configuration block argument.
variable "mode" {
  type        = string
  default     = "Active"
  description = "Sample and trace a subset of incoming requests with AWS X-Ray."
  validation {
    condition     = var.mode != null && contains(tolist(["Active", "PassThrough"]), var.mode)
    error_message = "Error: mode value must not null and mode value either Active or PassThrough."
  }
  sensitive = false
}

// vpc_config configuration block argument.
variable "security_group_ids" {
  type = list(string)
  default = [
    "sg-086a967f",
  ]
  description = "Set of security group IDs associated with the Lambda Function."
  validation {
    condition     = var.security_group_ids != null && 0 < length(var.security_group_ids) && length(var.security_group_ids) < 6
    error_message = "Error: security_group_ids value must not null and security_group_ids length must be in between 1 and 5."
  }
  sensitive = false
}

// vpc_config configuration block argument.
variable "subnet_ids" {
  type = list(string)
  default = [
    "subnet-03fa50f3076b205e6",
    "subnet-05cb6848703e6176d",
    "subnet-013922d91332c8ab8",
  ]
  description = "Set of subnet IDs associated with the Lambda Function."
  validation {
    condition     = var.subnet_ids != null && 0 < length(var.subnet_ids) && length(var.subnet_ids) < 4
    error_message = "Error: subnet_ids value must not null and mode value either Active or PassThrough."
  }
  sensitive = false
}

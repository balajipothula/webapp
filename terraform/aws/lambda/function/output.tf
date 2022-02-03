# Resource  type : aws_lambda_function
# Resource  name : generic
# Attribute name : arn
output "arn" {
  value       = aws_lambda_function.generic.arn
  description = "The ARN of the Lambda Function."
  sensitive   = false
}

# Resource  type : aws_lambda_function
# Resource  name : generic
# Attribute name : function_name
output "function_name" {
  value       = aws_lambda_function.generic.function_name
  description = "Unique name for your Lambda Function."
  sensitive   = false
}

output "role" {
  value       = aws_lambda_function.generic.role
  description = "ARN of the function's execution role."
  sensitive   = false
}

output "code_signing_config_arn" {
  value       = aws_lambda_function.generic.code_signing_config_arn
  description = "A code-signing configuration includes a set of signing profiles."
  sensitive   = false
}

output "description" {
  value       = aws_lambda_function.generic.description
  description = "The description of the Lambda Function."
  sensitive   = false
}

output "handler" {
  value       = aws_lambda_function.generic.handler
  description = "The handler name of the Lambda Function."
  sensitive   = false
}

output "package_type" {
  value       = aws_lambda_function.generic.package_type
  description = "The package type of the Lambda Function."
  sensitive   = false
}

output "memory_size" {
  value       = aws_lambda_function.generic.memory_size
  description = "The memory size of the Lambda Function."
  sensitive   = false
}

output "invoke_arn" {
  value       = aws_lambda_function.generic.invoke_arn
  description = "The Invoke ARN of the Lambda Function."
  sensitive   = false
}

output "last_modified" {
  value       = aws_lambda_function.generic.last_modified
  description = "The date Lambda Function resource was last modified."
  sensitive   = false
}

output "qualified_arn" {
  value       = aws_lambda_function.generic.qualified_arn
  description = "The ARN identifying your Lambda Function Version."
  sensitive   = false
}

output "signing_job_arn" {
  value       = aws_lambda_function.generic.signing_job_arn
  description = "ARN of the signing job."
  sensitive   = false
}

output "signing_profile_version_arn" {
  value       = aws_lambda_function.generic.signing_profile_version_arn
  description = "ARN of the signing profile version."
  sensitive   = false
}

output "source_code_size" {
  value       = aws_lambda_function.generic.source_code_size
  description = "Size in bytes of the function .zip file."
  sensitive   = false
}

output "tags_all" {
  value       = aws_lambda_function.generic.tags_all
  description = "A map of tags assigned to the resource, including those inherited from the provider."
  sensitive   = false
}

output "version" {
  value       = aws_lambda_function.generic.version
  description = "Latest published version of your Lambda Function."
  sensitive   = false
}

output "vpc_config_vpc_id" {
  value       = aws_lambda_function.generic.vpc_config.*.vpc_id
  description = "ID of the VPC."
  sensitive   = false
}

output "kms_key_arn" {
  value       = aws_lambda_function.generic.kms_key_arn
  description = "The ARN for the KMS encryption key of Lambda Function."
  sensitive   = false
}

output "source_code_hash" {
  value       = aws_lambda_function.generic.source_code_hash
  description = "Base64-encoded representation of raw SHA-256 sum of the zip file."
  sensitive   = false
}

output "subnet_ids" {
  value       = aws_lambda_function.generic.vpc_config.*.subnet_ids
  description = "The subnet ids of Lambda Function."
  sensitive   = false
}

output "security_group_ids" {
  value       = aws_lambda_function.generic.vpc_config.*.security_group_ids
  description = "The security group ids of Lambda Function."
  sensitive   = false
}

output "tags" {
  value       = aws_lambda_function.generic.tags
  description = "The tags of Lambda Function."
  sensitive   = false
}

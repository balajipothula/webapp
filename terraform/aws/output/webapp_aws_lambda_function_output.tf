# Resource  type : module
# Module    name : webapp_aws_lambda_function
# Attribute name : arn
output "webapp_aws_lambda_function_arn" {
  value       = module.webapp_aws_lambda_function.arn
  description = "The ARN of the Lambda Function."
  sensitive   = false
}

output "webapp_aws_lambda_function_function_name" {
  value       = module.webapp_aws_lambda_function.function_name
  description = "Unique name for your Lambda Function."
  sensitive   = false
}

output "webapp_aws_lambda_function_role" {
  value       = module.webapp_aws_lambda_function.role
  description = "ARN of the function's execution role."
  sensitive   = false
}

output "webapp_aws_lambda_function_code_signing_config_arn" {
  value       = module.webapp_aws_lambda_function.code_signing_config_arn
  description = "A code-signing configuration includes a set of signing profiles."
  sensitive   = false
}

output "webapp_aws_lambda_function_description" {
  value       = module.webapp_aws_lambda_function.description
  description = "The description of the Lambda Function."
  sensitive   = false
}

output "webapp_aws_lambda_function_handler" {
  value       = module.webapp_aws_lambda_function.handler
  description = "The handler name of the Lambda Function."
  sensitive   = false
}

output "webapp_aws_lambda_function_package_type" {
  value       = module.webapp_aws_lambda_function.package_type
  description = "The package type of the Lambda Function."
  sensitive   = false
}

output "webapp_aws_lambda_function_memory_size" {
  value       = module.webapp_aws_lambda_function.memory_size
  description = "The memory size of the Lambda Function."
  sensitive   = false
}

output "webapp_aws_lambda_function_invoke_arn" {
  value       = module.webapp_aws_lambda_function.invoke_arn
  description = "The Invoke ARN of the Lambda Function."
  sensitive   = false
}

output "webapp_aws_lambda_function_last_modified" {
  value       = module.webapp_aws_lambda_function.last_modified
  description = "The date Lambda Function resource was last modified."
  sensitive   = false
}

output "webapp_aws_lambda_function_qualified_arn" {
  value       = module.webapp_aws_lambda_function.qualified_arn
  description = "The ARN identifying your Lambda Function Version."
  sensitive   = false
}

output "webapp_aws_lambda_function_signing_job_arn" {
  value       = module.webapp_aws_lambda_function.signing_job_arn
  description = "ARN of the signing job."
  sensitive   = false
}

output "webapp_aws_lambda_function_signing_profile_version_arn" {
  value       = module.webapp_aws_lambda_function.signing_profile_version_arn
  description = "ARN of the signing profile version."
  sensitive   = false
}

output "webapp_aws_lambda_function_source_code_size" {
  value       = module.webapp_aws_lambda_function.source_code_size
  description = "Size in bytes of the function .zip file."
  sensitive   = false
}

output "webapp_aws_lambda_function_tags_all" {
  value       = module.webapp_aws_lambda_function.tags_all
  description = "A map of tags assigned to the resource, including those inherited from the provider."
  sensitive   = false
}

output "webapp_aws_lambda_function_version" {
  value       = module.webapp_aws_lambda_function.version
  description = "Latest published version of your Lambda Function."
  sensitive   = false
}

output "webapp_aws_lambda_function_kms_key_arn" {
  value       = module.webapp_aws_lambda_function.kms_key_arn
  description = "The ARN for the KMS encryption key of Lambda Function."
  sensitive   = false
}

output "webapp_aws_lambda_function_source_code_hash" {
  value       = module.webapp_aws_lambda_function.source_code_hash
  description = "Base64-encoded representation of raw SHA-256 sum of the zip file."
  sensitive   = false
}

output "webapp_aws_lambda_function_tags" {
  value       = module.webapp_aws_lambda_function.tags
  description = "The tags of Lambda Function."
  sensitive   = false
}

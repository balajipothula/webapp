# Resource  type : random_pet
# Resource  name : name
# Attribute name : id
output "id" {
  value       = random_pet.name.id
  description = "The random pet name."
  sensitive   = false
}

# Resource  type : module
# Resource  name : aws_lambda_function_webapp
# Attribute name : arn
output "arn" {
  value       = module.aws_lambda_function_webapp.arn
  description = "The ARN of the Lambda Function."
  sensitive   = false
}

# Resource  type : module
# Resource  name : aws_lambda_function_webapp
# Attribute name : function_name
output "function_name" {
  value       = module.aws_lambda_function_webapp.function_name
  description = "Unique name for your Lambda Function."
  sensitive   = false
}

output "role" {
  value       = module.aws_lambda_function_webapp.role
  description = "ARN of the function's execution role."
  sensitive   = false
}

output "code_signing_config_arn" {
  value       = module.aws_lambda_function_webapp.code_signing_config_arn
  description = "A code-signing configuration includes a set of signing profiles."
  sensitive   = false
}

output "aws_lambda_function__description" {
  value       = module.aws_lambda_function_webapp.aws_lambda_function__description
  description = "The description of the Lambda Function."
  sensitive   = false
}

output "handler" {
  value       = module.aws_lambda_function_webapp.handler
  description = "The handler name of the Lambda Function."
  sensitive   = false
}

output "package_type" {
  value       = module.aws_lambda_function_webapp.package_type
  description = "The package type of the Lambda Function."
  sensitive   = false
}

output "memory_size" {
  value       = module.aws_lambda_function_webapp.memory_size
  description = "The memory size of the Lambda Function."
  sensitive   = false
}

output "invoke_arn" {
  value       = module.aws_lambda_function_webapp.invoke_arn
  description = "The Invoke ARN of the Lambda Function."
  sensitive   = false
}

output "last_modified" {
  value       = module.aws_lambda_function_webapp.last_modified
  description = "The date Lambda Function resource was last modified."
  sensitive   = false
}

output "qualified_arn" {
  value       = module.aws_lambda_function_webapp.qualified_arn
  description = "The ARN identifying your Lambda Function Version."
  sensitive   = false
}

output "signing_job_arn" {
  value       = module.aws_lambda_function_webapp.signing_job_arn
  description = "ARN of the signing job."
  sensitive   = false
}

output "signing_profile_version_arn" {
  value       = module.aws_lambda_function_webapp.signing_profile_version_arn
  description = "ARN of the signing profile version."
  sensitive   = false
}

output "source_code_size" {
  value       = module.aws_lambda_function_webapp.source_code_size
  description = "Size in bytes of the function .zip file."
  sensitive   = false
}

output "tags_all" {
  value       = module.aws_lambda_function_webapp.tags_all
  description = "A map of tags assigned to the resource, including those inherited from the provider."
  sensitive   = false
}

output "version" {
  value       = module.aws_lambda_function_webapp.version
  description = "Latest published version of your Lambda Function."
  sensitive   = false
}



output "kms_key_arn" {
  value       = module.aws_lambda_function_webapp.kms_key_arn
  description = "The ARN for the KMS encryption key of Lambda Function."
  sensitive   = false
}

output "source_code_hash" {
  value       = module.aws_lambda_function_webapp.source_code_hash
  description = "Base64-encoded representation of raw SHA-256 sum of the zip file."
  sensitive   = false
}

output "aws_region" {
  value       = data.aws_region.current.name
  description = "The name of the selected region."
  sensitive   = false
}

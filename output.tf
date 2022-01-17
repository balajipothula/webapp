output "aws_region" {
  value       = data.aws_region.current.name
  description = "The name of the selected region."
  sensitive   = false
}

output "aws_vpc" {
  value       = data.aws_vpc.default.id
  description = "The id of the specific VPC to retrieve."
  sensitive   = false
}

output "aws_subnet_ids" {
  value       = data.aws_subnet_ids.available.ids
  description = "A set of all the subnet ids found."
  sensitive   = false
}

output "aws_security_groups" {
  value       = data.aws_security_groups.default.ids
  description = "IDs of the matches security groups."
  sensitive   = false
}

# Resource  type : module
# Module    name : aws_lambda_function_webapp
# Attribute name : arn
output "arn" {
  value       = module.aws_lambda_function_webapp.arn
  description = "The ARN of the Lambda Function."
  sensitive   = false
}

# Resource  type : module
# Module    name : aws_lambda_function_webapp
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

output "description" {
  value       = module.aws_lambda_function_webapp.description
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

output "vpc_config_vpc_id" {
  value       = module.aws_lambda_function_webapp.vpc_config.*.vpc_id
  description = "ID of the VPC."
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

output "subnet_ids" {
  value       = module.aws_lambda_function_webapp.vpc_config.*.subnet_ids
  description = "The subnet ids of Lambda Function."
  sensitive   = false
}

output "security_group_ids" {
  value       = module.aws_lambda_function_webapp.vpc_config.*.security_group_ids
  description = "The security group ids of Lambda Function."
  sensitive   = false
}

output "tags" {
  value       = var.tags
  description = "The tags of Lambda Function."
  sensitive   = false
}
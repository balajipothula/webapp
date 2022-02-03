# Resource  type : module
# Module    name : webapp_aws_lambda_layer_version
# Attribute name : arn
output "webapp_aws_lambda_layer_version_arn" {
  value       = module.webapp_aws_lambda_layer_version.arn
  description = "ARN of the Lambda Layer with version."
  sensitive   = false
}

output "webapp_aws_lambda_layer_version_created_date" {
  value       = module.webapp_aws_lambda_layer_version.created_date
  description = "Date this resource was created."
  sensitive   = false
}

output "webapp_aws_lambda_layer_version_layer_arn" {
  value       = module.webapp_aws_lambda_layer_version.layer_arn
  description = "ARN of the Lambda Layer without version."
  sensitive   = false
}

output "webapp_aws_lambda_layer_version_signing_job_arn" {
  value       = module.webapp_aws_lambda_layer_version.signing_job_arn
  description = "ARN of a signing job."
  sensitive   = false
}

output "webapp_aws_lambda_layer_version_signing_profile_version_arn" {
  value       = module.webapp_aws_lambda_layer_version.signing_profile_version_arn
  description = "ARN for a signing profile version."
  sensitive   = false
}

output "webapp_aws_lambda_layer_version_source_code_size" {
  value       = module.webapp_aws_lambda_layer_version.source_code_size
  description = "Size in bytes of the function .zip file."
  sensitive   = false
}

output "webapp_aws_lambda_layer_version_version" {
  value       = module.webapp_aws_lambda_layer_version.version
  description = "Lambda Layer version."
  sensitive   = false
}

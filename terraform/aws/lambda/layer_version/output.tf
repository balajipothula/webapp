# Resource  type : aws_lambda_layer_version
# Resource  name : generic
# Attribute name : arn
output "arn" {
  value       = aws_lambda_layer_version.generic.arn
  description = "ARN of the Lambda Layer with version."
  sensitive   = false
}

output "created_date" {
  value       = aws_lambda_layer_version.generic.created_date
  description = "Date this resource was created."
  sensitive   = false
}

output "layer_arn" {
  value       = aws_lambda_layer_version.generic.layer_arn
  description = "ARN of the Lambda Layer without version."
  sensitive   = false
}

output "signing_job_arn" {
  value       = aws_lambda_layer_version.generic.signing_job_arn
  description = "ARN of a signing job."
  sensitive   = false
}

output "signing_profile_version_arn" {
  value       = aws_lambda_layer_version.generic.signing_profile_version_arn
  description = "ARN for a signing profile version."
  sensitive   = false
}

output "source_code_size" {
  value       = aws_lambda_layer_version.generic.source_code_size
  description = "Size in bytes of the function .zip file."
  sensitive   = false
}

output "version" {
  value       = aws_lambda_layer_version.generic.version
  description = "Lambda Layer version."
  sensitive   = false
}

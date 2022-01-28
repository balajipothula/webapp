/*
# Resource  type : module
# Module    name : webapp_aws_secretsmanager_secret_version
# Attribute name : arn
output "webapp_aws_secretsmanager_secret_version_arn" {
  value       = module.webapp_aws_secretsmanager_secret_version.arn
  description = "The ARN of the secret."
  sensitive   = false
}

output "webapp_aws_secretsmanager_secret_version_id" {
  value       = module.webapp_aws_secretsmanager_secret_version.id
  description = "A pipe delimited combination of secret ID and version ID."
  sensitive   = false
}

output "webapp_aws_secretsmanager_secret_version_version_id" {
  value       = module.webapp_aws_secretsmanager_secret_version.version_id
  description = "The unique identifier of the version of the secret."
  sensitive   = false
}
*/
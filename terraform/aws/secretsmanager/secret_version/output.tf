# Resource  type : aws_secretsmanager_secret_version
# Resource  name : generic
# Attribute name : arn
output "arn" {
  value       = aws_secretsmanager_secret_version.generic.arn
  description = "The ARN of the secret."
  sensitive   = false
}

output "id" {
  value       = aws_secretsmanager_secret_version.generic.id
  description = "A pipe delimited combination of secret ID and version ID."
  sensitive   = false
}

output "version_id" {
  value       = aws_secretsmanager_secret_version.generic.version_id
  description = "The unique identifier of the version of the secret."
  sensitive   = false
}

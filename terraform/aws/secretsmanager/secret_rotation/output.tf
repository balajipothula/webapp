# Resource  type : aws_secretsmanager_secret_version
# Resource  name : generic
# Attribute name : arn
output "arn" {
  value       = aws_secretsmanager_secret_rotation.generic.arn
  description = "The ARN of the secret."
  sensitive   = false
}

output "id" {
  value       = aws_secretsmanager_secret_rotation.generic.id
  description = "The ARN of the secret."
  sensitive   = false
}

output "rotation_enabled" {
  value       = aws_secretsmanager_secret_rotation.generic.version_id
  description = "Specifies whether automatic rotation is enabled for this secret."
  sensitive   = false
}

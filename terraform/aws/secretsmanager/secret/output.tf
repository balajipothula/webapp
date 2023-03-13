# Resource  type : aws_secretsmanager_secret
# Resource  name : generic
# Attribute name : id
output "id" {
  value       = aws_secretsmanager_secret.generic.id
  description = "ARN of the secret."
  sensitive   = false
}

output "arn" {
  value       = aws_secretsmanager_secret.generic.arn
  description = "ARN of the secret."
  sensitive   = false
}

output "replica" {
  value       = aws_secretsmanager_secret.generic.replica
  description = "Attributes of a replica are described below."
  sensitive   = false
}

output "tags_all" {
  value       = aws_secretsmanager_secret.generic.tags_all
  description = "Map of tags assigned to the resource."
  sensitive   = false
}

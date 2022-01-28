# Resource  type : module
# Module    name : webapp_aws_secretsmanager_secret
# Attribute name : id

output "webapp_aws_secretsmanager_secret_id" {
  value       = module.webapp_aws_secretsmanager_secret.id
  description = "ARN of the secret."
  sensitive   = false
}

output "webapp_aws_secretsmanager_secret_arn" {
  value       = module.webapp_aws_secretsmanager_secret.arn
  description = "ARN of the secret."
  sensitive   = false
}

output "webapp_aws_secretsmanager_secret_rotation_enabled" {
  value       = module.webapp_aws_secretsmanager_secret.rotation_enabled
  description = "Whether automatic rotation is enabled for this secret."
  sensitive   = false
}

output "webapp_aws_secretsmanager_secret_replica" {
  value       = module.webapp_aws_secretsmanager_secret.replica
  description = "Attributes of a replica are described below."
  sensitive   = false
}

output "webapp_aws_secretsmanager_secret_tags_all" {
  value       = module.webapp_aws_secretsmanager_secret.tags_all
  description = "Map of tags assigned to the resource."
  sensitive   = false
}

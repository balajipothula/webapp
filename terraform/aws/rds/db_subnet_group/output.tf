# Resource type : aws_db_subnet_group
# Resource  name : generic
# Attribute name : id

output "id" {
  value       = aws_db_subnet_group.generic.id
  description = "The DB subnet group name."
  sensitive   = false
}

output "arn" {
  value       = aws_db_subnet_group.generic.arn
  description = "ARN of the DB subnet group."
  sensitive   = false
}

output "supported_network_types" {
  value       = aws_db_subnet_group.generic.supported_network_types
  description = "The network type of the DB subnet group."
  sensitive   = false
}

output "tags_all" {
  value       = aws_db_subnet_group.generic.tags_all
  description = "A map of tags assigned to the resource, including those inherited from the provider."
  sensitive   = false
}

output "vpc_id" {
  value       = aws_db_subnet_group.generic.vpc_id
  description = "Provides the VPC ID of the DB subnet group."
  sensitive   = false
}

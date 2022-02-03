# Resource  type : aws_default_security_group
# Resource  name : default
# Attribute name : arn
output "arn" {
  value       = aws_default_security_group.default.arn
  description = "ARN of the security group."
  sensitive   = false
}

output "description" {
  value       = aws_default_security_group.default.description
  description = "Description of the security group."
  sensitive   = false
}

output "id" {
  value       = aws_default_security_group.default.id
  description = "ID of the security group."
  sensitive   = false
}

output "name" {
  value       = aws_default_security_group.default.name
  description = "Name of the security group."
  sensitive   = false
}

output "owner_id" {
  value       = aws_default_security_group.default.owner_id
  description = "Owner ID."
  sensitive   = false
}

output "tags_all" {
  value       = aws_default_security_group.default.owner_id
  description = "A map of tags assigned to the resource."
  sensitive   = false
}

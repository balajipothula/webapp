# Resource  type : aws_security_group
# Resource  name : generic
# Attribute name : arn
output "arn" {
  value       = aws_security_group.generic.arn
  description = "ARN of the security group."
  sensitive   = false
}

output "id" {
  value       = aws_security_group.generic.id
  description = "ID of the security group."
  sensitive   = false
}

output "owner_id" {
  value       = aws_security_group.generic.owner_id
  description = "Owner ID."
  sensitive   = false
}

output "tags_all" {
  value       = aws_security_group.generic.tags_all
  description = "A map of tags assigned to the resource."
  sensitive   = false
}

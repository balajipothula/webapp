# Resource  type : aws_iam_role
# Resource  name : generic
# Attribute name : arn
output "arn" {
  value       = aws_iam_role.generic.arn
  description = "ARN specifying the role."
  sensitive   = false
}

# Resource  type : aws_iam_role
# Resource  name : generic
# Attribute name : name
output "name" {
  value       = aws_iam_role.generic.name
  description = "Name of the role."
  sensitive   = false
}
# Resource  type : aws_iam_role
# Resource  name : generic
# Attribute name : arn
output "arn" {
  value       = aws_iam_role.generic.arn
  description = "ARN specifying the role."
  sensitive   = false
}

output "create_date" {
  value       = aws_iam_role.generic.create_date
  description = "Creation date of the IAM role."
  sensitive   = false
}

output "id" {
  value       = aws_iam_role.generic.id
  description = "Name of the role."
  sensitive   = false
}

output "name" {
  value       = aws_iam_role.generic.name
  description = "Name of the role."
  sensitive   = false
}

output "tags_all" {
  value       = aws_iam_role.generic.tags_all
  description = "A map of tags assigned to the resource."
  sensitive   = false
}

output "unique_id" {
  value       = aws_iam_role.generic.unique_id
  description = "Stable and unique string identifying the role."
  sensitive   = false
}

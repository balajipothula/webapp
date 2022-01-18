# Resource  type : module
# Module    name : webapp_aws_iam_role
# Attribute name : arn
output "arn" {
  value       = module.webapp_aws_iam_role.arn
  description = "Amazon Resource Name (ARN) specifying the role."
  sensitive   = false
}

output "create_date" {
  value       = module.webapp_aws_iam_role.create_date
  description = "Creation date of the IAM role."
  sensitive   = false
}

output "id" {
  value       = module.webapp_aws_iam_role.id
  description = "Name of the role."
  sensitive   = false
}

output "name" {
  value       = module.webapp_aws_iam_role.name
  description = "Name of the role."
  sensitive   = false
}

output "tags_all" {
  value       = module.webapp_aws_iam_role.tags_all
  description = "A map of tags assigned to the resource."
  sensitive   = false
}

output "unique_id" {
  value       = module.webapp_aws_iam_role.unique_id
  description = "Stable and unique string identifying the role."
  sensitive   = false
}

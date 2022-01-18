# Resource  type : module
# Module    name : webapp_aws_iam_role
# Attribute name : arn
output "webapp_aws_iam_role_arn" {
  value       = module.webapp_aws_iam_role.arn
  description = "Amazon Resource Name (ARN) specifying the role."
  sensitive   = false
}

output "webapp_aws_iam_create_date" {
  value       = module.webapp_aws_iam_role.create_date
  description = "Creation date of the IAM role."
  sensitive   = false
}

output "webapp_aws_iam_id" {
  value       = module.webapp_aws_iam_role.id
  description = "Name of the role."
  sensitive   = false
}

output "webapp_aws_iam_name" {
  value       = module.webapp_aws_iam_role.name
  description = "Name of the role."
  sensitive   = false
}

output "webapp_aws_iam_webapp_aws_iam_role_tags_all" {
  value       = module.webapp_aws_iam_role.tags_all
  description = "A map of tags assigned to the resource."
  sensitive   = false
}

output "webapp_aws_iam_unique_id" {
  value       = module.webapp_aws_iam_role.unique_id
  description = "Stable and unique string identifying the role."
  sensitive   = false
}

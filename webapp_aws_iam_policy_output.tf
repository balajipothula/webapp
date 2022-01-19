# Resource  type : module
# Module    name : webapp_aws_iam_policy
# Attribute name : id
output "webapp_aws_iam_policy_id" {
  value       = module.webapp_aws_iam_policy.id
  description = "The ARN assigned by AWS to this policy."
  sensitive   = false
}

output "webapp_aws_iam_policy_arn" {
  value       = module.webapp_aws_iam_policy.arn
  description = "The ARN assigned by AWS to this policy."
  sensitive   = false
}

output "webapp_aws_iam_policy_description" {
  value       = module.webapp_aws_iam_policy.description
  description = "The description of the policy."
  sensitive   = false
}

output "webapp_aws_iam_policy_name" {
  value       = module.webapp_aws_iam_policy.name
  description = "The name of the policy."
  sensitive   = false
}

output "webapp_aws_iam_policy_path" {
  value       = module.webapp_aws_iam_policy.path
  description = "The path of the policy in IAM."
  sensitive   = false
}

output "webapp_aws_iam_policy_policy" {
  value       = module.webapp_aws_iam_policy.policy
  description = "The policy document."
  sensitive   = false
}

output "webapp_aws_iam_policy_policy_id" {
  value       = module.webapp_aws_iam_policy.policy_id
  description = "The policy's ID."
  sensitive   = false
}

output "webapp_aws_iam_policy_tags_all" {
  value       = module.webapp_aws_iam_policy.tags_all
  description = "A map of tags assigned to the resource."
  sensitive   = false
}

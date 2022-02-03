# Resource  type : aws_iam_policy
# Resource  name : generic
# Attribute name : id
output "id" {
  value       = aws_iam_policy.generic.id
  description = "The ARN assigned by AWS to this policy."
  sensitive   = false
}

output "arn" {
  value       = aws_iam_policy.generic.arn
  description = "The ARN assigned by AWS to this policy."
  sensitive   = false
}

output "description" {
  value       = aws_iam_policy.generic.description
  description = "The description of the policy."
  sensitive   = false
}

output "name" {
  value       = aws_iam_policy.generic.name
  description = "The name of the policy."
  sensitive   = false
}

output "path" {
  value       = aws_iam_policy.generic.path
  description = "The path of the policy in IAM."
  sensitive   = false
}

output "policy" {
  value       = aws_iam_policy.generic.policy
  description = "The policy document."
  sensitive   = false
}

output "policy_id" {
  value       = aws_iam_policy.generic.policy_id
  description = "The policy's ID."
  sensitive   = false
}

output "tags_all" {
  value       = aws_iam_policy.generic.tags_all
  description = "A map of tags assigned to the resource."
  sensitive   = false
}

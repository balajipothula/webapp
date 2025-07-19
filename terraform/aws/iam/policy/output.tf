# Resource  type : aws_iam_policy
# Resource  name : generic
# Attribute name : arn
output "arn" {
  value       = aws_iam_policy.generic.arn
  description = "The ARN assigned by AWS to this policy."
  sensitive   = false
}

output "attachment_count" {
  value       = aws_iam_policy.generic.attachment_count
  description = "Number of entities (users, groups, and roles) that the policy is attached to."
  sensitive   = false
}

output "id" {
  value       = aws_iam_policy.generic.id
  description = "The ARN assigned by AWS to this policy."
  sensitive   = false
}

output "name" {
  value       = aws_iam_policy.generic.name
  description = "The name of the policy."
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

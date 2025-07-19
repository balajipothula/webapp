output "id" {
  value       = aws_iam_policy_attachment.generic.id
  description = "Policy's ID."
  sensitive   = false
}

output "name" {
  value       = aws_iam_policy_attachment.generic.name
  description = "Name of the attachment."
  sensitive   = false
}

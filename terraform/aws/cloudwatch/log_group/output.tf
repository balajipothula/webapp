# Resource  type : aws_cloudwatch_log_group
# Resource  name : generic
# Attribute name : arn
output "arn" {
  value       = aws_cloudwatch_log_group.generic.arn
  description = "The ARN specifying the log group."
  sensitive   = false
}

output "tags_all" {
  value       = aws_cloudwatch_log_group.generic.tags_all
  description = "A map of tags assigned to the resource"
  sensitive   = false
}

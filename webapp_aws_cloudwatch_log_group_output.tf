output "arn" {
  value       = module.webapp_aws_cloudwatch_log_group.arn
  description = "The ARN specifying the log group."
  sensitive   = false
}

output "tags_all" {
  value       = module.webapp_aws_cloudwatch_log_group.tags_all
  description = "A map of tags assigned to the resource"
  sensitive   = false
}

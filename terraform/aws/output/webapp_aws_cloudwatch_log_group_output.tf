# Resource  type : module
# Module    name : webapp_aws_cloudwatch_log_group
# Attribute name : arn
output "webapp_aws_cloudwatch_log_group_arn" {
  value       = module.webapp_aws_cloudwatch_log_group.arn
  description = "The ARN specifying the log group."
  sensitive   = false
}

output "webapp_aws_cloudwatch_log_group_tags_all" {
  value       = module.webapp_aws_cloudwatch_log_group.tags_all
  description = "A map of tags assigned to the resource"
  sensitive   = false
}

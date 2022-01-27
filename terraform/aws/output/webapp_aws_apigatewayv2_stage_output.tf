# Resource  type : module
# Module    name : webapp_aws_apigatewayv2_stage_id
# Attribute name : id

output "webapp_aws_apigatewayv2_stage_id" {
  value       = module.webapp_aws_apigatewayv2_stage.id
  description = "The stage identifier."
  sensitive   = false
}

output "webapp_aws_apigatewayv2_stage_arn" {
  value       = module.webapp_aws_apigatewayv2_stage.arn
  description = "The ARN of the stage."
  sensitive   = false
}

output "webapp_aws_apigatewayv2_stage_execution_arn" {
  value       = module.webapp_aws_apigatewayv2_stage.execution_arn
  description = "The ARN prefix to be used in an aws_lambda_permission's source_arn attribute."
  sensitive   = false
}

output "webapp_aws_apigatewayv2_stage_invoke_url" {
  value       = module.webapp_aws_apigatewayv2_stage.invoke_url
  description = "The ARN prefix to be used in an aws_lambda_permission's source_arn attribute or in an aws_iam_policy to authorize access to the @connections API."
  sensitive   = false
}

output "webapp_aws_apigatewayv2_stage_tags_all" {
  value       = module.webapp_aws_apigatewayv2_stage.tags_all
  description = "A map of tags assigned to the resource"
  sensitive   = false
}

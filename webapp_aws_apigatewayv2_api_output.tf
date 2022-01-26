# Resource  type : module
# Module    name : webapp_aws_apigatewayv2_api
# Attribute name : id
output "webapp_aws_apigatewayv2_api_id" {
  value       = module.webapp_aws_apigatewayv2_api.id
  description = "The API identifier."
  sensitive   = false
}

output "webapp_aws_apigatewayv2_api_api_endpoint" {
  value       = module.webapp_aws_apigatewayv2_api.api_endpoint
  description = "The URI of the API."
  sensitive   = false
}

output "webapp_aws_apigatewayv2_api_arn" {
  value       = module.webapp_aws_apigatewayv2_api.arn
  description = "The ARN of the API."
  sensitive   = false
}

output "webapp_aws_apigatewayv2_api_execution_arn" {
  value       = module.webapp_aws_apigatewayv2_api.execution_arn
  description = "The ARN prefix to be used in an aws_lambda_permission's source_arn attribute or in an aws_iam_policy to authorize access to the @connections API."
  sensitive   = false
}

output "webapp_aws_apigatewayv2_api_tags_all" {
  value       = module.webapp_aws_apigatewayv2_api.tags_all
  description = " A map of tags assigned to the resource"
  sensitive   = false
}

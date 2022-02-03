# Resource  type : aws_apigatewayv2_api
# Resource  name : generic
# Attribute name : id
output "id" {
  value       = aws_apigatewayv2_api.generic.id
  description = "The API identifier."
  sensitive   = false
}

output "api_endpoint" {
  value       = aws_apigatewayv2_api.generic.api_endpoint
  description = "The URI of the API."
  sensitive   = false
}

output "arn" {
  value       = aws_apigatewayv2_api.generic.arn
  description = "The ARN of the API."
  sensitive   = false
}

output "execution_arn" {
  value       = aws_apigatewayv2_api.generic.execution_arn
  description = "The ARN prefix to be used in an aws_lambda_permission's source_arn attribute or in an aws_iam_policy to authorize access to the @connections API."
  sensitive   = false
}

output "tags_all" {
  value       = aws_apigatewayv2_api.generic.tags_all
  description = " A map of tags assigned to the resource"
  sensitive   = false
}

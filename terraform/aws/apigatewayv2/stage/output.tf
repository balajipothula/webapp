# Resource  type : aws_apigatewayv2_stage
# Resource  name : generic
# Attribute name : id
output "id" {
  value       = aws_apigatewayv2_stage.generic.id
  description = "The stage identifier."
  sensitive   = false
}

output "webapp_aws_apigatewayv2_stage_arn" {
  value       = aws_apigatewayv2_stage.generic.arn
  description = "The ARN of the stage."
  sensitive   = false
}

output "webapp_aws_apigatewayv2_stage_execution_arn" {
  value       = aws_apigatewayv2_stage.generic.execution_arn
  description = "The ARN prefix to be used in an aws_lambda_permission's source_arn attribute."
  sensitive   = false
}

output "webapp_aws_apigatewayv2_stage_invoke_url" {
  value       = aws_apigatewayv2_stage.generic.invoke_url
  description = "The ARN prefix to be used in an aws_lambda_permission's source_arn attribute or in an aws_iam_policy to authorize access to the @connections API."
  sensitive   = false
}

output "webapp_aws_apigatewayv2_stage_tags_all" {
  value       = aws_apigatewayv2_stage.generic.tags_all
  description = "A map of tags assigned to the resource"
  sensitive   = false
}

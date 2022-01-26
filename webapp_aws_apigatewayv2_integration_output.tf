# Resource  type : module
# Resource  name : webapp_aws_apigatewayv2_integration
# Attribute name : id
output "webapp_aws_apigatewayv2_integration_id" {
  value       = module.webapp_aws_apigatewayv2_integration.id
  description = "The integration identifier."
  sensitive   = false
}

output "webapp_aws_apigatewayv2_integration_integration_response_selection_expression" {
  value       = module.webapp_aws_apigatewayv2_integration.integration_response_selection_expression
  description = "The integration response selection expression for the integration."
  sensitive   = false
}

# Resource  type : aws_apigatewayv2_integration
# Resource  name : generic
# Attribute name : id
output "id" {
  value       = aws_apigatewayv2_integration.generic.id
  description = "The integration identifier."
  sensitive   = false
}

output "integration_response_selection_expression" {
  value       = aws_apigatewayv2_integration.generic.integration_response_selection_expression
  description = "The integration response selection expression for the integration."
  sensitive   = false
}

# Resource  type : module
# Module    name : webapp_aws_apigatewayv2_route
# Attribute name : id
output "webapp_aws_apigatewayv2_route_id" {
  value       = module.webapp_aws_apigatewayv2_route.id
  description = "The route identifier."
  sensitive   = false
}

# Resource  type : aws_apigatewayv2_route
# Resource  name : generic
# Attribute name : id
output "id" {
  value       = aws_apigatewayv2_route.generic.id
  description = "The route identifier."
  sensitive   = false
}

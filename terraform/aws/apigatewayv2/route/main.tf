# Resource type : aws_apigatewayv2_route
# Resource name : generic
# Argument name : api_id
# Variable name : api_id
resource "aws_apigatewayv2_route" "generic" {

  api_id    = var.api_id    # Required argument.
  route_key = var.route_key # Required argument.
  target    = var.target    # Optional argument, but keep it.

}

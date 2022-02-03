# Resource type : aws_apigatewayv2_api
# Resource name : generic
# Argument name : name
# Variable name : name
resource "aws_apigatewayv2_api" "generic" {

  name          = var.name          # Required argument.
  protocol_type = var.protocol_type # Required argument.

}

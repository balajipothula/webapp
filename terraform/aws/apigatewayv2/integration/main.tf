# Resource type : aws_apigatewayv2_integration
# Resource name : generic
# Argument name : api_id
# Variable name : api_id
resource "aws_apigatewayv2_integration" "generic" {

  api_id             = var.api_id             # Required argument.
  integration_type   = var.integration_type   # Required argument.
  integration_uri    = var.integration_uri    # Optional argument, but keep it.
  integration_method = var.integration_method # Optional argument, but keep it.

}

# Resource type : aws_apigatewayv2_stage
# Resource name : generic
# Argument name : api_id
# Variable name : api_id
resource "aws_apigatewayv2_stage" "generic" {

  api_id            = var.api_id          # Required argument.
  name              = var.name            # Required argument.
  auto_deploy       = var.auto_deploy     # Optional argument, but keep it.
/*  
  access_log_settings {                   # Optional block, but keep it.
    destination_arn = var.destination_arn # Required block argument.
    format          = jsonencode({        # Required block argument.
      requestId               = "$context.requestId"
      sourceIp                = "$context.identity.sourceIp"
      requestTime             = "$context.requestTime"
      protocol                = "$context.protocol"
      httpMethod              = "GET"
      resourcePath            = "/"
      routeKey                = "$context.routeKey"
      status                  = "$context.status"
      responseLength          = "$context.responseLength"
      integrationErrorMessage = "$context.integrationErrorMessage"
      }
    )
  }
*/
}

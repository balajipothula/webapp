# Resource  type : aws_lambda_permission
# Resource  name : generic
# Attribute name : action
# Argument       : var.action
# Variable  name : action
resource "aws_lambda_permission" "generic" {

  action        = var.action        # Required argument.
  function_name = var.function_name # Required argument.
  principal     = var.principal     # Required argument.
  statement_id  = var.statement_id  # Optional argument.
  source_arn    = var.source_arn    # Optional argument.

}

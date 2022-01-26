# Resource  type : aws_lambda_permission
# Resource  name : generic
# Attribute name : action
# Argument       : var.action
# Variable  name : action
resource "aws_lambda_permission" "generic" {

  action        = var.action        # Required block argument.
  function_name = var.function_name # Required block argument.
  principal     = var.principal     # Required block argument.
  statement_id  = var.statement_id  # Optional argument.
  source_arn    = var.source_arn    # Optional argument.

}

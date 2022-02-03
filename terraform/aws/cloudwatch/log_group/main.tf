# Resource  type : aws_cloudwatch_log_group
# Resource  name : generic
# Attribute name : name
# Argument       : var.name
# Variable  name : name
resource "aws_cloudwatch_log_group" "generic" {

  name              = var.name              # Optional argument but keep it.
//name_prefix       = var.name_prefix       # Optional argument, conflicts with name
  retention_in_days = var.retention_in_days # Optional argument but keep it.
//kms_key_id        = var.kms_key_id        # Optional argument but keep it.
  tags              = var.tags              # Optional argument but keep it.

}

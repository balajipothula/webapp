# Resource type : aws_secretsmanager_secret
# Resource name : generic
# Argument name : name
# Variable name : name
resource "aws_secretsmanager_secret" "generic" {

  description                    = var.description                    # Optional argument, but keep it.
  force_overwrite_replica_secret = var.force_overwrite_replica_secret # Optional argument, but keep it.
//kms_key_id                     = var.kms_key_id                     # Optional argument, but keep it.
  name                           = var.name                           # Optional argument, conflicts with name_prefix.
//name_prefix                    = var.name_prefix                    # Optional argument, conflicts with name.
  recovery_window_in_days        = var.recovery_window_in_days        # Optional argument, but keep it.
  tags                           = var.tags                           # Optional argument, but keep it.

}

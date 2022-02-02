# Resource type : aws_secretsmanager_secret_rotation
# Resource name : generic
# Argument name : secret_id
# Variable name : secret_id
resource "aws_secretsmanager_secret_rotation" "generic" {

  secret_id           = var.secret_id                       # Required argument.
  rotation_lambda_arn = var.rotation_lambda_arn             # Required argument.
  rotation_rules {                                          # Required argument block.
    automatically_after_days = var.automatically_after_days # Required block argument.
  }

}

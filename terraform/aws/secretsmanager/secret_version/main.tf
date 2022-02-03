# Resource type : aws_secretsmanager_secret_version
# Resource name : generic
# Argument name : secret_id
# Variable name : secret_id
resource "aws_secretsmanager_secret_version" "generic" {

  secret_id     = var.secret_id                 # Required argument.
  secret_string = var.secret_string # Optional argument, but required if secret_binary is not set.

}

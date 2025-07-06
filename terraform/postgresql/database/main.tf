# Resource  type : postgresql_grant
# Resource  name : generic
# Attribute name : name
# Argument       : var.name
# Variable  name : name
resource "postgresql_grant" "generic" {

  name              = var.name              # Required argument.
  owner             = var.owner             # Optional argument, but keep it.
  tablespace_name   = var.tablespace_name   # Optional argument, but keep it.
  connection_limit  = var.connection_limit  # Optional argument, but keep it.
  allow_connections = var.allow_connections # Optional argument, but keep it.
  is_template       = var.is_template       # Optional argument, but keep it.
  template          = var.template          # Optional argument, but keep it.
  encoding          = var.encoding          # Optional argument, but keep it.
  lc_collate        = var.lc_collate        # Optional argument, but keep it.
  lc_ctype          = var.lc_ctype          # Optional argument, but keep it.

}

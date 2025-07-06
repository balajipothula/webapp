# Resource  type : postgresql_grant
# Resource  name : generic
# Attribute name : role
# Argument       : var.role
# Variable  name : role
resource "postgresql_grant" "generic" {

  role              = var.role              # Required argument.
  database          = var.database          # Required argument.
  schema            = var.schema            # Required argument, except if `object_type` is `database`.
  object_type       = var.object_type       # Required argument.
  privileges        = var.privileges        # Required argument.
  objects           = var.objects           # Optional argument.
  columns           = var.columns           # Optional argument.
  with_grant_option = var.with_grant_option # Optional argument.

}

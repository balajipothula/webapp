# Resource  type : aws_efs_mount_target
# Resource  name : generic
# Attribute name : file_system_id
# Argument       : var.file_system_id
# Variable  name : file_system_id
resource "aws_efs_mount_target" "generic" {

  file_system_id  = var.file_system_id  # Required argument.
  subnet_id       = var.subnet_id       # Required argument.
//ip_address      = var.ip_address      # Optional argument, but keep it.
  security_groups = var.security_groups # Optional argument, but keep it.

}

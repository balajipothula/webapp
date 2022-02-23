# Resource  type : aws_instance
# Resource  name : generic
# Attribute name : function_name
# Argument       : var.function_name
# Variable  name : function_name
resource "aws_instance" "generic" {

  associate_public_ip_address = var.associate_public_ip_address # Optional argument, but keep it.
  availability_zone           = var.availability_zone           # Optional argument, but keep it.
  ami                         = var.ami                         # Optional argument, but keep it.
  instance_type               = var.instance_type               # Optional argument, but keep it.
  subnet_id                   = var.subnet_id                   # Optional argument, but keep it.
  tags                        = var.tags                        # Optional argument, but keep it.

}

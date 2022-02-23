# Resource  type : aws_instance
# Resource  name : generic
# Attribute name : function_name
# Argument       : var.function_name
# Variable  name : function_name
resource "aws_instance" "generic" {

  ami           = var.ami            # Optional argument, but keep it.
  instance_type = var.instance_type  # Optional argument, but keep it.
  subnet_id     = var.subnet_id      # Optional argument, but keep it.

}

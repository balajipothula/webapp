# Resource  type : aws_instance
# Resource  name : generic
# Attribute name : function_name
# Argument       : var.function_name
# Variable  name : function_name
resource "aws_instance" "generic" {

  ami                  = var.ami                    # Optional argument, but keep it.

}
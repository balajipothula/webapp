# Resource  type : aws_instance
# Resource  name : generic
# Attribute name : function_name
# Argument       : var.function_name
# Variable  name : function_name
resource "aws_instance" "generic" {

  ami                                  = var.ami                                  # Optional argument, but keep it.
  associate_public_ip_address          = var.associate_public_ip_address          # Optional argument, but keep it.
  availability_zone                    = var.availability_zone                    # Optional argument, but keep it.
  disable_api_termination              = var.disable_api_termination              # Optional argument, but keep it.
//ebs_optimized                        = var.ebs_optimized                        # Optional argument, but keep it.

  ebs_block_device {
    delete_on_termination              = var.delete_on_termination
    device_name                        = var.device_name
    encrypted                          = var.encrypted
    volume_size                        = var.volume_size
    volume_type                        = var.volume_type
  }

  hibernation                          = var.hibernation                          # Optional argument, but keep it.
  instance_initiated_shutdown_behavior = var.instance_initiated_shutdown_behavior # Optional argument, but keep it.
  instance_type                        = var.instance_type                        # Optional argument, but keep it.
//ipv6_address_count                   = var.ipv6_address_count                   # Optional argument, but keep it.
  monitoring                           = var.monitoring                           # Optional argument, but keep it.
  security_groups                      = var.security_groups                      # Optional argument, but keep it.
//subnet_id                            = var.subnet_id                            # Optional argument, but keep it.
  tags                                 = var.tags                                 # Optional argument, but keep it.

}

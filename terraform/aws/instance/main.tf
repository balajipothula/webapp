# Resource  type : aws_instance
# Resource  name : generic
# Attribute name : function_name
# Argument       : var.function_name
# Variable  name : function_name
resource "aws_instance" "generic" {

  lifecycle {
    create_before_destroy = true
  //prevent_destroy       = true
    ignore_changes        = [
      credit_specification,
      disable_api_termination,
      ebs_optimized,
      ebs_block_device,
      ephemeral_block_device,
      hibernation,
      network_interface,
      security_groups,
      vpc_security_group_ids,
    ]
  }

  ami                                  = var.ami                                  # Optional argument, but keep it.
  associate_public_ip_address          = var.associate_public_ip_address          # Optional argument, but keep it.
//availability_zone                    = var.availability_zone                    # Optional argument, but keep it.
//disable_api_termination              = var.disable_api_termination              # Optional argument, but keep it.
//ebs_optimized                        = var.ebs_optimized                        # Optional argument, but keep it.
/*
  dynamic "ebs_block_device" {                                                    # Optional block, but keep it.
    for_each                           = var.ebs_block_device
    content {
      delete_on_termination            = null                                     # Optional block argument, but keep it.
      device_name                      = null                                     # Optional block argument, but keep it.
      encrypted                        = null                                     # Optional block argument, but keep it.
      volume_size                      = null                                     # Optional block argument, but keep it.
      volume_type                      = null                                     # Optional block argument, but keep it.
    }
  }
*/
//hibernation                          = var.hibernation                          # Optional argument, but keep it.
  instance_initiated_shutdown_behavior = var.instance_initiated_shutdown_behavior # Optional argument, but keep it.
  instance_type                        = var.instance_type                        # Optional argument, but keep it.
//ipv6_address_count                   = var.ipv6_address_count                   # Optional argument, but keep it.
  key_name                             = var.key_name                             # Optional argument, but keep it.
  monitoring                           = var.monitoring                           # Optional argument, but keep it.

  dynamic "root_block_device" {                                                   # Optional block, but keep it.
    for_each                           = var.root_block_device
    content {
      delete_on_termination            = null                                     # Optional block argument, but keep it.
      encrypted                        = null                                     # Optional block argument, but keep it.
      volume_size                      = null                                     # Optional block argument, but keep it.
      volume_type                      = null                                     # Optional block argument, but keep it.
    }
  }

//security_groups                      = var.security_groups                      # Optional argument, but keep it.
//subnet_id                            = var.subnet_id                            # Optional argument, but keep it.
  tags                                 = var.tags                                 # Optional argument, but keep it.
//tenancy                              = var.tenancy                              # Optional argument, but keep it.
  user_data                            = var.user_data                            # Optional argument, but keep it.
  vpc_security_group_ids               = var.vpc_security_group_ids               # Optional argument, but keep it.

}

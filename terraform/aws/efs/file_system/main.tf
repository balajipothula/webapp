# Resource  type : aws_efs_file_system
# Resource  name : generic
# Attribute name : availability_zone_name
# Argument       : var.availability_zone_name
# Variable  name : availability_zone_name
resource "aws_efs_file_system" "generic" {

//availability_zone_name                = var.availability_zone_name              # Optional argument, but comment it for Region wise spread of EFS.
  creation_token                        = var.creation_token                      # Optional argument, but keep it.
  encrypted                             = var.encrypted                           # Optional argument, but keep it.
//kms_key_id                            = var.kms_key_id                          # Optional argument, but required if encrypted set true.
/*
  lifecycle_policy {                                                              # Optional block, but keep it.
    transition_to_ia                    = var.transition_to_ia                    # Optional block argument, but keep it.
    transition_to_primary_storage_class = var.transition_to_primary_storage_class # Optional block argument, but keep it.
  }
*/
  performance_mode                      = var.performance_mode                    # Optional argument, but keep it.
//provisioned_throughput_in_mibps       = var.provisioned_throughput_in_mibps     # Optional argument, but only applicable with throughput_mode set to provisioned.
  tags                                  = var.tags                                # Optional argument, but keep it.
//throughput_mode                       = var.throughput_mode                     # Optional argument, if value is provisioned, it will impact provisioned_throughput_in_mibps.

}

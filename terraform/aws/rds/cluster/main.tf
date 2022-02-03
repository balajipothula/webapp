# Data Source: aws_region
data "aws_region" "current" {
}

# Data Source: aws_availability_zones
data "aws_availability_zones" "available" {
  all_availability_zones = true
  state                  = "available"

  filter {
    name   = "zone-type"
    values = ["availability-zone"]
  }

}

# Data Source: aws_vpc
data "aws_vpc" "default" {
}

# Data Source: aws_subnet_ids
data "aws_subnet_ids" "available" {
  vpc_id = data.aws_vpc.default.id
}

# Data Source: aws_security_groups
data "aws_security_groups" "default" {
  filter {
    name   = "group-name"
    values = ["default"]
  }
  filter {
    name   = "description"
    values = ["default VPC security group"]
  }
}

locals {
  datetime = formatdate("YYYY-MM-DD-hh-mm-ss", timestamp())
}

# Resource  type : aws_rds_cluster
# Resource  name : generic
# Attribute name : allow_major_version_upgrade
# Argument       : var.allow_major_version_upgrade
# Variable  name : allow_major_version_upgrade
resource "aws_rds_cluster" "generic" {

  lifecycle {
    ignore_changes = [
      availability_zones,
      engine_version,
      master_password,
      master_username,
      port,
      preferred_backup_window,
      preferred_maintenance_window,
      scaling_configuration,
    ]
  }

  allow_major_version_upgrade         = var.allow_major_version_upgrade                          # Optional argument but keep it.
  apply_immediately                   = var.apply_immediately                                    # Optional argument but keep it.
//availability_zones                  = var.availability_zones                                   # Optional argument, Risk => Recreates cluster.
//availability_zones                  = data.aws_availability_zones.available.names              # Optional argument, Risk => Recreates cluster.
//backtrack_window                    = var.backtrack_window                                     # Optional argument.
  backup_retention_period             = var.backup_retention_period                              # Optional argument but keep it.
//cluster_identifier_prefix           = var.cluster_identifier_prefix                            # Optional argument.
  cluster_identifier                  = var.cluster_identifier                                   # Optional argument but keep it.
  copy_tags_to_snapshot               = var.copy_tags_to_snapshot                                # Optional argument but keep it.
  database_name                       = var.database_name                                        # Optional argument but keep it.
//db_cluster_parameter_group_name     = var.db_cluster_parameter_group_name                      # Optional argument.
//db_subnet_group_name                = var.db_subnet_group_name                                 # Optional argument.
  deletion_protection                 = var.deletion_protection                                  # Optional argument but keep.
  enable_http_endpoint                = var.enable_http_endpoint                                 # Optional argument but keep it.
//enabled_cloudwatch_logs_exports     = var.enabled_cloudwatch_logs_exports                      # Optional argument but if enables getting error.
  engine                              = var.engine                                               # Optional argument but keep it.
  engine_mode                         = var.engine_mode                                          # Optional argument but keep it.
  engine_version                      = var.engine_version                                       # Optional argument but keep it.
  final_snapshot_identifier           = "${var.final_snapshot_identifier}-${local.datetime}"     # Optional argument but keep it.
//global_cluster_identifier           = var.global_cluster_identifier                            # Optional argument.
//iam_database_authentication_enabled = var.iam_database_authentication_enabled                  # Optional argument.
//iam_roles                           = var.iam_roles                                            # Optional argument.
//kms_key_id                          = var.kms_key_id                                           # Optional argument.
  master_password                     = var.master_password                                      # Required argument.
  master_username                     = var.master_username                                      # Required argument.
  port                                = var.port                                                 # Optional argument but keep it.
  preferred_backup_window             = var.preferred_backup_window                              # Optional argument but keep it.
  preferred_maintenance_window        = var.preferred_maintenance_window                         # Optional argument but keep it.
//replication_source_identifier       = var.replication_source_identifier                        # Optional argument.

/*
  restore_to_point_in_time {                                                                     # Optional argument block.
    source_cluster_identifier         = var.source_cluster_identifier                            # Required block argument.
    restore_type                      = var.restore_type                                         # Optional block argument.
    use_latest_restorable_time        = var.use_latest_restorable_time                           # Optional block argument, Conflicts with restore_to_time argument.
  //restore_to_time                   = var.restore_to_time                                      # Optional block argument, Conflicts with use_latest_restorable_time argument.
  }
*/

//Configuration is only valid when engine_mode is set to serverless.
  scaling_configuration {                                                                        # Optional argument block but keep it.
    auto_pause                        = var.auto_pause                                           # Optional block argument.
    max_capacity                      = var.max_capacity                                         # Optional block argument.
    min_capacity                      = var.min_capacity                                         # Optional block argument.
    seconds_until_auto_pause          = var.seconds_until_auto_pause                             # Optional block argument.
    timeout_action                    = var.timeout_action                                       # Optional block argument.
  }

//RDS Aurora Serverless does not support loading data from S3.
/*
  s3_import {                                                                                    # Optional argument block.
    bucket_name                       = var.bucket_name                                          # Required block argument.
    bucket_prefix                     = var.bucket_prefix                                        # Optional block argument.
    ingestion_role                    = var.ingestion_role                                       # Required block argument.
    source_engine                     = var.source_engine                                        # Required block argument.
    source_engine_version             = var.source_engine_version                                # Required block argument.
  }  
*/

  skip_final_snapshot                 = var.skip_final_snapshot                                  # Optional argument but keep it.
//snapshot_identifier                 = var.snapshot_identifier                                  # Optional argument.
//source_region                       = var.source_region                                        # Optional argument.
  storage_encrypted                   = var.storage_encrypted                                    # Optional argument but keep it.
  tags                                = var.tags                                                 # Optional argument but keep it.
//vpc_security_group_ids              = data.aws_security_groups.default.ids                     # Optional argument.

}

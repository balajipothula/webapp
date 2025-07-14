# Data Source: aws_vpc
data "aws_vpc" "default" {
  default = true
}

# Data Source: aws_availability_zones
# slice(data.aws_availability_zones.available.names, 0, 3)
data "aws_availability_zones" "available" {
  all_availability_zones = true
  state                  = "available"

  filter {
    name   = "zone-type"
    values = ["availability-zone"]
  }

}

# Data Source: aws_subnets
# Fetch subnet IDs in default VPC
data "aws_subnets" "available" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# Data Source: aws_security_groups
# data.aws_security_groups.default.id
data "aws_security_groups" "default" {
  filter {
    name   = "group-name"
    values = ["default"]
  }
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# Resource type : aws_rds_cluster_instance
# Resource name : generic
# Argument name : identifier
# Variable name : identifier
resource "aws_rds_cluster" "generic" {

  # 🧠 Ignore some changes for AWS RDS Cluster.
  lifecycle {
    ignore_changes = [
      availability_zones,
      engine_version,
      master_password,
      master_username,
      port,
      preferred_backup_window,
      preferred_maintenance_window,
      replication_source_identifier,
    ]
  }

  allocated_storage                   = var.allocated_storage                                     # ✅ Optional argument — 🔒 Required for Multi-AZ DB cluster.
  allow_major_version_upgrade         = var.allow_major_version_upgrade                           # ✅ Optional argument — 🧩 inter-related with `db_instance_parameter_group_name`.
  apply_immediately                   = var.apply_immediately                                     # ✅ Optional argument — recommended to keep.
  availability_zones                  = slice(data.aws_availability_zones.available.names, 0, 3)  # ✅ Optional argument — recommended to keep.
  backtrack_window                    = var.backtrack_window                                      # ✅ Optional argument — recommended to keep.
  backup_retention_period             = var.backup_retention_period                               # ✅ Optional argument — recommended to keep.
  cluster_identifier                  = var.cluster_identifier                                    # ✅ Optional argument, ❗ Forces new resource — 🤜💥🤛 Conflicts with `cluster_identifier_prefix`.
  cluster_identifier_prefix           = var.cluster_identifier_prefix                             # ✅ Optional argument, ❗ Forces new resource — 🤜💥🤛 Conflicts with `cluster_identifier`.
  copy_tags_to_snapshot               = var.copy_tags_to_snapshot                                 # ✅ Optional argument — recommended to keep.
  database_name                       = var.database_name                                         # ✅ Optional argument — 🚨 highly recommended to keep.
  db_cluster_instance_class           = var.db_cluster_instance_class                             # ✅ Optional argument — 🔒 Required for Multi-AZ DB cluster.
  db_cluster_parameter_group_name     = var.db_cluster_parameter_group_name                       # ✅ Optional argument.
  db_instance_parameter_group_name    = var.db_instance_parameter_group_name                      # ✅ Optional argument — 🧩 inter-related with `allow_major_version_upgrade`.
  db_subnet_group_name                = var.db_subnet_group_name                                  # ✅ Optional argument — 🚨 highly recommended to keep, ❗ must match with `aws_rds_cluster_instance` resource `db_subnet_group_name` variable.
  db_system_id                        = var.db_system_id                                          # ✅ Optional argument.
  delete_automated_backups            = var.delete_automated_backups                              # ✅ Optional argument — recommended to keep.
  deletion_protection                 = var.deletion_protection                                   # ✅ Optional argument — 🚨 highly recommended to keep.
  enable_global_write_forwarding      = var.enable_global_write_forwarding                        # ✅ Optional argument — 🚨 highly recommended to keep.
  enable_http_endpoint                = var.enable_http_endpoint                                  # ✅ Optional argument — 🚨 `engine_mode` must be 'serverless'.
  enabled_cloudwatch_logs_exports     = var.enabled_cloudwatch_logs_exports                       # ✅ Optional argument.
  engine                              = var.engine                                                # 🔒 Required argument.
  engine_mode                         = var.engine_mode                                           # ✅ Optional argument — 🚨 highly recommended to keep.
  engine_version                      = var.engine_version                                        # ✅ Optional argument.
  final_snapshot_identifier           = var.final_snapshot_identifier                             # ✅ Optional argument — recommended to keep.
  global_cluster_identifier           = var.global_cluster_identifier                             # ✅ Optional argument.
  iam_database_authentication_enabled = var.iam_database_authentication_enabled                   # ✅ Optional argument.
  iam_roles                           = var.iam_roles                                             # ✅ Optional argument.
  iops                                = var.iops                                                  # ✅ Optional argument — 🧩 inter-related with `availability_zones`.
  kms_key_id                          = var.kms_key_id                                            # ✅ Optional argument — 🚨 `storage_encrypted` must be 'true'.
  manage_master_user_password         = var.manage_master_user_password                           # ✅ Optional argument — 🚨 `master_password` must be 'null'.
  master_password                     = var.master_password                                       # 🔒 Required argument — 🚨 `manage_master_user_password` must be 'false'.
  master_user_secret_kms_key_id       = var.master_user_secret_kms_key_id                         # ✅ Optional argument.
  master_username                     = var.master_username                                       # 🔒 Required argument.
  network_type                        = var.network_type                                          # ✅ Optional argument — recommended to keep.
  port                                = var.port                                                  # ✅ Optional argument — 🚨 highly recommended to keep.
  preferred_backup_window             = var.preferred_backup_window                               # ✅ Optional argument — recommended to keep.
  preferred_maintenance_window        = var.preferred_maintenance_window                          # ✅ Optional argument — recommended to keep.
  replication_source_identifier       = var.replication_source_identifier                         # ✅ Optional argument.
  dynamic "restore_to_point_in_time" {                                                            # ✅ Optional argument.
    for_each = var.restore_to_point_in_time != null ? [var.restore_to_point_in_time] : []
    content {
      source_cluster_identifier       = restore_to_point_in_time.value.source_cluster_identifier  # 🔒 Required argument.
      restore_type                    = restore_to_point_in_time.value.restore_type               # ✅ Optional argument.
      use_latest_restorable_time      = restore_to_point_in_time.value.use_latest_restorable_time # ✅ Optional argument — 🤜💥🤛 Conflicts with `restore_to_time`.
      restore_to_time                 = restore_to_point_in_time.value.restore_to_time            # ✅ Optional argument — 🤜💥🤛 Conflicts with `use_latest_restorable_time`.
    }
  }
  dynamic "scaling_configuration" {                                                               # ✅ Optional argument — 🚨 `engine_mode` must be 'serverless'.
    for_each = var.scaling_configuration != null ? [var.scaling_configuration] : []
    content {
      auto_pause                      = scaling_configuration.value.auto_pause                    # ✅ Optional argument.
      max_capacity                    = scaling_configuration.value.max_capacity                  # ✅ Optional argument.
      min_capacity                    = scaling_configuration.value.min_capacity                  # ✅ Optional argument.
      seconds_until_auto_pause        = scaling_configuration.value.seconds_until_auto_pause      # ✅ Optional argument.
      timeout_action                  = scaling_configuration.value.timeout_action                # ✅ Optional argument.
    }
  }
  dynamic "serverlessv2_scaling_configuration" {                                                  # ✅ Optional argument — 🚨 `engine_mode` must be 'provisioned'.
    for_each = var.serverlessv2_scaling_configuration != null ? [var.serverlessv2_scaling_configuration] : []
    content {
      max_capacity                    = serverlessv2_scaling_configuration.value.max_capacity     # 🔒 Required argument.
      min_capacity                    = serverlessv2_scaling_configuration.value.min_capacity     # 🔒 Required argument.
    }
  }
  skip_final_snapshot                 = var.skip_final_snapshot                                   # ✅ Optional argument — recommended to keep.
  snapshot_identifier                 = var.snapshot_identifier                                   # ✅ Optional argument — 🤜💥🤛 Conflicts with `global_cluster_identifier`.
  source_region                       = var.source_region                                         # ✅ Optional argument.
  storage_encrypted                   = var.storage_encrypted                                     # ✅ Optional argument.
  storage_type                        = var.storage_type                                          # ✅ Optional argument — 🔒 Required for Multi-AZ DB cluster.
  tags                                = var.tags                                                  # ✅ Optional argument — recommended to keep.
  vpc_security_group_ids              = [data.aws_security_groups.default.id]                     # ✅ Optional argument — 🚨 highly recommended to keep.

}

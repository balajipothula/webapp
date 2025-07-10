# Resource type : aws_rds_cluster_instance
# Resource name : generic
# Argument name : identifier
# Variable name : identifier

resource "aws_rds_cluster_instance" "generic" {

  apply_immediately                     = var.apply_immediately                     # ✅ Optional argument.
  auto_minor_version_upgrade            = var.auto_minor_version_upgrade            # ✅ Optional argument.
  availability_zone                     = var.availability_zone                     # ✅ Optional argument, ❗ Forces new resource.
  ca_cert_identifier                    = var.ca_cert_identifier                    # ✅ Optional argument.
  cluster_identifier                    = var.cluster_identifier                    # 🔒 Required argument, ❗ Forces new resource.
  copy_tags_to_snapshot                 = var.copy_tags_to_snapshot                 # ✅ Optional argument.
  custom_iam_instance_profile           = var.custom_iam_instance_profile           # ✅ Optional argument.
  db_parameter_group_name               = var.db_parameter_group_name               # ✅ Optional argument.
  db_subnet_group_name                  = var.db_subnet_group_name                  # 🔒 Required argument, if `publicly_accessible = false`, Optional otherwise, ❗ Forces new resource.
  engine_version                        = var.engine_version                        # ✅ Optional argument — recommended to keep.
  engine                                = var.engine                                # 🔒 Required argument, ❗ Forces new resource.
  identifier_prefix                     = var.identifier_prefix                     # ✅ Optional argument, ❗ Forces new resource — 🤜💥🤛 Conflicts with `identifier`.
  identifier                            = var.identifier                            # ✅ Optional argument, ❗ Forces new resource.
  instance_class                        = var.instance_class                        # 🔒 Required argument.
  monitoring_interval                   = var.monitoring_interval                   # ✅ Optional argument — recommended to keep.
  monitoring_role_arn                   = var.monitoring_role_arn                   # ✅ Optional argument.
  performance_insights_enabled          = var.performance_insights_enabled          # ✅ Optional argument.
  performance_insights_kms_key_id       = var.performance_insights_kms_key_id       # 🔒 Required argument, if `performance_insights_enabled = true`, Optional otherwise.
  performance_insights_retention_period = var.performance_insights_retention_period # 🔒 Required argument, if `performance_insights_enabled = true`, Optional otherwise.
  preferred_backup_window               = var.preferred_backup_window               # ✅ Optional argument, if it set at the cluster level, this must be `null`.
  preferred_maintenance_window          = var.preferred_maintenance_window          # ✅ Optional argument — recommended to keep.
  promotion_tier                        = var.promotion_tier                        # ✅ Optional argument.
  publicly_accessible                   = var.publicly_accessible                   # ✅ Optional argument — recommended to keep.
  tags                                  = var.tags                                  # ✅ Optional argument — recommended to keep.

}

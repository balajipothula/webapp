variable "apply_immediately" {
  type        = bool
  default     = false
  description = "Specifies whether any database modifications are applied immediately, or during the next maintenance window."
  validation {
    condition     = var.apply_immediately != null && contains([true, false], var.apply_immediately)
    error_message = "Error: apply_immediately must be either true or false."
  }
  sensitive = false
}

variable "auto_minor_version_upgrade" {
  type        = bool
  default     = true
  description = "Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window."
  validation {
    condition     = var.auto_minor_version_upgrade != null && contains([true, false], var.auto_minor_version_upgrade)
    error_message = "Error: auto_minor_version_upgrade must be either true or false."
  }
  sensitive = false
}

variable "availability_zone" {
  type        = string
  default     = null
  description = "EC2 Availability Zone that the DB instance is created in."
  sensitive   = false
}

variable "ca_cert_identifier" {
  type        = string
  default     = null
  description = "Identifier of the CA certificate for the DB instance."
  sensitive   = false
}

variable "cluster_identifier" {
  type        = string
  description = "Identifier of the `aws_rds_cluster` in which to launch this instance."
  validation {
    condition     = 0 < length(var.cluster_identifier)
    error_message = "Error: cluster_identifier must not be empty."
  }
  sensitive = false
}

variable "copy_tags_to_snapshot" {
  type        = bool
  default     = false
  description = "Indicates whether to copy all of the user-defined tags from the DB instance to snapshots of the DB instance."
  validation {
    condition     = var.copy_tags_to_snapshot != null && contains([true, false], var.copy_tags_to_snapshot)
    error_message = "Error: copy_tags_to_snapshot must be either true or false."
  }
  sensitive = false
}

variable "custom_iam_instance_profile" {
  type        = string
  default     = null
  description = "Instance profile associated with the underlying Amazon EC2 instance of an RDS Custom DB instance."
  sensitive   = false
}

variable "db_parameter_group_name" {
  type        = string
  default     = null
  description = "Name of the DB parameter group to associate with this instance."
  sensitive   = false
}

# NOTE: This must match the `db_subnet_group_name` of the attached `aws_rds_cluster`.
variable "db_subnet_group_name" {
  type        = string
  default     = null
  description = "DB subnet group to associate with this DB instance."
  sensitive   = false
}

variable "engine_version" {
  type        = string
  default     = null
  description = "Database engine version."
  sensitive   = false
}

variable "engine" {
  type        = string
  description = "Name of the database engine to be used for the RDS cluster instance."
  validation {
    condition     = contains(["aurora-mysql", "aurora-postgresql"], var.engine)
    error_message = "Error: engine must be either 'aurora-mysql' or 'aurora-postgresql'."
  }
  sensitive = false
}

variable "identifier_prefix" {
  type        = string
  default     = null
  description = "Creates a unique identifier beginning with the specified prefix."
  sensitive   = false
}

variable "identifier" {
  type        = string
  default     = "rds-cluster-instance"
  description = "Identifier for the RDS instance."
  validation {
    condition     = 0 < length(var.identifier) && can(regex("^[a-z][a-z0-9-]*$", var.identifier))
    error_message = "Error: identifier must not empyth, must contain only lowercase letters, numbers, and hyphens (a-z, 0-9, -)."
  }
  sensitive = false
}

variable "instance_class" {
  type        = string
  default     = "db.serverless"
  description = "Instance class to use."
  validation {
    condition     = 0 < length(var.instance_class)
    error_message = "Error: instance_class must not be empty."
  }
  sensitive = false
}

variable "monitoring_interval" {
  type        = number
  default     = 0
  description = "Interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance."
  validation {
    condition     = contains([0, 1, 5, 10, 15, 30, 60], var.monitoring_interval)
    error_message = "Error: monitoring_interval must be one of the following values: 0, 1, 5, 10, 15, 30, or 60."
  }
  sensitive = false
}

variable "monitoring_role_arn" {
  type        = string
  default     = null
  description = "ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs."
  sensitive   = false
}

# if `performance_insights_enabled = true` then `performance_insights_kms_key_id` and `performance_insights_retention_period` values must be provided.
variable "performance_insights_enabled" {
  type        = bool
  default     = false
  description = "Specifies whether Performance Insights are enabled."
  validation {
    condition     = contains([true, false], var.performance_insights_enabled)
    error_message = "Error: performance_insights_enabled must be either true or false."
  }
  sensitive = false
}

# if `performance_insights_enabled = true` then `performance_insights_kms_key_id` values must be provided.
variable "performance_insights_kms_key_id" {
  type        = string
  default     = null
  description = "The ARN for the KMS key used to encrypt Performance Insights data."
  sensitive   = false
}

# if `performance_insights_enabled = true` then `performance_insights_retention_period` values must be provided.
variable "performance_insights_retention_period" {
  type        = number
  default     = 0
  description = "Amount of time in days to retain Performance Insights data."
  validation {
    condition     = var.performance_insights_retention_period == null || contains([7, 731], var.performance_insights_retention_period) || (var.performance_insights_retention_period % 31 == 0 && 31 <= var.performance_insights_retention_period && var.performance_insights_retention_period <= 713)
    error_message = "Error: performance_insights_retention_period valid values are null, 7, 731 (2 years) or a multiple of 31."
  }
  sensitive = false
}

variable "preferred_backup_window" {
  type        = string
  default     = null
  description = "Daily time range during which automated backups are created if automated backups are enabled."
  validation {
    condition = (
      var.preferred_backup_window == null ||
      can(regex("^(0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]-(0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]$", var.preferred_backup_window))
    )
    error_message = "Error: preferred_backup_window either null or 'HH:MM-HH:MM' using 24-hour UTC (e.g., '04:00-09:00')."
  }
  sensitive = false
}

variable "preferred_maintenance_window" {
  type        = string
  default     = null
  description = " Window to perform maintenance in."
  validation {
    condition = (
      var.preferred_maintenance_window == null ||
      can(regex("^(Mon|Tue|Wed|Thu|Fri|Sat|Sun):(0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]-(Mon|Tue|Wed|Thu|Fri|Sat|Sun):(0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]$", var.preferred_maintenance_window))
    )
    error_message = "Error: preferred_maintenance_window either null or ddd:hh24:mi-ddd:hh24:mi format (e.g., 'Mon:00:00-Mon:03:00')."
  }
  sensitive = false
}

variable "promotion_tier" {
  type        = number
  default     = 0
  description = "Failover Priority setting on instance level."
  validation {
    condition     = 0 <= var.promotion_tier && var.promotion_tier <= 15
    error_message = "Error: promotion_tier must be between 0 and 15 (inclusive)."
  }
  sensitive = false
}

variable "publicly_accessible" {
  type        = bool
  default     = false
  description = "Bool to control if instance is publicly accessible."
  validation {
    condition     = contains([true, false], var.publicly_accessible)
    error_message = "Error: publicly_accessible must be either true or false."
  }
  sensitive = false
}

variable "tags" {
  type = map(string)
  default = {
    AppName        = "WebAppFastAPI"
    Division       = "Platform"
    DeveloperName  = "Balaji Pothula"
    DeveloperEmail = "balan.pothula@gmail.com"
  }
  description = "Map of tags to assign to the instance."
  validation {
    condition     = 0 < length(var.tags) && length(var.tags) < 51
    error_message = "Error: tags at least one or more expected up to 50."
  }
  sensitive = false
}

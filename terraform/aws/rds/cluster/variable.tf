variable "allocated_storage" {
  type        = number
  default     = null
  description = "The amount of storage in gibibytes (GiB) to allocate to each DB instance in the Multi-AZ DB cluster."
  validation {
    condition     = var.allocated_storage == null || can(100 <= var.allocated_storage && var.allocated_storage <= 65536)
    error_message = "allocated_storage must be null or between 100 and 65536 GiB for Multi-AZ DB clusters."
  }
  sensitive = false
}

variable "allow_major_version_upgrade" {
  type        = bool
  default     = false
  description = "Enable to allow major engine version upgrades when changing engine versions."
  validation {
    condition     = contains([true, false], var.allow_major_version_upgrade)
    error_message = "allow_major_version_upgrade must be true or false."
  }
  sensitive = false
}

variable "apply_immediately" {
  type        = bool
  default     = false
  description = "Specifies whether any cluster modifications are applied immediately, or during the next maintenance window."
  validation {
    condition     = contains([true, false], var.apply_immediately)
    error_message = "apply_immediately must be true or false."
  }
  sensitive = false
}

variable "availability_zones" {
  type        = list(string)
  default     = null
  description = "List of EC2 Availability Zones for the DB cluster storage where DB cluster instances can be created."
  validation {
    condition     = var.availability_zones == null || length(var.availability_zones) <= 3
    error_message = "availability_zones maximum of 3 availability zones can be specified."
  }
  sensitive   = false
}

variable "backtrack_window" {
  type        = number
  default     = 0
  description = "Target backtrack window, in seconds. Only available for aurora and aurora-mysql engines currently."
  validation {
    condition     = var.backtrack_window == 0 || (0 < var.backtrack_window && var.backtrack_window <= 259200)
    error_message = "backtrack_window must be 0 (disabled) or between 1 and 259200 (72 hours)."
  }
  sensitive   = false
}

variable "backup_retention_period" {
  type        = number
  default     = 1
  description = "Days to retain backups for."
  validation {
    condition     = 0 <= var.backup_retention_period && var.backup_retention_period <= 35
    error_message = "backup_retention_period must be between 0 and 35 days."
  }
  sensitive   = false
}

variable "cluster_identifier" {
  type        = string
  default     = null
  description = "The cluster identifier. If omitted, Terraform will assign a random, unique identifier."
  validation {
    condition     = var.cluster_identifier == null || (
                      can(regex("^[a-z][a-z0-9\\-]{0,62}$", var.cluster_identifier)) &&
                      !endswith(var.cluster_identifier, "-") &&
                      !contains(var.cluster_identifier, "--")
                    )
    error_message = "cluster_identifier must start with a lowercase letter, contain only lowercase letters, numbers, and hyphens (no consecutive or trailing hyphens), and be 1–63 characters long."
  }
  sensitive = false
}


variable "cluster_identifier_prefix" {
  type        = string
  default     = null
  description = "Creates a unique cluster identifier beginning with the specified prefix."
  validation {
    condition     = var.cluster_identifier_prefix == null || (
                      can(regex("^[a-z][a-z0-9\\-]{0,62}$", var.cluster_identifier_prefix)) &&
                      !endswith(var.cluster_identifier_prefix, "-") &&
                      !contains(var.cluster_identifier_prefix, "--")
                    )
    error_message = "cluster_identifier_prefix must start with a lowercase letter, contain only lowercase letters, numbers, and hyphens (no consecutive or trailing hyphens), and be 1-63 characters long."
  }
  sensitive = false
}

variable "copy_tags_to_snapshot" {
  type        = bool
  default     = false
  description = "Copy all Cluster tags to snapshots."
  validation {
    condition     = contains([true, false], var.copy_tags_to_snapshot)
    error_message = "copy_tags_to_snapshot must be either true or false."
  }
  sensitive   = false
}

variable "database_name" {
  type        = string
  default     = null
  description = "Name for an automatically created database on cluster creation."
  validation {
    condition     = var.database_name == null || can(regex("^[a-zA-Z][a-zA-Z0-9_]{1,62}$", var.database_name))
    error_message = "database_name must start with a letter and contain only alphanumeric characters or underscores, 2-63 characters long."
  }
  sensitive = true
}

variable "db_cluster_instance_class" {
  type        = string
  default     = null
  description = "The compute and memory capacity of each DB instance in the Multi-AZ DB cluster."
  sensitive   = false
}

variable "db_cluster_parameter_group_name" {
  type        = string
  default     = null
  description = "A cluster parameter group to associate with the cluster."
  sensitive   = false
}

variable "db_instance_parameter_group_name" {
  type        = string
  default     = null
  description = "Instance parameter group to associate with all instances of the DB cluster. Valid only with allow_major_version_upgrade."
  sensitive   = false
}

variable "db_subnet_group_name" {
  type        = string
  default     = null
  description = "DB subnet group to associate with this DB cluster. Must match the value in aws_rds_cluster_instance."
  sensitive   = false
}

variable "db_system_id" {
  type        = string
  default     = null
  description = "For use with RDS Custom."
  sensitive   = false
}

variable "delete_automated_backups" {
  type        = bool
  default     = true
  description = "Specifies whether to remove automated backups immediately after the DB cluster is deleted."
  validation {
    condition     = contains([true, false], var.delete_automated_backups)
    error_message = "delete_automated_backups must be either true or false."
  }
  sensitive = false
}

variable "deletion_protection" {
  type        = bool
  default     = false
  description = "If the DB cluster should have deletion protection enabled."
  validation {
    condition     = contains([true, false], var.deletion_protection)
    error_message = "deletion_protection must be either true or false."
  }

  sensitive = false
}

variable "enable_global_write_forwarding" {
  type        = bool
  default     = false
  description = "Whether cluster should forward writes to an associated global cluster."
  validation {
    condition     = contains([true, false], var.enable_global_write_forwarding)
    error_message = "enable_global_write_forwarding must be either true or false."
  }
  sensitive = false
}

variable "enable_http_endpoint" {
  type        = bool
  default     = false
  description = "Enable HTTP endpoint (data API). Only valid when engine_mode is serverless."
  validation {
    condition     = contains([true, false], var.enable_http_endpoint)
    error_message = "enable_http_endpoint must be either true or false."
  }
  sensitive = false
}

variable "enabled_cloudwatch_logs_exports" {
  type        = list(string)
  default     = []
  description = "Set of log types to export to CloudWatch."
  validation {
    condition     = alltrue([for log in var.enabled_cloudwatch_logs_exports : contains(["audit", "error", "general", "slowquery", "postgresql"], log)])
    error_message = "enabled_cloudwatch_logs_exports log types - audit, error, general, slowquery, postgresql are allowed."
  }
  sensitive = false
}

variable "engine" {
  type        = string
  default     = "aurora-postgresql"
  description = "Name of the database engine to be used for this DB cluster."
  validation {
    condition     = contains(["aurora-mysql", "aurora-postgresql", "mysql", "postgres"], var.engine)
    error_message = "engine must be one of: aurora-mysql, aurora-postgresql, mysql, postgres."
  }
  sensitive = false
}

variable "engine_mode" {
  type        = string
  default     = "provisioned"
  description = "Database engine mode. Valid values: global, parallelquery, provisioned, serverless. Defaults to: provisioned."
  validation {
    condition     = contains(["global", "parallelquery", "provisioned", "serverless"], var.engine_mode)
    error_message = "engine_mode must be one of: global, parallelquery, provisioned, serverless."
  }
  sensitive = false
}

# Note: Updating this argument results in an outage.
variable "engine_version" {
  type        = string
  default     = null
  description = "Database engine version."
  sensitive   = false
}

# Note: If omitted, no final snapshot will be made.
variable "final_snapshot_identifier" {
  type        = string
  default     = null
  description = "Name of your final DB snapshot when this DB cluster is deleted."
  sensitive   = false
}

variable "global_cluster_identifier" {
  type        = string
  default     = null
  description = "Global cluster identifier specified on aws_rds_global_cluster."
  sensitive   = false
}

variable "iam_database_authentication_enabled" {
  type        = bool
  default     = false
  description = "Specifies whether mappings of IAM accounts to database accounts is enabled."
  validation {
    condition     = contains([true, false], var.iam_database_authentication_enabled)
    error_message = "iam_database_authentication_enabled must be true or false."
  }
  sensitive   = false
}

variable "iam_roles" {
  type        = list(string)
  default     = []
  description = "List of ARNs for the IAM roles to associate to the RDS Cluster."
  sensitive   = false
}

variable "iops" {
  type        = number
  default     = null
  description = "Provisioned IOPS to be initially allocated for each DB instance in the Multi-AZ DB cluster."
  validation {
    condition     = var.iops == null || (1000 <= var.iops && var.iops <= 40000)
    error_message = "iops either null or between 1000 and 40000."
  }
  sensitive   = false
}

# Note: When specifying `kms_key_id`, `storage_encrypted` must be true.
variable "kms_key_id" {
  type        = string
  default     = null
  description = "ARN for the KMS encryption key."
  sensitive   = true
}

# Note: Cannot be set if `master_password` is provided.
variable "manage_master_user_password" {
  type        = bool
  default     = false
  description = "Set to true to allow RDS to manage the master user password in Secrets Manager."
  validation {
    condition     = contains([true, false], var.manage_master_user_password)
    error_message = "manage_master_user_password must be either true or false."
  }
  sensitive   = false
}

# Note: Cannot be set if manage_master_user_password is true.
variable "master_password" {
  type        = string
  default     = null
  description = "Password for the master DB user."
  sensitive   = true
}

variable "master_user_secret_kms_key_id" {
  type        = string
  default     = null
  description = "KMS key identifier to encrypt the managed master user password."
  sensitive   = true
}

# Note:  Required unless `snapshot_identifier` or `replication_source_identifier` is set.
variable "master_username" {
  type        = string
  default     = null
  description = "Username for the master DB user."
  sensitive   = false
}

variable "network_type" {
  type        = string
  default     = null
  description = "Network type of the cluster."
  validation {
    condition     = var.network_type == null || contains(["IPV4", "DUAL"], var.network_type)
    error_message = "network_type either null or must be IPV4 or DUAL if specified."
  }
  sensitive   = false
}

variable "port" {
  type        = number
  default     = null
  description = "Port on which the DB accepts connections."
  validation {
    condition     = var.port == null || (var.port >= 1150 && var.port <= 65535)
    error_message = "Port must be between 1150 and 65535 if specified."
  }
  sensitive   = false
}

variable "preferred_backup_window" {
  type        = string
  default     = null
  description = "Daily time range during which automated backups are created."
  validation {
    condition     = var.preferred_backup_window == null || can(regex("^([01]\\d|2[0-3]):[0-5]\\d-([01]\\d|2[0-3]):[0-5]\\d$", var.preferred_backup_window))
    error_message = "preferred_backup_window must be in the format HH:mm-HH:mm (UTC)."
  }
  sensitive   = false
}

variable "preferred_maintenance_window" {
  type        = string
  default     = null
  description = "Weekly time range during which system maintenance can occur, in (UTC)"
  validation {
    condition     = var.preferred_maintenance_window == null || can(regex("^(mon|tue|wed|thu|fri|sat|sun):[0-2]\\d:[0-5]\\d-(mon|tue|wed|thu|fri|sat|sun):[0-2]\\d:[0-5]\\d$", var.preferred_maintenance_window))
    error_message = "preferred_maintenance_window must be in the format ddd:HH:mm-ddd:HH:mm (UTC)."
  }
  sensitive   = false
}

variable "replication_source_identifier" {
  type        = string
  default     = null
  description = "ARN of the source DB cluster or DB instance if this DB cluster is to be created as a Read Replica."
  sensitive   = false
}

variable "restore_to_point_in_time" {
  type = object({
    source_cluster_identifier  = string
    restore_type               = optional(string)
    use_latest_restorable_time = optional(bool)
    restore_to_time            = optional(string)
  })
  default     = null
  description = "Nested attribute for point in time restore. If provided, source_cluster_identifier is required."
  sensitive   = false
}

#  Only valid when `engine_mode` is set to serverless.
variable "scaling_configuration" {
  type = object({
    auto_pause               = optional(bool)
    max_capacity             = optional(number)
    min_capacity             = optional(number)
    seconds_until_auto_pause = optional(number)
    timeout_action           = optional(string)
  })
  default     = null
  description = "Nested attribute with scaling properties."
  sensitive   = false
}

#  Only valid when engine_mode is set to provisioned.
variable "serverlessv2_scaling_configuration" {
  type = object({
    max_capacity = number
    min_capacity = number
  })
  default     = null
  description = "Nested attribute with scaling properties for ServerlessV2."
  validation {
    condition     = var.serverlessv2_scaling_configuration == null || (var.serverlessv2_scaling_configuration.min_capacity <= var.serverlessv2_scaling_configuration.max_capacity)
    error_message = "max_capacity must be greater than or equal to min_capacity in serverlessv2_scaling_configuration."
  }
  sensitive   = false
}

variable "skip_final_snapshot" {
  type        = bool
  default     = true
  description = "Determines whether a final DB snapshot is created before the DB cluster is deleted."
  validation {
    condition     = contains([true, false], var.skip_final_snapshot)
    error_message = "skip_final_snapshot must be either true or false."
  }
  sensitive   = false
}

# Note: Conflicts with global_cluster_identifier.
variable "snapshot_identifier" {
  type        = string
  default     = null
  description = "Specifies whether or not to create this cluster from a snapshot."
  sensitive   = false
}

variable "source_region" {
  type        = string
  default     = null
  description = "The source region for an encrypted replica DB cluster."
  sensitive   = false
}

variable "storage_encrypted" {
  type        = bool
  default     = null
  description = "Specifies whether the DB cluster is encrypted."
  validation {
    condition     = var.storage_encrypted == null || contains([true, false], var.storage_encrypted)
    error_message = "storage_encrypted must be true or false."
  }
  sensitive   = false
}

# Note: Required for Multi-AZ DB cluster.
variable "storage_type" {
  type        = string
  default     = null
  description = "Specifies the storage type to be associated with the DB cluster."
  validation {
    condition     = var.storage_type == null || contains(["", "aurora-iopt1", "io1"], var.storage_type)
    error_message = "storage_type must be one of: '', 'aurora-iopt1', 'io1'."
  }
  sensitive   = false
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to assign to the DB cluster."
  sensitive   = false
}

variable "vpc_security_group_ids" {
  type        = list(string)
  default     = []
  description = "List of VPC security groups to associate with the Cluster."
  sensitive   = false
}

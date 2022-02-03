variable "allow_major_version_upgrade" {
  type        = bool
  default     = true
  description = "Determines whether major engine upgrades are allowed when changing engine version."
  validation {
    condition     = contains(toset([true, false]), var.allow_major_version_upgrade)
    error_message = "Error: allow_major_version_upgrade value must be either true or false only."
  }
  sensitive   = false
}

variable "apply_immediately" {
  type        = bool
  default     = false
  description = "Determines whether or not any DB modifications are applied immediately, or during the maintenance window."
  validation {
    condition     = contains(toset([true, false]), var.apply_immediately)
    error_message = "Error: apply_immediately value must be either true or false only."
  }
  sensitive   = false
}

variable "availability_zones" {
  type        = set(string)
  default     = [
    "eu-central-1a",
    "eu-central-1b",
    "eu-central-1c",
  ]
  description = "A list of Availability Zones for the DB cluster storage where DB cluster instances can be created."
  sensitive   = false
}

variable "backtrack_window" {
  type        = number
  default     = 0
  description = "The target backtrack window, in seconds. Only available for aurora engine currently. To disable backtracking, set this value to 0. Must be between 0 and 259200"
  validation {
    condition     = 0 <= var.backtrack_window && var.backtrack_window <= 259200
    error_message = "Error: backtrack_window value must be in between 0 and 259200 seconds (72 hours)."
  }
  sensitive   = false
}

variable "backup_retention_period" {
  type        = number
  default     = 1
  description = "How long to keep backups for (in days)."
  validation {
    condition     = 1 <= var.backup_retention_period && var.backup_retention_period <= 354
    error_message = "Error: backup_retention_period value must be in between 1 and 354 days."
  }
  sensitive   = false
}

variable "cluster_identifier_prefix" {
  type        = string
  default     = null
  description = "Creates a unique cluster identifier beginning with the specified prefix, Conflicts with cluster_identifier"
  sensitive   = false
}

variable "cluster_identifier" {
  type        = string
  default     = "webapp"
  description = "The cluster identifier. If omitted, Terraform will assign a random, unique identifier."
  validation {
    condition     = var.cluster_identifier != null
    error_message = "Error: cluster_identifier value must not null."
  }
  sensitive   = false
}

variable "copy_tags_to_snapshot" {
  type        = bool
  default     = true
  description = "Copy all Cluster tags to snapshots."
  validation {
    condition     = contains(toset([true, false]), var.copy_tags_to_snapshot)
    error_message = "Error: copy_tags_to_snapshot value must be either true or false only."
  }
  sensitive   = false
}

variable "database_name" {
  type        = string
  default     = "webapp_db"
  description = "Name for an automatically created database on cluster creation."
  validation {
    condition     = var.database_name != null && 5 < length(var.database_name) && length(var.database_name) < 33
    error_message = "Error: database_name value must not null, lenght must be in between 6 to 32 and suffix must be _db."
  }
  sensitive   = true
}

variable "db_cluster_parameter_group_name" {
  type        = string
  default     = "default"
  description = "The name of a DB Cluster parameter group to use."
  validation {
    condition     = var.db_cluster_parameter_group_name != null
    error_message = "Error: db_cluster_parameter_group_name value must not null."
  }
  sensitive   = false
}

variable "db_subnet_group_name" {
  type        = string
  default     = ""
  description = "The existing subnet group name to use, A cluster parameter group to associate with the cluster."
  validation {
    condition     = var.db_subnet_group_name != null
    error_message = "Error: db_subnet_group_name value must not null."
  }
  sensitive   = false
}

variable "deletion_protection" {
  type        = bool
  default     = false
  description = "If the DB instance should have deletion protection enabled. The database can not be deleted when this value is set to true"
  validation {
    condition     = contains(toset([true, false]), var.deletion_protection)
    error_message = "Error: deletion_protection value must be either true or false only."
  }
  sensitive   = false
}

variable "enable_http_endpoint" {
  type        = bool
  default     = true
  description = "Enable HTTP endpoint (data API). Only valid when engine_mode is set to serverless."
  validation {
    condition     = contains(toset([true, false]), var.enable_http_endpoint)
    error_message = "Error: enable_http_endpoint value must be either true or false only."
  }
  sensitive   = false
}

variable "enabled_cloudwatch_logs_exports" {
  type        = set(string)
  default     = [
    "postgresql"
  ]
  validation {
    condition     = 1 <= length(var.enabled_cloudwatch_logs_exports)
    error_message = "Error: enabled_cloudwatch_logs_exports value must be postgresql."
  }
  description = "Set of log types to export to cloudwatch, If omitted, no logs will be exported, supported log type(s) is / are: postgresql for Aurora."
  sensitive   = false
}

variable "engine" {
  type        = string
  default     = "aurora-postgresql"
  description = "The name of the database engine to be used for this DB cluster, supported engines are: aurora, aurora-mysql, aurora-postgresql."
  validation {
    condition     = var.engine != null && var.engine == "aurora-postgresql"
    error_message = "Error: engine value must not null."
  }
  sensitive   = false
}

variable "engine_mode" {
  type        = string
  default     = "serverless"
  description = "The database engine mode, supported engine modes are: global, multimaster, parallelquery, provisioned, serverless."
  validation {
    condition     = var.engine_mode != null && var.engine_mode == "serverless"
    error_message = "Error: engine value must not null."
  }
  sensitive   = false
}

variable "engine_version" {
  type        = string
  default     = "10.14"
  description = "Aurora database engine version."
  validation {
    condition     = var.engine_version != null && var.engine_version == "10.14"
    error_message = "Error: engine value must not null."
  }
  sensitive   = false
}

variable "final_snapshot_identifier" {
  type        = string
  default     = "webapp-snapshot-at"
  description = "The name of your final DB snapshot when this DB cluster is deleted. If omitted, no final snapshot will be made."
  validation {
    condition     = var.final_snapshot_identifier != null
    error_message = "Error: final_snapshot_identifier value must not null."
  }
  sensitive   = false
}

variable "global_cluster_identifier" {
  type        = string
  default     = "webapp"
  description = "The global cluster identifier specified on aws_rds_global_cluster"
  sensitive   = false
}

variable "iam_database_authentication_enabled" {
  type        = bool
  default     = true
  description = "Specifies whether IAM Database authentication should be enabled or not."
  validation {
    condition     = contains(toset([true, false]), var.iam_database_authentication_enabled)
    error_message = "Error: iam_database_authentication_enabled value must be either true or false only."
  }
  sensitive   = false
}

# Need to work on.
variable "iam_roles" {
  type        = set(string)
  default     = [""]
  description = "A List of ARNs for the IAM roles to associate to the RDS Cluster."
  validation {
    condition     = length(var.iam_roles) != 0
    error_message = "Error: iam_roles value must not be a empty list."
  }
  sensitive   = false
}

variable "kms_key_id" {
  type        = string
  default     = ""
  description = "The ARN for the KMS encryption key if one is set to the cluster, storage_encrypted must set to true."
  sensitive   = false
}

variable "master_password" {
  type        = string
  default     = "WebApp#2022"
  description = "The master password for the master username."
  validation {
    condition     = var.master_password != null && 8 <= length(var.master_password) && length(var.master_password) <= 63 && length(regexall("[/,\",@]+", var.master_password)) == 0
    error_message = "Error: master_password value must not null, master_password lenght must be between 8 and 63 and not contain forward slash, double quote and at the rate symbols."
  }
  sensitive   = true
}

variable "master_username" {
  type        = string
  default     = "webapp"
  description = "Username for the master database user."
  validation {
    condition     = var.master_username != null && 1 <= length(var.master_username) && length(var.master_username) <= 63
    error_message = "Error: master_username value must not null and master_username lenght must be between 1 and 63."
  }
  sensitive   = false
}

variable "port" {
  type        = string
  default     = "5432"
  description = "The port on which the database accepts connections."
  validation {
    condition     = var.port != null && var.port == "5432"
    error_message = "Error: port value must not null and port number must be 5432."
  }
  sensitive   = false
}

variable "preferred_backup_window" {
  type        = string
  default     = "01:00-02:00"
  description = "When to perform database backups, Time in UTC."
  validation {
    condition     = var.preferred_backup_window != null && var.preferred_backup_window == "00:00-00:59"
    error_message = "Error: preferred_backup_window value must not null and time must be 01:00-02:00."
  }
  sensitive   = false
}

variable "preferred_maintenance_window" {
  type        = string
  default     = "sun:01:00-sun:02:00"
  description = "The weekly time range during which system maintenance can occur, Time in UTC."
  validation {
    condition     = var.preferred_maintenance_window != null && var.preferred_maintenance_window == "sun:01:00-sun:02:00"
    error_message = "Error: preferred_backup_window value must not null and time must be sun:01:00-sun:02:00."
  }
  sensitive   = false
}

variable "replication_source_identifier" {
  type        = string
  default     = ""
  description = "ARN of a source DB cluster or DB instance if this DB cluster is to be created as a Read Replica."
  sensitive   = false
}

// restore_to_point_in_time nested argument.
variable "source_cluster_identifier" {
  type        = string
  default     = "webapp"
  description = "The identifier of the source database cluster from which to restore."
  sensitive   = false
}

// restore_to_point_in_time nested argument.
variable "restore_type" {
  type        = string
  default     = "copy-on-write"
  description = "Type of restore to be performed. Valid options are full-copy and copy-on-write."
  validation {
    condition     = contains(toset(["copy-on-write", "full-copy"]), var.restore_type)
    error_message = "Error: restore_type value must not null and restore_type either copy-on-write or full-copy only."
  }
  sensitive   = false
}

// restore_to_point_in_time nested argument.
variable "use_latest_restorable_time" {
  type        = bool
  default     = true
  description = "Set to true to restore the database cluster to the latest restorable backup time, Conflicts with restore_to_time."
  validation {
    condition     = contains(toset([true, false]), var.use_latest_restorable_time)
    error_message = "Error: use_latest_restorable_time value must be either true or false only."
  }
  sensitive   = false
}

// restore_to_point_in_time nested argument.
variable "restore_to_time" {
  type        = string
  default     = "2022-01-01T00:00:00Z"
  description = "Restore the database cluster to from which time, Time in UTC, Conflicts with use_latest_restorable_time"
  validation {
    condition     = var.restore_to_time != null
    error_message = "Error: restore_to_time value must not null."
  }
  sensitive   = false
}

// scaling_configuration nested argument.
variable "auto_pause" {
  type        = bool
  default     = true
  description = "A database cluster can be paused only when it is idle means it has no connections."
  validation {
    condition     = contains(toset([true, false]), var.auto_pause)
    error_message = "Error: auto_pause value must be either true or false only."
  }
  sensitive   = false
}

// scaling_configuration nested argument.
variable "max_capacity" {
  type        = number
  default     = 4
  description = "The maximum capacity for an Aurora database cluster in serverless database engine mode."
  validation {
    condition     = contains(toset([2, 4, 8, 16, 32, 64, 192, 384]), var.max_capacity)
    error_message = "Error: max_capacity value must be 2, 4, 8, 16, 32, 64, 192, 384."
  }
  sensitive   = false
}

// scaling_configuration nested argument.
variable "min_capacity" {
  type        = number
  default     = 2
  description = "The minimum capacity for an Aurora database cluster in serverless database engine mode."
  validation {
    condition     = contains(toset([2, 4, 8, 16, 32, 64, 192, 384]), var.min_capacity)
    error_message = "Error: min_capacity value must be 2, 4, 8, 16, 32, 64, 192, 384."
  }
  sensitive   = false
}

// scaling_configuration nested argument.
variable "seconds_until_auto_pause" {
  type        = number
  default     = 300
  description = "The time, in seconds, before an Aurora DB cluster in serverless mode is paused."
  validation {
    condition     = 300 <= var.seconds_until_auto_pause && var.seconds_until_auto_pause <= 86400
    error_message = "Error: seconds_until_auto_pause value must be in between 300 and 86400."
  }
  sensitive   = false
}

// scaling_configuration nested argument.
variable "timeout_action" {
  type        = string
  default     = "ForceApplyCapacityChange"
  description = "The action to take when the timeout is reached, valid values are ForceApplyCapacityChange or RollbackCapacityChange."
  validation {
    condition     = contains(toset(["ForceApplyCapacityChange", "RollbackCapacityChange"]), var.timeout_action)
    error_message = "Error: timeout_action value must be either ForceApplyCapacityChange or RollbackCapacityChange."
  }
  sensitive   = false
}

variable "skip_final_snapshot" {
  type        = bool
  default     = true
  description = "Determines whether a final database snapshot is created before the database cluster is deleted, if true then no snapshot is created, if false then snapshot is created."
  validation {
    condition     = contains(toset([true, false]), var.skip_final_snapshot)
    error_message = "Error: skip_final_snapshot value must be either true or false only."
  }
  sensitive   = false
}

variable "snapshot_identifier" {
  type        = string
  default     = null
  description = "Specifies whether or not to create this cluster from a snapshot, can specify snapshot name or database cluster ARN."
  sensitive   = false
}

variable "source_region" {
  type        = string
  default     = ""
  description = "The source region for an encrypted replica DB cluster."
  sensitive   = false
}

variable "storage_encrypted" {
  type        = bool
  default     = true
  description = "Specifies whether the database cluster is encrypted."
  validation {
    condition     = var.storage_encrypted == true
    error_message = "Error: storage_encrypted value must be true only."
  }
  sensitive   = false
}

variable "tags" {
  type        = map(string)
  default     = {
    "AppName"           = "Generic"
    "Division"          = "Data Quality"
    "Developer"         = "Balaji Pothula"
    "DeveloperEmail"    = "Balaji.Pothula@techie.com"
    "Manager"           = "Ram"
    "ManagerEmail"      = "Ram@techie.com"
    "ServiceOwner"      = "Ali"
    "ServiceOwnerEmail" = "Ali@techie.com"
    "ProductOwner"      = "Eva"
    "ProductOwnerEmail" = "Eva@techie.com"
  }
  description = "A map of tags to assign to the database cluster."
  validation {
    condition     = var.tags != null && 0 < length(var.tags) && length(var.tags) < 51
    error_message = "Error: tags at least one or more expected upto 50."
  }
  sensitive   = false
}

variable "vpc_security_group_ids" {
  type        = set(string)
  default     = [
    "sg-00824ee300a9f653e",
  ] 
  description = "List of VPC security groups to associate with the Cluster."
  validation {
    condition     = 0 < length(var.vpc_security_group_ids) && length(var.vpc_security_group_ids) < 6
    error_message = "Error: vpc_security_group_ids at least one or more expected upto 5."
  }
  sensitive   = false
}

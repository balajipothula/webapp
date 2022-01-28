# Resource  type : module
# Module    name : webapp_aws_rds_cluster
# Attribute name : arn
output "webapp_aws_rds_cluster_arn" {
  value       = module.webapp_aws_rds_cluster.arn
  description = "ARN of RDS Cluster"
  sensitive   = false
}

output "webapp_aws_rds_cluster_id" {
  value       = module.webapp_aws_rds_cluster.id
  description = "The RDS Cluster Identifier."
  sensitive   = false
}

output "webapp_aws_rds_cluster_cluster_identifier" {
  value       = module.webapp_aws_rds_cluster.cluster_identifier
  description = "The RDS Cluster Identifier"
  sensitive   = false
}

output "webapp_aws_rds_cluster_cluster_resource_id" {
  value       = module.webapp_aws_rds_cluster.cluster_resource_id
  description = "The RDS Cluster Resource ID."
  sensitive   = false
}

output "webapp_aws_rds_cluster_cluster_members" {
  value       = module.webapp_aws_rds_cluster.cluster_members
  description = "List of RDS Instances that are a part of this cluster."
  sensitive   = false
}

output "webapp_aws_rds_cluster_availability_zones" {
  value       = module.webapp_aws_rds_cluster.availability_zones
  description = "The availability zone of the instance."
  sensitive   = false
}

output "webapp_aws_rds_cluster_backup_retention_period" {
  value       = module.webapp_aws_rds_cluster.backup_retention_period
  description = "The backup retention period."
  sensitive   = false
}

output "webapp_aws_rds_cluster_preferred_backup_window" {
  value       = module.webapp_aws_rds_cluster.preferred_backup_window
  description = "The daily time range during which the backups happen."
  sensitive   = false
}

output "webapp_aws_rds_cluster_preferred_maintenance_window" {
  value       = module.webapp_aws_rds_cluster.preferred_maintenance_window
  description = "The maintenance window."
  sensitive   = false
}

output "webapp_aws_rds_cluster_endpoint" {
  value       = module.webapp_aws_rds_cluster.endpoint
  description = "The DNS address of the RDS instance."
  sensitive   = false
}

output "webapp_aws_rds_cluster_reader_endpoint" {
  value       = module.webapp_aws_rds_cluster.reader_endpoint 
  description = "A read-only endpoint for the Aurora cluster, automatically load-balanced across replicas."
  sensitive   = false
}

output "webapp_aws_rds_cluster_engine" {
  value       = module.webapp_aws_rds_cluster.engine 
  description = "The database engine."
  sensitive   = false
}

output "webapp_aws_rds_cluster_engine_version_actual" {
  value       = module.webapp_aws_rds_cluster.engine_version_actual 
  description = "The running version of the database."
  sensitive   = false
}

output "webapp_aws_rds_cluster_database_name" {
  value       = module.webapp_aws_rds_cluster.database_name 
  description = "The database name."
  sensitive   = false
}

output "webapp_aws_rds_cluster_port" {
  value       = module.webapp_aws_rds_cluster.port 
  description = "The database port."
  sensitive   = false
}

output "webapp_aws_rds_cluster_master_username" {
  value       = module.webapp_aws_rds_cluster.master_username 
  description = "The master username for the database."
  sensitive   = true
}

output "webapp_aws_rds_cluster_storage_encrypted" {
  value       = module.webapp_aws_rds_cluster.storage_encrypted 
  description = "Specifies whether the DB cluster is encrypted."
  sensitive   = false
}

output "webapp_aws_rds_cluster_replication_source_identifier" {
  value       = module.webapp_aws_rds_cluster.replication_source_identifier 
  description = "ARN of the source DB cluster or DB instance if this DB cluster is created as a Read Replica."
  sensitive   = false
}

output "webapp_aws_rds_cluster_hosted_zone_id" {
  value       = module.webapp_aws_rds_cluster.hosted_zone_id 
  description = "The Route53 Hosted Zone ID of the endpoint."
  sensitive   = false
}

output "webapp_aws_rds_cluster_tags_all" {
  value       = module.webapp_aws_rds_cluster.tags_all 
  description = "A map of tags assigned to the resource, including those inherited from the provider."
  sensitive   = false
}

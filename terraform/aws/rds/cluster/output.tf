# Resource  type : resource "aws_rds_cluster" "generic" {
# Resource  name : generic
# Attribute name : arn
output "arn" {
  value       = aws_rds_cluster.generic.arn
  description = "ARN of RDS Cluster"
  sensitive   = false
}

output "id" {
  value       = aws_rds_cluster.generic.id
  description = "The RDS Cluster Identifier."
  sensitive   = false
}

output "cluster_identifier" {
  value       = aws_rds_cluster.generic.cluster_identifier
  description = "The RDS Cluster Identifier"
  sensitive   = false
}

output "cluster_resource_id" {
  value       = aws_rds_cluster.generic.cluster_resource_id
  description = "The RDS Cluster Resource ID."
  sensitive   = false
}

output "cluster_members" {
  value       = aws_rds_cluster.generic.cluster_members
  description = "List of RDS Instances that are a part of this cluster."
  sensitive   = false
}

output "availability_zones" {
  value       = aws_rds_cluster.generic.availability_zones
  description = "The availability zone of the instance."
  sensitive   = false
}

output "backup_retention_period" {
  value       = aws_rds_cluster.generic.backup_retention_period
  description = "The backup retention period."
  sensitive   = false
}

output "preferred_backup_window" {
  value       = aws_rds_cluster.generic.preferred_backup_window
  description = "The daily time range during which the backups happen."
  sensitive   = false
}

output "preferred_maintenance_window" {
  value       = aws_rds_cluster.generic.preferred_maintenance_window
  description = "The maintenance window."
  sensitive   = false
}

output "endpoint" {
  value       = aws_rds_cluster.generic.endpoint
  description = "The DNS address of the RDS instance."
  sensitive   = false
}

output "reader_endpoint" {
  value       = aws_rds_cluster.generic.reader_endpoint 
  description = "A read-only endpoint for the Aurora cluster, automatically load-balanced across replicas."
  sensitive   = false
}

output "engine" {
  value       = aws_rds_cluster.generic.engine 
  description = "The database engine."
  sensitive   = false
}

output "engine_version_actual" {
  value       = aws_rds_cluster.generic.engine_version_actual 
  description = "The running version of the database."
  sensitive   = false
}

output "database_name" {
  value       = aws_rds_cluster.generic.database_name 
  description = "The database name."
  sensitive   = false
}

output "port" {
  value       = aws_rds_cluster.generic.port 
  description = "The database port."
  sensitive   = false
}

output "master_username" {
  value       = aws_rds_cluster.generic.master_username 
  description = "The master username for the database."
  sensitive   = false
}

output "storage_encrypted" {
  value       = aws_rds_cluster.generic.storage_encrypted 
  description = "Specifies whether the DB cluster is encrypted."
  sensitive   = false
}

output "replication_source_identifier" {
  value       = aws_rds_cluster.generic.replication_source_identifier 
  description = "ARN of the source DB cluster or DB instance if this DB cluster is created as a Read Replica."
  sensitive   = false
}

output "hosted_zone_id" {
  value       = aws_rds_cluster.generic.hosted_zone_id 
  description = "The Route53 Hosted Zone ID of the endpoint."
  sensitive   = false
}

output "tags_all" {
  value       = aws_rds_cluster.generic.tags_all 
  description = "A map of tags assigned to the resource, including those inherited from the provider."
  sensitive   = false
}

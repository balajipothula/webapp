# Resource type : aws_rds_cluster_instance
# Resource name : generic
# Attribute name : arn
output "arn" {
  value       = aws_rds_cluster_instance.generic.arn
  description = "Amazon Resource Name (ARN) of cluster instance."
  sensitive   = false
}

output "availability_zone" {
  value       = aws_rds_cluster_instance.generic.availability_zone
  description = "Availability zone of the instance."
  sensitive   = false
}

output "cluster_identifier" {
  value       = aws_rds_cluster_instance.generic.cluster_identifier
  description = "RDS Cluster Identifier."
  sensitive   = false
}

output "dbi_resource_id" {
  value       = aws_rds_cluster_instance.generic.dbi_resource_id
  description = "Region-unique, immutable identifier for the DB instance."
  sensitive   = false
}

output "endpoint" {
  value       = aws_rds_cluster_instance.generic.endpoint
  description = "DNS address for this instance. May not be writable."
  sensitive   = false
}

output "engine" {
  value       = aws_rds_cluster_instance.generic.engine
  description = "Database engine."
  sensitive   = false
}

output "engine_version_actual" {
  value       = aws_rds_cluster_instance.generic.engine_version_actual
  description = "Database engine version."
  sensitive   = false
}

output "id" {
  value       = aws_rds_cluster_instance.generic.id
  description = "Instance identifier."
  sensitive   = false
}

output "identifier" {
  value       = aws_rds_cluster_instance.generic.identifier
  description = "Instance identifier."
  sensitive   = false
}

output "kms_key_id" {
  value       = aws_rds_cluster_instance.generic.kms_key_id
  description = "ARN for the KMS encryption key if one is set to the cluster."
  sensitive   = false
}

output "network_type" {
  value       = aws_rds_cluster_instance.generic.network_type
  description = "Network type of the DB instance."
  sensitive   = false
}

output "performance_insights_enabled" {
  value       = aws_rds_cluster_instance.generic.performance_insights_enabled
  description = "Specifies whether Performance Insights is enabled or not."
  sensitive   = false
}

output "performance_insights_kms_key_id" {
  value       = aws_rds_cluster_instance.generic.performance_insights_kms_key_id
  description = "ARN for the KMS encryption key used by Performance Insights."
  sensitive   = false
}

output "port" {
  value       = aws_rds_cluster_instance.generic.port
  description = "Database port."
  sensitive   = false
}

output "storage_encrypted" {
  value       = aws_rds_cluster_instance.generic.storage_encrypted
  description = "Specifies whether the DB cluster is encrypted."
  sensitive   = false
}

output "tags_all" {
  value       = aws_rds_cluster_instance.generic.tags_all
  description = "Map of tags assigned to the resource, including those inherited from the provider default_tags configuration block."
  sensitive   = false
}

output "writer" {
  value       = aws_rds_cluster_instance.generic.writer
  description = "Boolean indicating if this instance is writable. False indicates this instance is a read replica."
  sensitive   = false
}

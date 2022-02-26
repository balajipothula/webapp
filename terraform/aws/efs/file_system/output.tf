# Resource  type : aws_efs_file_system
# Resource  name : generic
# Attribute name : arn
output "arn" {
  value       = aws_efs_file_system.generic.arn
  description = "Amazon Resource Name of the file system."
  sensitive   = false
}

output "availability_zone_id" {
  value       = aws_efs_file_system.generic.availability_zone_id
  description = "The identifier of the Availability Zone in which the file system's One Zone storage classes exist."
  sensitive   = false
}

output "id" {
  value       = aws_efs_file_system.generic.id
  description = "The ID that identifies the file system."
  sensitive   = false
}

output "dns_name" {
  value       = aws_efs_file_system.generic.dns_name
  description = "The DNS name for the filesystem."
  sensitive   = false
}

output "owner_id" {
  value       = aws_efs_file_system.generic.owner_id
  description = "The AWS account that created the file system."
  sensitive   = false
}

output "number_of_mount_targets" {
  value       = aws_efs_file_system.generic.number_of_mount_targets
  description = "The current number of mount targets that the file system has."
  sensitive   = false
}

output "size_in_bytes" {
  value       = aws_efs_file_system.generic.size_in_bytes
  description = "The latest known metered size (in bytes) of data stored in the file system."
  sensitive   = false
}

output "tags_all" {
  value       = aws_efs_file_system.generic.tags_all
  description = "A map of tags assigned to the resource."
  sensitive   = false
}

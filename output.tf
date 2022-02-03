output "aws_region_current_name" {
  value       = data.aws_region.current.name
  description = "The name of the selected region."
  sensitive   = false
}

output "aws_vpc_default_id" {
  value       = data.aws_vpc.default.id
  description = "The id of the specific VPC to retrieve."
  sensitive   = false
}

output "aws_vpc_default_cidr_block" {
  value       = data.aws_vpc.default.cidr_block
  description = "The CIDR block for the association."
  sensitive   = false
}

output "aws_availability_zones_available_names" {
  value       = data.aws_availability_zones.available.names
  description = "A list of the Availability Zone names available to the account."
  sensitive   = false
}

output "aws_subnet_ids_available_ids" {
  value       = data.aws_subnet_ids.available.ids
  description = "A set of all the subnet ids found."
  sensitive   = false
}

output "aws_security_groups_default_ids" {
  value       = data.aws_security_groups.default.ids
  description = "IDs of the matches security groups."
  sensitive   = false
}

output "archive_file_webapp_output_path" {
  value       = data.archive_file.webapp.output_path
  description = "Web Application source file output path."
  sensitive   = false
}

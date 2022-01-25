output "aws_region" {
  value       = data.aws_region.current.name
  description = "The name of the selected region."
  sensitive   = false
}

output "aws_vpc" {
  value       = data.aws_vpc.default.id
  description = "The id of the specific VPC to retrieve."
  sensitive   = false
}

output "aws_availability_zones" {
  value       = data.aws_availability_zones.available.names
  description = "A list of the Availability Zone names available to the account."
  sensitive   = false
}

output "aws_subnet_ids" {
  value       = data.aws_subnet_ids.available.ids
  description = "A set of all the subnet ids found."
  sensitive   = false
}

output "aws_security_groups" {
  value       = data.aws_security_groups.default.ids
  description = "IDs of the matches security groups."
  sensitive   = false
}

output "output_path" {
  value       = data.archive_file.webapp.output_path
  description = "Web Application source file output path."
  sensitive   = false
}

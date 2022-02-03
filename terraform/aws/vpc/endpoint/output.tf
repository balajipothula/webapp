# Resource  type : aws_vpc_endpoint
# Resource  name : generic
# Attribute name : id
output "id" {
  value       = aws_vpc_endpoint.generic.id
  description = "The ID of the VPC endpoint."
  sensitive   = false
}

output "arn" {
  value       = aws_vpc_endpoint.generic.arn
  description = "The ARN of the VPC endpoint."
  sensitive   = false
}

output "cidr_blocks" {
  value       = aws_vpc_endpoint.generic.cidr_blocks
  description = "The list of CIDR blocks for the exposed AWS service."
  sensitive   = false
}

output "dns_entry" {
  value       = aws_vpc_endpoint.generic.dns_entry
  description = "The DNS entries for the VPC Endpoint."
  sensitive   = false
}

output "network_interface_ids" {
  value       = aws_vpc_endpoint.generic.network_interface_ids
  description = "One or more network interfaces for the VPC Endpoint."
  sensitive   = false
}

output "owner_id" {
  value       = aws_vpc_endpoint.generic.owner_id
  description = "The ID of the AWS account that owns the VPC endpoint."
  sensitive   = false
}

output "prefix_list_id" {
  value       = aws_vpc_endpoint.generic.prefix_list_id
  description = "The prefix list ID of the exposed AWS service."
  sensitive   = false
}

output "requester_managed" {
  value       = aws_vpc_endpoint.generic.requester_managed
  description = "Whether or not the VPC Endpoint is being managed by its service."
  sensitive   = false
}

output "state" {
  value       = aws_vpc_endpoint.generic.state
  description = "The state of the VPC endpoint."
  sensitive   = false
}

output "tags_all" {
  value       = aws_vpc_endpoint.generic.tags_all
  description = "A map of tags assigned to the resource."
  sensitive   = false
}

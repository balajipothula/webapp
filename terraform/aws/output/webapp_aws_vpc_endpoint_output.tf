# Resource  type : module
# Module    name : webapp_aws_vpc_endpoint
# Attribute name : id
output "webapp_aws_vpc_endpoint_id" {
  value       = module.webapp_aws_vpc_endpoint.id
  description = "The ID of the VPC endpoint."
  sensitive   = false
}

output "webapp_aws_vpc_endpoint_arn" {
  value       = module.webapp_aws_vpc_endpoint.arn
  description = "The ARN of the VPC endpoint."
  sensitive   = false
}

output "webapp_aws_vpc_endpoint_cidr_blocks" {
  value       = module.webapp_aws_vpc_endpoint.cidr_blocks
  description = "The list of CIDR blocks for the exposed AWS service."
  sensitive   = false
}

output "webapp_aws_vpc_endpoint_dns_entry" {
  value       = module.webapp_aws_vpc_endpoint.dns_entry
  description = "The DNS entries for the VPC Endpoint."
  sensitive   = false
}

output "webapp_aws_vpc_endpoint_network_interface_ids" {
  value       = module.webapp_aws_vpc_endpoint.network_interface_ids
  description = "One or more network interfaces for the VPC Endpoint."
  sensitive   = false
}

output "webapp_aws_vpc_endpoint_owner_id" {
  value       = module.webapp_aws_vpc_endpoint.owner_id
  description = "The ID of the AWS account that owns the VPC endpoint."
  sensitive   = false
}

output "webapp_aws_vpc_endpoint_prefix_list_id" {
  value       = module.webapp_aws_vpc_endpoint.prefix_list_id
  description = "The prefix list ID of the exposed AWS service."
  sensitive   = false
}

output "webapp_aws_vpc_endpoint_requester_managed" {
  value       = module.webapp_aws_vpc_endpoint.requester_managed
  description = "Whether or not the VPC Endpoint is being managed by its service."
  sensitive   = false
}

output "webapp_aws_vpc_endpoint_state" {
  value       = module.webapp_aws_vpc_endpoint.state
  description = "The state of the VPC endpoint."
  sensitive   = false
}

output "webapp_aws_vpc_endpoint_tags_all" {
  value       = module.webapp_aws_vpc_endpoint.tags_all
  description = "A map of tags assigned to the resource."
  sensitive   = false
}

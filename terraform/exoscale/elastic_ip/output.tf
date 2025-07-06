/*
 * Data Source type : exoscale_elastic_ip
 * Data Source name : generic
 * Attribute name   : address_family
 */
/*
output "address_family" {
  value       = data.exoscale_elastic_ip.generic.address_family
  description = "The EIP (Elastic IP) address family."
  sensitive   = false
}

output "cidr" {
  value       = data.exoscale_elastic_ip.generic.cidr
  description = "The EIP (Elastic IP) CIDR (Classless Inter-Domain Routing)."
  sensitive   = false
}

output "description" {
  value       = data.exoscale_elastic_ip.generic.description
  description = "The EIP (Elastic IP) description."
  sensitive   = false
}

output "healthcheck" {
  value       = data.exoscale_elastic_ip.generic.healthcheck
  description = "The managed EIP (Elastic IP) healthcheck configuration."
  sensitive   = false
}

output "reverse_dns" {
  value       = data.exoscale_elastic_ip.generic.healthcheck
  description = "Domain name for reverse DNS record."
  sensitive   = false
}
*/

/*
 * Resource  type : exoscale_elastic_ip
 * Resource  name : generic
 * Attribute name : cidr
 */
output "cidr" {
  value       = exoscale_elastic_ip.generic.cidr
  description = "The EIP (Elastic Internet Protocol) CIDR (Classless Inter-Domain Routing)."
  sensitive   = false
}

output "id" {
  value       = exoscale_elastic_ip.generic.id
  description = "The ID of this resource."
  sensitive   = false
}

output "ip_address" {
  value       = exoscale_elastic_ip.generic.ip_address
  description = "The EIP (Elastic Internet Protocol) IPv4 or IPv6 address."
  sensitive   = false
}

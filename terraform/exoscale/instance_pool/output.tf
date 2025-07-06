/*
 * Resource  type : exoscale_instance_pool
 * Resource  name : generic
 * Attribute name : id
 */
output "id" {
  value       = exoscale_instance_pool.generic.id
  description = "The compute instance ID."
  sensitive   = false
}
/*
output "public_ip_address" {
  value       = exoscale_instance_pool.generic.public_ip_address
  description = "The instance IPv4 address."
  sensitive   = false
}

output "ipv6_address" {
  value       = exoscale_instance_pool.generic.ipv6_address
  description = "The instance IPv6 address."
  sensitive   = false
}
*/

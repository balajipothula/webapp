/*
 * Data Source type : exoscale_template
 * Data Source name : generic
 * Attribute name   : default_user
 */
/*
output "default_user" {
  value       = data.exoscale_template.generic.default_user
  description = "Username to use to log into a compute instance based on template."
  sensitive   = false
}
*/
/*
 * Resource  type : exoscale_compute_instance
 * Resource  name : generic
 * Attribute name : id
 */

output "id" {
  value       = exoscale_compute_instance.generic.id
  description = "The compute instance ID."
  sensitive   = false
}

output "created_at" {
  value       = exoscale_compute_instance.generic.created_at
  description = "The instance creation date."
  sensitive   = false
}

output "ipv6_address" {
  value       = exoscale_compute_instance.generic.ipv6_address
  description = "The instance IPv6 address."
  sensitive   = false
}

output "public_ip_address" {
  value       = exoscale_compute_instance.generic.public_ip_address
  description = "The instance IPv4 address."
  sensitive   = false
}

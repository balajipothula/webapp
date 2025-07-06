/*
 * Resource  type : exoscale_private_network
 * Resource  name : generic
 * Attribute name : id
 */
output "id" {
  value       = exoscale_private_network.generic.id
  description = "The private network ID."
  sensitive   = false
}

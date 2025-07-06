/*
 * Data Source type : exoscale_nlb_service
 * Data Source name : generic
 * Attribute name   : description
 */
/*
output "description" {
  value       = data.exoscale_nlb_service.generic.description
  description = "The NLB (Network Load Balancer) description."
  sensitive   = false
}

output "created_at" {
  value       = data.exoscale_nlb_service.generic.created_at
  description = "The NLB (Network Load Balancer) creation date."
  sensitive   = false
}
*/
/*
 * Resource  type : exoscale_nlb_service
 * Resource  name : generic
 * Attribute name : id
 */
output "id" {
  value       = exoscale_nlb_service.generic.id
  description = "The NLB (Network Load Balancer) ID."
  sensitive   = false
}
/*
output "ip_address" {
  value       = exoscale_nlb_service.generic.ip_address
  description = "The NLB (Network Load Balancer) public IPv4 address."
  sensitive   = false
}

output "services" {
  value       = exoscale_nlb_service.generic.services
  description = "The list of the `exoscale_nlb_service` names."
  sensitive   = false
}
*/
output "state" {
  value       = exoscale_nlb_service.generic.state
  description = "The current NLB (Network Load Balancer) state."
  sensitive   = false
}

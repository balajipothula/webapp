/*
 * Data Source type : exoscale_security_group
 * Data Source name : generic
 * Attribute name   : id
 */
/*
output "security_group_id" {
  value       = data.exoscale_security_group.generic.id
  description = "The security group ID to match."
  sensitive   = false
}
*/

/*
 * Resource  type : exoscale_security_group
 * Resource  name : generic
 * Attribute name : id
 */
output "id" {
  value       = exoscale_security_group.generic.id
  description = "The security group ID."
  sensitive   = false
}

/*
 * Resource  type : exoscale_security_group_rule
 * Resource  name : generic
 * Attribute name : id
 */
output "id" {
  value       = exoscale_security_group_rule.generic.id
  description = "The security group rule ID."
  sensitive   = false
}

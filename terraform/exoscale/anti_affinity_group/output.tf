/*
 * Data Source type : exoscale_anti_affinity_group
 * Data Source name : generic
 * Attribute name   : instances
 */

/*
output "instances" {
  value       = data.exoscale_template.generic.instances
  description = "The list of attached exoscale_compute_instance IDs."
  sensitive   = false
}
*/

/*
 * Resource  type : exoscale_anti_affinity_group
 * Resource  name : generic
 * Attribute name : id
 */
output "id" {
  value       = exoscale_anti_affinity_group.generic.id
  description = "The anti-affinity group ID."
  sensitive   = false
}

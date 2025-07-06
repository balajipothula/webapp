/*
 * Resource  type : exoscale_sks_kubeconfig
 * Resource  name : generic
 * Attribute name : id
 */
output "id" {
  value       = exoscale_sks_kubeconfig.generic.id
  description = "The ID of this resource."
  sensitive   = false
}

output "kubeconfig" {
  value       = exoscale_sks_kubeconfig.generic.kubeconfig
  description = "The generated kubeconfig in YAML (Yet Another Markup Language) format."
  sensitive   = true
}

output "ready_for_renewal" {
  value       = exoscale_sks_kubeconfig.generic.ready_for_renewal
  description = "Ready for renewal or not."
  sensitive   = false
}

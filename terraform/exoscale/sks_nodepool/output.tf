/*
 * Resource  type : exoscale_sks_nodepool
 * Resource  name : generic
 * Attribute name : id
 */
output "id" {
  value       = exoscale_sks_nodepool.generic.id
  description = "The SKS (Scalable Kubernetes Service) node pool ID."
  sensitive   = false
}

output "created_at" {
  value       = exoscale_sks_nodepool.generic.created_at
  description = "The pool creation date."
  sensitive   = false
}

output "instance_pool_id" {
  value       = exoscale_sks_nodepool.generic.instance_pool_id
  description = "The underlying exoscale_instance_pool ID."
  sensitive   = false
}

output "state" {
  value       = exoscale_sks_nodepool.generic.state
  description = "The current pool state."
  sensitive   = false
}

output "template_id" {
  value       = exoscale_sks_nodepool.generic.template_id
  description = "The managed instances template ID."
  sensitive   = false
}

output "version" {
  value       = exoscale_sks_nodepool.generic.version
  description = "The managed instances version."
  sensitive   = false
}

/*
 * Resource  type : exoscale_sks_cluster
 * Resource  name : generic
 * Attribute name : id
 */
output "id" {
  value       = exoscale_sks_cluster.generic.id
  description = "The SKS (Scalable Kubernetes Service) cluster ID."
  sensitive   = false
}

output "aggregation_ca" {
  value       = exoscale_sks_cluster.generic.aggregation_ca
  description = "The CA (Certificate Authority) certificate in PEM (Privacy Enhanced Mail) format for TLS (Transport Layer Security) communications between the control plane and the aggregation layer."
  sensitive   = false
}

output "control_plane_ca" {
  value       = exoscale_sks_cluster.generic.control_plane_ca
  description = "The CA (Certificate Authority) certificate in PEM (Privacy Enhanced Mail) format for TLS (Transport Layer Security) communications between control plane components."
  sensitive   = false
}

output "created_at" {
  value       = exoscale_sks_cluster.generic.created_at
  description = "The cluster creation date."
  sensitive   = false
}

output "endpoint" {
  value       = exoscale_sks_cluster.generic.endpoint
  description = "The cluster API endpoint."
  sensitive   = false
}

output "kubelet_ca" {
  value       = exoscale_sks_cluster.generic.kubelet_ca
  description = "The CA (Certificate Authority) certificate in PEM (Privacy Enhanced Mail) format for TLS (Transport Layer Security) communications between kubelets and the control plane."
  sensitive   = false
}

output "nodepools" {
  value       = exoscale_sks_cluster.generic.nodepools
  description = "The list of exoscale_sks_nodepool IDs attached to the cluster."
  sensitive   = false
}

output "state" {
  value       = exoscale_sks_cluster.generic.state
  description = "The cluster state."
  sensitive   = false
}

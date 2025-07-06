/*
 * Resource  type : exoscale_database
 * Resource  name : generic
 * Attribute name : ca_certificate
 */
output "ca_certificate" {
  value       = exoscale_database.generic.ca_certificate
  description = "CA (Certificate Authority) Certificate required to reach a DBaaS service through a TLS (Transport Layer Security) protected connection."
  sensitive   = false
}

output "created_at" {
  value       = exoscale_database.generic.created_at
  description = "The creation date of the database service."
  sensitive   = false
}

output "disk_size" {
  value       = exoscale_database.generic.disk_size
  description = "The disk size of the database service."
  sensitive   = false
}

output "node_cpus" {
  value       = exoscale_database.generic.node_cpus
  description = "The number of CPUs of the database service."
  sensitive   = false
}

output "node_memory" {
  value       = exoscale_database.generic.node_memory
  description = "The amount of memory of the database service."
  sensitive   = false
}

output "nodes" {
  value       = exoscale_database.generic.nodes
  description = "The number of nodes of the database service."
  sensitive   = false
}

output "state" {
  value       = exoscale_database.generic.state
  description = "The current state of the database service."
  sensitive   = false
}

output "updated_at" {
  value       = exoscale_database.generic.updated_at
  description = "The date of the latest database service update."
  sensitive   = false
}

output "uri" {
  value       = exoscale_database.generic.uri
  description = "The database service connection URI (Uniform Resource Identifier)."
  sensitive   = false
}

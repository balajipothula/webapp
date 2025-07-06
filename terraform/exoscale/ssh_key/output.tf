/*
 * Resource  type : exoscale_ssh_key
 * Resource  name : generic
 * Attribute name : fingerprint
 */
output "fingerprint" {
  value       = exoscale_ssh_key.generic.fingerprint
  description = "The SSH (Secure SHell) key unique identifier."
  sensitive   = true
}

output "id" {
  value       = exoscale_ssh_key.generic.id
  description = "The ID of exoscale_ssh_key resource."
  sensitive   = true
}

# Resource  type : aws_ecrpublic_repository_policy
# Resource  name : generic
# Attribute name : registry_id

output "registry_id" {
  value       = aws_ecrpublic_repository_policy.generic.registry_id
  description = "The registry ID where the repository was created."
  sensitive   = false
}

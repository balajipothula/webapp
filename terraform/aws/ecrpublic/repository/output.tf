# Resource  type : aws_ecrpublic_repository
# Resource  name : generic
# Attribute name : id

output "arn" {
  value       = aws_ecrpublic_repository.generic.arn
  description = "Full ARN of the repository."
  sensitive   = false
}

output "id" {
  value       = aws_ecrpublic_repository.generic.id
  description = "The repository name."
  sensitive   = false
}

output "registry_id" {
  value       = aws_ecrpublic_repository.generic.registry_id
  description = "The registry ID where the repository was created."
  sensitive   = false
}

output "repository_uri" {
  value       = aws_ecrpublic_repository.generic.repository_uri
  description = "The URI of the repository."
  sensitive   = false
}

output "tags_all" {
  value       = aws_ecrpublic_repository.generic.tags_all
  description = "Map of tags assigned to the resource, including those inherited from the provider."
  sensitive   = false
}

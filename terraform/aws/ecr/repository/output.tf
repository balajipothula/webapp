# Resource  type : aws_ecr_repository
# Resource  name : generic
# Attribute name : arn
output "arn" {
  value       = aws_ecr_repository.generic.arn
  description = "Full ARN of the repository."
  sensitive   = false
}

output "registry_id" {
  value       = aws_ecr_repository.generic.registry_id
  description = "The registry ID where the repository was created."
  sensitive   = false
}

output "repository_url" {
  value       = aws_ecr_repository.generic.repository_url
  description = "The URL of the repository."
  sensitive   = false
}

output "tags_all" {
  value       = aws_ecr_repository.generic.tags_all
  description = "A map of tags assigned to the resource, including those inherited from the provider."
  sensitive   = false
}

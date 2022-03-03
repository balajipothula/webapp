# Resource  type : aws_ecs_cluster
# Resource  name : generic
# Attribute name : arn
output "arn" {
  value       = aws_ecs_cluster.generic.arn 
  description = "ARN that identifies the cluster."
  sensitive   = false
}

output "id" {
  value       = aws_ecs_cluster.generic.id 
  description = "ARN that identifies the cluster."
  sensitive   = false
}

output "tags_all" {
  value       = aws_ecs_cluster.generic.tags_all 
  description = "Map of tags assigned to the resource, including those inherited from the provider."
  sensitive   = false
}

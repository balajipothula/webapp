# Resource  type : aws_s3_bucket_object_object
# Resource  name : generic
# Attribute name : id
output "etag" {
  value       = aws_s3_bucket_object.generic.etag
  description = "ETag generated for the object."
  sensitive   = false
}

output "id" {
  value       = aws_s3_bucket_object.generic.id
  description = "key of the resource."
  sensitive   = false
}

output "tags_all" {
  value       = aws_s3_bucket_object.generic.tags_all
  description = "Map of tags assigned to the resource"
  sensitive   = false
}

output "version_id" {
  value       = aws_s3_bucket_object.generic.version_id
  description = "Unique version ID value for the object."
  sensitive   = false
}

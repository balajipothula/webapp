output "webapp_aws_s3_bucket_object_etag" {
  value       = module.webapp_aws_s3_bucket_object.etag
  description = "ETag generated for the object."
  sensitive   = false
}

output "webapp_aws_s3_bucket_object_id" {
  value       = module.webapp_aws_s3_bucket_object.id
  description = "key of the resource."
  sensitive   = false
}

output "webapp_aws_s3_bucket_object_tags_all" {
  value       = module.webapp_aws_s3_bucket_object.tags_all
  description = "Map of tags assigned to the resource"
  sensitive   = false
}

output "webapp_aws_s3_bucket_object_version_id" {
  value       = module.webapp_aws_s3_bucket_object.version_id
  description = "Unique version ID value for the object."
  sensitive   = false
}

# Resource  type : aws_s3_object
# Resource  name : generic
# Attribute name : id

output "id" {
  value       = aws_s3_object.generic.id
  description = "ID of the object."
  sensitive   = false
}

output "arn" {
  value       = aws_s3_object.generic.arn
  description = "ARN of the object."
  sensitive   = false
}

output "checksum_crc32" {
  value       = aws_s3_object.generic.checksum_crc32
  description = "The base64-encoded, 32-bit CRC32 checksum of the object."
  sensitive   = false
}

output "checksum_crc32c" {
  value       = aws_s3_object.generic.checksum_crc32c
  description = "The base64-encoded, 32-bit CRC32C checksum of the object."
  sensitive   = false
}

output "checksum_sha1" {
  value       = aws_s3_object.generic.checksum_sha1
  description = "The base64-encoded, 160-bit SHA-1 digest of the object."
  sensitive   = false
}

output "checksum_sha256" {
  value       = aws_s3_object.generic.checksum_sha256
  description = "The base64-encoded, 256-bit SHA-256 digest of the object."
  sensitive   = false
}

output "etag" {
  value       = aws_s3_object.generic.etag
  description = "ETag generated for the object (an MD5 sum of the object content)."
  sensitive   = false
}

output "tags_all" {
  value       = aws_s3_object.generic.tags_all
  description = "Map of tags assigned to the resource, including those inherited from the provider default_tags configuration block."
  sensitive   = false
}

output "version_id" {
  value       = aws_s3_object.generic.version_id
  description = "Unique version ID value for the object, if bucket versioning is enabled."
  sensitive   = false
}


output "key" {
  value       = aws_s3_object.generic.key
  description = "Unique version ID value for the object, if bucket versioning is enabled."
  sensitive   = false
}


output "source_path" {
  value       = aws_s3_object.generic.source
  description = "Unique version ID value for the object, if bucket versioning is enabled."
  sensitive   = false
}

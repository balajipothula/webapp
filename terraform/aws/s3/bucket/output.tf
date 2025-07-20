# Resource  type : aws_s3_bucket
# Resource  name : generic
# Attribute name : id

output "s3_bucket_id" {
  value       = aws_s3_bucket.generic.id
  description = "Name of the bucket."
  sensitive   = false
}

output "s3_bucket_arn" {
  value       = aws_s3_bucket.generic.arn
  description = "ARN of the bucket."
  sensitive   = false
}

output "s3_bucket_domain_name" {
  value       = aws_s3_bucket.generic.bucket_domain_name
  description = "Bucket domain name."
  sensitive   = false
}

output "s3_bucket_regional_domain_name" {
  value       = aws_s3_bucket.generic.bucket_regional_domain_name
  description = "Region-specific bucket domain name."
  sensitive   = false
}

output "hosted_zone_id" {
  value       = aws_s3_bucket.generic.hosted_zone_id
  description = "Route 53 Hosted Zone ID for the bucket's region."
  sensitive   = false
}

output "region" {
  value       = aws_s3_bucket.generic.region
  description = "AWS region where the bucket resides."
  sensitive   = false
}

output "tags_all" {
  value       = aws_s3_bucket.generic.tags_all
  description = "All tags assigned to the bucket, including inherited tags."
  sensitive   = false
}

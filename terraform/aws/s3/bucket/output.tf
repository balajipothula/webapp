# Resource  type : aws_s3_bucket
# Resource  name : generic
# Attribute name : id
output "id" {
  value       = aws_s3_bucket.generic.id
  description = "The name of the bucket."
  sensitive   = false
}

output "arn" {
  value       = aws_s3_bucket.generic.arn
  description = "The ARN of the bucket."
  sensitive   = false
}

output "bucket_domain_name" {
  value       = aws_s3_bucket.generic.bucket_domain_name
  description = "The bucket domain name."
  sensitive   = false
}

output "bucket_regional_domain_name" {
  value       = aws_s3_bucket.generic.bucket_regional_domain_name
  description = "The bucket region-specific domain name."
  sensitive   = false
}

output "hosted_zone_id" {
  value       = aws_s3_bucket.generic.hosted_zone_id
  description = "The Route 53 Hosted Zone ID for this bucket's region."
  sensitive   = false
}

output "region" {
  value       = aws_s3_bucket.generic.region
  description = "The AWS region this bucket resides in."
  sensitive   = false
}

output "tags_all" {
  value       = aws_s3_bucket.generic.tags_all
  description = "A map of tags assigned to the resource."
  sensitive   = false
}

output "website_endpoint" {
  value       = aws_s3_bucket.generic.website_endpoint
  description = "The website endpoint."
  sensitive   = false
}

output "website_domain" {
  value       = aws_s3_bucket.generic.website_domain
  description = "The domain of the website endpoint."
  sensitive   = false
}

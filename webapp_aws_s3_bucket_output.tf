# Resource  type : module
# Module    name : webapp_aws_s3_bucket
# Attribute name : id
output "webapp_aws_s3_bucket_id" {
  value       = aws_s3_bucket.generic.id
  description = "The name of the bucket."
  sensitive   = false
}

output "webapp_aws_s3_bucket_arn" {
  value       = aws_s3_bucket.generic.arn
  description = "The ARN of the bucket."
  sensitive   = false
}

output "webapp_aws_s3_bucket_bucket_domain_name" {
  value       = aws_s3_bucket.generic.bucket_domain_name
  description = "The bucket domain name."
  sensitive   = false
}

output "webapp_aws_s3_bucket_bucket_regional_domain_name" {
  value       = aws_s3_bucket.generic.bucket_regional_domain_name
  description = "The bucket region-specific domain name."
  sensitive   = false
}

output "webapp_aws_s3_bucket_hosted_zone_id" {
  value       = aws_s3_bucket.generic.hosted_zone_id
  description = "The Route 53 Hosted Zone ID for this bucket's region."
  sensitive   = false
}

output "webapp_aws_s3_bucket_region" {
  value       = aws_s3_bucket.generic.region
  description = "The AWS region this bucket resides in."
  sensitive   = false
}

output "webapp_aws_s3_bucket_tags_all" {
  value       = aws_s3_bucket.generic.tags_all
  description = "A map of tags assigned to the resource."
  sensitive   = false
}

output "webapp_aws_s3_bucket_website_endpoint" {
  value       = aws_s3_bucket.generic.website_endpoint
  description = "The website endpoint."
  sensitive   = false
}

output "webapp_aws_s3_bucket_website_domain" {
  value       = aws_s3_bucket.generic.website_domain
  description = "The domain of the website endpoint."
  sensitive   = false
}

# Resource  type : module
# Module    name : webapp_aws_s3_bucket
# Attribute name : id
output "webapp_aws_s3_bucket_id" {
  value       = module.webapp_aws_s3_bucket.id
  description = "The name of the bucket."
  sensitive   = false
}

output "webapp_aws_s3_bucket_arn" {
  value       = module.webapp_aws_s3_bucket.arn
  description = "The ARN of the bucket."
  sensitive   = false
}

output "webapp_aws_s3_bucket_bucket_domain_name" {
  value       = module.webapp_aws_s3_bucket.bucket_domain_name
  description = "The bucket domain name."
  sensitive   = false
}

output "webapp_aws_s3_bucket_bucket_regional_domain_name" {
  value       = module.webapp_aws_s3_bucket.bucket_regional_domain_name
  description = "The bucket region-specific domain name."
  sensitive   = false
}

output "webapp_aws_s3_bucket_hosted_zone_id" {
  value       = module.webapp_aws_s3_bucket.hosted_zone_id
  description = "The Route 53 Hosted Zone ID for this bucket's region."
  sensitive   = false
}

output "webapp_aws_s3_bucket_region" {
  value       = module.webapp_aws_s3_bucket.region
  description = "The AWS region this bucket resides in."
  sensitive   = false
}

output "webapp_aws_s3_bucket_tags_all" {
  value       = module.webapp_aws_s3_bucket.tags_all
  description = "A map of tags assigned to the resource."
  sensitive   = false
}

output "webapp_aws_s3_bucket_website_endpoint" {
  value       = module.webapp_aws_s3_bucket.website_endpoint
  description = "The website endpoint."
  sensitive   = false
}

output "webapp_aws_s3_bucket_website_domain" {
  value       = module.webapp_aws_s3_bucket.website_domain
  description = "The domain of the website endpoint."
  sensitive   = false
}

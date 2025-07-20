# Resource  type : aws_s3_bucket_policy
# Resource  name : generic
# Attribute name : bucket

output "name" {
  value       = aws_s3_bucket_policy.generic.bucket
  description = "Name of the bucket to which to apply the policy.."
  sensitive   = false
}

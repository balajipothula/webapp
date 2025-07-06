/*
 * Resource  type : exoscale_iam_access_key
 * Resource  name : generic
 * Attribute name : key
 */
output "key" {
  value       = exoscale_iam_access_key.generic.key
  description = "The IAM (Identity and Access Management) access key."
  sensitive   = false
}

output "secret" {
  value       = exoscale_iam_access_key.generic.secret
  description = "The key secret."
  sensitive   = true
}

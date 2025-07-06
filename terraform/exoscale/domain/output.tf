/*
 * Data Source type : exoscale_domain
 * Data Source name : generic
 * Attribute name   : id
 */
output "id" {
  value       = data.exoscale_domain.generic.id
  description = "The DNS domain ID."
  sensitive   = false
}

/*
 * Resource  type : exoscale_domain
 * Resource  name : generic
 * Attribute name : auto_renew
 */
output "auto_renew" {
  value       = exoscale_domain.generic.auto_renew
  description = "Whether the DNS domain has automatic renewal enabled."
  sensitive   = false
}

output "expires_on" {
  value       = exoscale_domain.generic.expires_on
  description = "The domain expiration date, if known."
  sensitive   = false
}

output "state" {
  value       = exoscale_domain.generic.state
  description = "The domain state."
  sensitive   = false
}

output "token" {
  value       = exoscale_domain.generic.token
  description = "A security token that can be used as an alternative way to manage DNS (Domain Name System) domains via the Exoscale API (Application Programming Interface)."
  sensitive   = true
}

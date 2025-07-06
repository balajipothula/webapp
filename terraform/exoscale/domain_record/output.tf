/*
 * Data Source type : exoscale_domain_record
 * Data Source name : generic
 * Attribute name   : records
 *
 * `records` items  : `content`, `prio`, `ttl`
 * `content`        : The domain record content.
 * `prio            : The record priority.
 * `ttl`            : The record TTL.
 */
output "records" {
  value       = data.exoscale_domain_record.generic.records
  description = " The list of matching records."
  sensitive   = false
}

/*
 * Resource  type : exoscale_domain_record
 * Resource  name : generic
 * Attribute name : hostname
 */
output "hostname" {
  value       = exoscale_domain_record.generic.hostname
  description = "The record FQDN (Fully Qualified Domain Name)."
  sensitive   = false
}

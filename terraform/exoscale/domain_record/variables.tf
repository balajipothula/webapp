variable "domain" {
  type        = string
  default     = "generic"
  description = "The `exoscale_domain` name to match."
  validation {
    condition     = var.domain != null
    error_message = "Error: domain value must not null."
  }
  sensitive = false
}

# Data Source type : exoscale_domain_record
# filter block argument.
variable "name" {
  type        = string
  default     = "generic"
  description = "The domain record name to match."
  validation {
    condition     = var.name != null
    error_message = "Error: name value must not null."
  }
  sensitive = false
}

# Data Source type : exoscale_domain_record
# filter block argument.
variable "id" {
  type        = string
  default     = "generic"
  description = "The record ID to match."
  validation {
    condition     = var.id != null
    error_message = "Error: id value must not null."
  }
  sensitive = false
}

# Data Source type : exoscale_domain_record
# filter block argument.
variable "record_type" {
  type        = string
  default     = "generic"
  description = "TThe record type to match."
  validation {
    condition     = var.record_type != null
    error_message = "Error: record_type value must not null."
  }
  sensitive = false
}

# Data Source type : exoscale_domain_record
# filter block argument.
variable "content_regex" {
  type        = string
  default     = "generic"
  description = "A regular expression to match the record content."
  validation {
    condition     = var.content_regex != null
    error_message = "Error: content_regex value must not null."
  }
  sensitive = false
}

# Resource type : exoscale_domain_record
variable "domain" {
  type        = string
  default     = "generic"
  description = "The parent exoscale_domain to attach the record to."
  validation {
    condition     = var.domain != null
    error_message = "Error: domain value must not null."
  }
  sensitive = false
}

# Resource type : exoscale_domain_record
variable "name" {
  type        = string
  default     = ""
  description = "The record name."
  validation {
    condition     = var.name != null
    error_message = "Error: name value must not null."
  }
  sensitive = false
}

# Resource type : exoscale_domain_record
variable "content" {
  type        = string
  default     = ""
  description = "The record value."
  validation {
    condition     = var.content != null
    error_message = "Error: content value must not null."
  }
  sensitive = false
}

# Resource type : exoscale_domain_record
variable "record_type" {
  type        = string
  default     = "A"
  description = "The record type."
  validation {
    condition     = contains(toset(["A", "AAAA", "ALIAS", "CAA", "CNAME", "HINFO", "MX", "NAPTR", "NS", "POOL", "SPF", "SRV", "SSHFP", "TXT", "URL"]), var.record_type)
    error_message = "Error: record_type value must be `A`, `AAAA`, `ALIAS`, `CAA`, `CNAME`, `HINFO`, `MX`, `NAPTR`, `NS`, `POOL`, `SPF`, `SRV`, `SSHFP`, `TXT` or `URL` only."
  }
  sensitive = false
}

# Resource type : exoscale_domain_record
variable "prio" {
  type        = number
  default     = 0
  description = "The record priority."
  validation {
    condition     = 0 <= var.prio
    error_message = "Error: prio value must be `0` or greater."
  }
  sensitive = false
}

# Resource type : exoscale_domain_record
variable "ttl" {
  type        = number
  default     = 3600
  description = "The record TTL (Time-To-Live) in seconds."
  validation {
    condition     = 0 <= var.ttl && var.ttl <= 3600
    error_message = "Error: ttl value must be in between `0` and `3600`."
  }
  sensitive = false
}

# $ exo zone ↵
variable "zone" {
  type        = string
  default     = "de-fra-1"
  description = "The Exoscale Zone name."
  validation {
    condition     = can(regex("^[a-z]+-[a-z]+-[1-9]$", var.zone))
    error_message = "Error: zone must consist of lower case alphabets, hyphens and numbers only."
  }
  validation {
    condition     = lower(var.zone) == var.zone
    error_message = "Error: zone value must be in all lower case."
  }
  sensitive = false
}

variable "nlb_id" {
  type        = string
  default     = null
  description = "The parent exoscale_nlb ID."
  sensitive   = false
}

variable "name" {
  type        = string
  default     = "generic_nlb"
  description = " The NLB (Network Load Balancer) service name."
  validation {
    condition     = var.name != null && length(regexall("[^a-z-a-z-0-9]", var.name)) == 0
    error_message = "Error: name value must not null and must consist of alphabets, hyphens and numbers only."
  }
  sensitive = false
}

variable "instance_pool_id" {
  type        = string
  default     = ""
  description = "The exoscale_instance_pool ID to forward traffic to."
  validation {
    condition     = var.instance_pool_id != null
    error_message = "Error: instance_pool_id value must not null."
  }
  sensitive = false
}

variable "port" {
  type        = number
  default     = 80
  description = "The NLB (Network Load Balancer) service TCP (Transmission Control Protocol) / UDP (User Datagram Protocol) port."
  validation {
    condition     = 0 <= var.port && var.port <= 65535
    error_message = "Error: port value must be in between 0 to 65535."
  }
  sensitive = false
}

variable "target_port" {
  type        = number
  default     = 80
  description = "The TCP (Transmission Control Protocol) / UDP (User Datagram Protocol) port to forward traffic to target instance pool members."
  validation {
    condition     = 0 <= var.target_port && var.target_port <= 65535
    error_message = "Error: target_port value must be in between 0 to 65535."
  }
  sensitive = false
}

variable "description" {
  type        = string
  default     = "Exoscale Network Load Balancer Service."
  description = "A free-form text describing the NLB (Network Load Balancer) service."
  validation {
    condition     = var.description != null
    error_message = "Error: description value must not null."
  }
  sensitive = false
}

variable "protocol" {
  type        = string
  default     = "tcp"
  description = "The protocol."
  validation {
    condition     = contains(toset(["tcp", "udp"]), var.protocol)
    error_message = "Error: protocol value must be either `tcp` or `udp` only."
  }
  sensitive = false
}

variable "strategy" {
  type        = string
  default     = "round-robin"
  description = "The strategy."
  validation {
    condition     = contains(toset(["round-robin", "source-hash"]), var.strategy)
    error_message = "Error: strategy value must be either `round-robin` or `source-hash` only."
  }
  sensitive = false
}
/*
# `healthcheck` configuration block argument.
variable "healthcheck_port" {
  type        = number
  default     = 80
  description = "The healthcheck port."
  validation {
    condition     = 0 <= var.target_port && var.target_port <= 65535
    error_message = "Error: healthcheck_port value must be in between 0 to 65535."
  }
  sensitive = false
}

# `healthcheck` configuration block argument.
variable "interval" {
  type        = number
  default     = 10
  description = "The healthcheck interval in seconds."
  validation {
    condition     = 1 <= var.interval && var.interval <= 300
    error_message = "Error: interval value must be in between 1 to 300."
  }
  sensitive = false
}

# `healthcheck` configuration block argument.
variable "mode" {
  type        = string
  default     = "http"
  description = "The healthcheck mode."
  validation {
    condition     = contains(toset(["tcp", "http", "https"]), var.mode)
    error_message = "Error: mode value must be either `tcp`, `http`  or `https` only."
  }
  sensitive = false
}

# `healthcheck` configuration block argument.
variable "retries" {
  type        = number
  default     = 3
  description = "The healthcheck retries."
  validation {
    condition     = 1 <= var.retries && var.retries <= 5
    error_message = "Error: retries value must be in between 1 to 5."
  }
  sensitive = false
}

# `healthcheck` configuration block argument.
variable "timeout" {
  type        = number
  default     = 5
  description = "The healthcheck timeout in seconds."
  validation {
    condition     = 1 <= var.timeout && var.timeout <= 30
    error_message = "Error: timeout value must be in between 1 to 5."
  }
  sensitive = false
}

# `healthcheck` configuration block argument.
# Note: If `mode` is `https`.
variable "tls_sni" {
  type        = string
  default     = ""
  description = "The healthcheck TLS (Transport Layer Security) SNI (Server Name Indication) server name."
  sensitive   = false
}

# `healthcheck` configuration block argument.
# Note: If `mode` is `https`.
variable "uri" {
  type        = string
  default     = ""
  description = "The healthcheck URI (Uniform Resource Identifier)."
  sensitive   = false
}
*/

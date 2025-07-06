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

variable "description" {
  type        = string
  default     = "Elastic Internet Protocol Description."
  description = "A free-form text describing the EIP (Elastic Internet Protocol)"
  validation {
    condition     = (8 <= length(var.description) && length(var.description) <= 128)
    error_message = "Error: description value must not null."
  }
  sensitive = false
}

variable "address_family" {
  type        = string
  default     = "inet4"
  description = "The EIP (Elastic IP) address family."
  validation {
    condition     = contains(toset(["inet4", "inet6"]), var.address_family)
    error_message = "Error: address_family value must be either `inet4` or `inet6` only."
  }
  sensitive = false
}

# The label `value` should begin with a non-numeric character,
# The label `value` contain only alphanumeric characters and *, +, !, _, ?
# The label `value` length upto 128 characters.
variable "labels" {
  type = map(string)
  default = {
    "AppName"        = "Shadowflight"
    "Division"       = "Digital Health"
    "Developer"      = "Balaji Pothula"
    "DeveloperEmail" = "balaji@significo.com"
    "Manager"        = "Joaquin Avellan"
    "ManagerEmail"   = "joaquin@significo.com"
  }
  description = "A map of key, value labels."
  validation {
    condition     = (1 <= length(var.labels) && length(var.labels) <= 50)
    error_message = "Error: labels at least one or more expected upto 50."
  }
  sensitive = false
}

variable "reverse_dns" {
  type        = string
  default     = null
  description = "Domain name for reverse DNS (Domain Name System) record."
  sensitive   = false
}

# `healthcheck` configuration block variable.
variable "healthcheck_block" {
  type = list(object({
    mode            = string
    port            = number
    uri             = string
    interval        = number
    timeout         = number
    tls_skip_verify = bool
    strikes_ok      = number
    strikes_fail    = number
    tls_sni         = string
  }))
  default     = []
  description = "Healthcheck configuration for managed EIPs (Elastic Internet Protocol)."
  validation {
    condition     = (length(var.healthcheck_block) == 1)
    error_message = "Error: healthcheck_block variable list length must be `1`."
  }
  validation {
    condition     = alltrue([for healthcheck in var.healthcheck_block : contains(toset(["tcp", "http", "https"]), healthcheck.mode)])
    error_message = "Error: mode value must be either `tcp`, `http` or `https` only."
  }
  validation {
    condition     = alltrue([for healthcheck in var.healthcheck_block : (0 <= healthcheck.port && healthcheck.port <= 65535)])
    error_message = "Error: port value must be in between `0` to `65535`."
  }
  validation {
    condition     = alltrue([for healthcheck in var.healthcheck_block : (5 <= healthcheck.interval && healthcheck.interval <= 300)])
    error_message = "Error: interval value must be in between `5` to `300`."
  }
  validation {
    condition     = alltrue([for healthcheck in var.healthcheck_block : (1 <= healthcheck.strikes_fail && healthcheck.strikes_fail <= 20)])
    error_message = "Error: strikes_fail value must be in between `1` to `20`."
  }
  validation {
    condition     = alltrue([for healthcheck in var.healthcheck_block : (1 <= healthcheck.strikes_ok && healthcheck.strikes_ok <= 20)])
    error_message = "Error: strikes_ok value must be in between `1` to `20`."
  }
  validation {
    condition     = alltrue([for healthcheck in var.healthcheck_block : (2 <= healthcheck.timeout && healthcheck.timeout <= 20)])
    error_message = "Error: timeout value must be in between `2` to `20`."
  }
  validation {
    condition     = alltrue([for healthcheck in var.healthcheck_block : contains(toset([true, false]), healthcheck.tls_skip_verify)])
    error_message = "Error: tls_skip_verify value must be either `true` or `false` only."
  }
  sensitive = false
}

/*
# `healthcheck` block attribute.
variable "mode" {
  type        = string
  default     = "http"
  description = "The healthcheck mode."
  validation {
    condition     = contains(toset(["tcp", "http", "https"]), var.mode)
    error_message = "Error: mode value must be either `tcp`, `http` or `https` only."
  }
  sensitive = false
}

# `healthcheck` block attribute.
variable "port" {
  type        = number
  default     = 80
  description = "The healthcheck target port."
  validation {
    condition     = (0 <= var.port && var.port <= 65535)
    error_message = "Error: port value must be in between `0` to `65535`."
  }
  sensitive = false
}

# `healthcheck` block attribute.
variable "uri" {
  type        = string
  default     = "/"
  description = "The healthcheck target URI (Uniform Resource Identifier)."
  sensitive   = false
}

# `healthcheck` block attribute.
variable "interval" {
  type        = number
  default     = 10
  description = "The healthcheck interval."
  validation {
    condition     = (5 <= var.interval && var.interval <= 300)
    error_message = "Error: interval value must be in between `5` to `300`."
  }
  sensitive = false
}

# `healthcheck` block attribute.
variable "strikes_fail" {
  type        = number
  default     = 2
  description = "The number of failed healthcheck attempts before considering the target unhealthy."
  validation {
    condition     = (1 <= var.strikes_fail && var.strikes_fail <= 20)
    error_message = "Error: strikes_fail value must be in between `1` to `20`."
  }
  sensitive = false
}

# `healthcheck` block attribute.
variable "strikes_ok" {
  type        = number
  default     = 3
  description = "The number of successful healthcheck attempts before considering the target healthy."
  validation {
    condition     = (1 <= var.strikes_ok && var.strikes_ok <= 20)
    error_message = "Error: strikes_ok value must be in between `1` to `20`."
  }
  sensitive = false
}

# `healthcheck` block attribute.
variable "timeout" {
  type        = number
  default     = 3
  description = "The number of successful healthcheck attempts before considering the target healthy."
  validation {
    condition     = (2 <= var.timeout && var.timeout <= 20)
    error_message = "Error: timeout value must be in between `2` to `20`."
  }
  sensitive = false
}

# `healthcheck` block attribute.
variable "tls_skip_verify" {
  type        = bool
  default     = false
  description = "Disable TLS (Transport Layer Security) certificate verification for healthcheck in `https` mode."
  validation {
    condition     = contains(toset([true, false]), var.tls_skip_verify)
    error_message = "Error: tls_skip_verify value must be either `true` or `false` only."
  }
  sensitive = false
}

# `healthcheck` block attribute.
variable "tls_sni" {
  type        = string
  default     = null
  description = "The healthcheck server name to present with SNI (Server Name Indication) in https mode."
  sensitive   = false
}
*/

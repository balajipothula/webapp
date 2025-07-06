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

variable "name" {
  type        = string
  default     = "generic_private_network"
  description = "The private network name."
  validation {
    condition     = var.name != null && length(regexall("[^a-z-a-z-0-9]", var.name)) == 0
    error_message = "Error: name value must not null and must consist of alphabets, hyphens and numbers only."
  }
  sensitive = false
}

variable "description" {
  type        = string
  default     = "General Private Network."
  description = "A free-form text describing the network."
  validation {
    condition     = var.description != null
    error_message = "Error: description value must not null."
  }
  sensitive = false
}

variable "start_ip" {
  type        = string
  default     = "10.0.0.10"
  description = "The start IPv4 addresses used by the DHCP (Dynamic Host Configuration Protocol) service for dynamic leases."
  validation {
    condition     = var.start_ip != null
    error_message = "Error: start_ip value must not null."
  }
  sensitive = false
}

variable "end_ip" {
  type        = string
  default     = "10.0.0.252"
  description = "The end IPv4 addresses used by the DHCP (Dynamic Host Configuration Protocol) service for dynamic leases."
  validation {
    condition     = var.end_ip != null
    error_message = "Error: end_ip value must not null."
  }
  sensitive = false
}

variable "netmask" {
  type        = string
  default     = "255.255.255.0"
  description = " The network mask defining the IPv4 network allowed for static leases."
  validation {
    condition     = var.netmask != null
    error_message = "Error: netmask value must not null."
  }
  sensitive = false
}

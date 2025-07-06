/*
 * `exoscale_template`         Data Source variable.
 * `exoscale_compute_instance` Resource    variable.
 */
# $ exo zone ↵
variable "zone" {
  type        = string
  default     = "de-fra-1"
  description = "The Exoscale Zone name."
  validation {
    condition     = can(regex("^[a-z]+-[a-z]+-[1-9]$", var.zone))
    error_message = "Error: zone must start with lower case alphabets, consist of hyphens and numbers only."
  }
  sensitive = false
}

# `exoscale_template` Data Source variable.
# $ exo compute instance-template list ↵
variable "template_name" {
  type        = string
  default     = "Linux Ubuntu 22.04 LTS 64-bit"
  description = "The template name to match."
  sensitive   = false
}

# `exoscale_template` Data Source variable.
# `public`  - Official Exoscale templates.
# `private` - Custom templates private to your organization.
variable "visibility" {
  type        = string
  default     = "public"
  description = "A template category filter."
  validation {
    condition     = contains(toset(["public", "private"]), var.visibility)
    error_message = "Error: visibility value must be either `public` or `private` only."
  }
  sensitive = false
}

/*
# `exoscale_compute_instance` Data Source variable.
variable "anti_affinity_group_ids" {
  type        = set(string)
  default     = null
  description = "The set of attached exoscale_anti_affinity_group IDs."
  sensitive   = false
}
*/

variable "name" {
  type        = string
  default     = "webapp"
  description = "The compute instance name."
  validation {
    condition     = can(regex("^[a-z]+[a-z0-9-.]+[a-z0-9]+$", var.name))
    error_message = "Error: name must start with lower case alphabets, consist hyphens and numbers only."
  }
  sensitive = false
}

# Warning: Updating `disk_size` attribute stops or restarts the instance.
variable "disk_size" {
  type        = number
  default     = 10
  description = "The instance disk size."
  validation {
    condition     = 10 <= var.disk_size
    error_message = "Error: disk_size value must minimum 10GiB or more."
  }
  sensitive = false
}

# $ exo compute instance-template list ↵
variable "template_id" {
  type        = string
  default     = null
  description = "The exoscale_compute_template ID to use when creating the instance."
  validation {
    condition     = (length(var.template_id) == 36)
    error_message = "Error: template_id length must 36."
  }
  validation {
    condition     = can(regex("^[a-f0-9]+-[a-f0-9]+-[a-f0-9]+-[a-f0-9]+-[a-f0-9]+$", var.template_id))
    error_message = "Error: template_id must be a hexadecimal number."
  }
  sensitive = false
}

# $ exo compute instance-type list ↵
# syntax: <family>.<size>, e.g., standard.medium
# Warning: Updating `type` attribute stops or restarts the instance.
variable "type" {
  type        = string
  default     = "standard.micro"
  description = "The instance type."
  validation {
    condition     = can(regex("^[a-z]+\\.[a-z]+$", var.type))
    error_message = "Error: type must start with lower case alphabets and consist `.` only."
  }
  sensitive = false
}

variable "deploy_target_id" {
  type        = string
  default     = null
  description = "A deploy target ID."
  sensitive   = false
}

variable "ipv6" {
  type        = bool
  default     = false
  description = "Enable IPv6 on the instance."
  validation {
    condition     = contains(toset([true, false]), var.ipv6)
    error_message = "Error: ipv6 value must be either `true` or `false` only."
  }
  sensitive = false
}

/*
 * The label `value` should begin with a non-numeric character,
 * The label `value` contain only alphanumeric characters and *, +, !, _, ?
 * The label `value` length upto 128 characters.
 */
variable "labels" {
  type = map(string)
  default = {
    "AppName"        = "WebApp"
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

variable "ssh_key" {
  type        = string
  default     = "generic"
  description = "The `exoscale_ssh_key` name to authorize in the instance."
  validation {
    condition     = can(regex("^[a-z]+[a-z0-9-_@.]+[a-z0-9]+$", var.ssh_key))
    error_message = "Error: ssh_key must start with lower case alphabets, consist numbers, hyphen and underscore only."
  }
  sensitive = false
}

variable "state" {
  type        = string
  default     = "running"
  description = "The instance state."
  validation {
    condition     = contains(toset(["running", "stopped"]), var.state)
    error_message = "Error: state value must be either `running` or `stopped` only."
  }
  sensitive = false
}

# EOT (End of Transmission)
variable "user_data" {
  type        = string
  default     = <<-EOT
    #!/usr/bin/bash
    apt -y update
    apt -y upgrade
    apt -y dist-upgrade
  EOT
  description = "cloud-init configuration."
  validation {
    condition     = (null != var.user_data)
    error_message = "Error: user_data value must not null"
  }
  sensitive = false
}

variable "anti_affinity_group_ids" {
  type        = set(string)
  default     = null
  description = "A list of exoscale_anti_affinity_group (IDs) to attach to the instance."
  sensitive   = false
}

variable "elastic_ip_ids" {
  type        = set(string)
  default     = null
  description = "A list of exoscale_elastic_ip (IDs) to attach to the instance."
  sensitive   = false
}

variable "private" {
  type        = bool
  default     = false
  description = "Whether the instance is private."
  validation {
    condition     = contains(toset([true, false]), var.private)
    error_message = "Error: private value must be either `true` or `false` only."
  }
  sensitive = false
}

variable "reverse_dns" {
  type        = string
  default     = null
  description = "Domain name for reverse DNS (Domain Name System) record."
  sensitive   = false
}

variable "security_group_ids" {
  type        = set(string)
  default     = []
  description = "A list of exoscale_security_group (IDs) to attach to the instance."
  sensitive   = false
}

# `network_interface` configuration block variable.
variable "network_interface_block" {
  type = list(object({
    network_id = string
    ip_address = string
  }))
  default     = []
  description = "Private network interfaces."
  validation {
    condition     = (length(var.network_interface_block) == 1)
    error_message = "Error: network_interface_block variable list length must be `1`."
  }
  validation {
    condition     = alltrue([for network_interface in var.network_interface_block : (length(network_interface.network_id) == 36)])
    error_message = "Error: network_id length must be in between 4 to 64 characters."
  }
  validation {
    condition     = alltrue([for network_interface in var.network_interface_block : can(regex("^[a-f0-9]+-[a-f0-9]+-[a-f0-9]+-[a-f0-9]+-[a-f0-9]+$", network_interface.network_id))])
    error_message = "Error: network_id must be a hexadecimal number."
  }
  sensitive = false
}

/*
# `network_interface` configuration block argument.
variable "network_id" {
  type        = string
  default     = null
  description = "The `exoscale_private_network` (ID) to attach to the instance."
  validation {
    condition     = (length(var.network_id) == 36)
    error_message = "Error: network_id length must 36."
  }
  validation {
    condition     = can(regex("^[a-f0-9]+-[a-f0-9]+-[a-f0-9]+-[a-f0-9]+-[a-f0-9]+$", var.network_id))
    error_message = "Error: network_id must be a hexadecimal number."
  }
  sensitive = false
}

# `network_interface` configuration block argument.
variable "ip_address" {
  type        = string
  default     = null
  description = "The IPv4 address to request as static DHCP lease if the network interface is attached to a managed private network."
  sensitive   = false
}
*/

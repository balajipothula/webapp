variable "template_name" {
  type        = string
  default     = "Linux Ubuntu 22.04 LTS 64-bit"
  description = "The template name to match."
  validation {
    condition     = var.template_name != null
    error_message = "Error: template_name value must not null."
  }
  sensitive = false
}

# `public`  - Official Exoscale templates.
# `private` - Custom templates private to your organization.
variable "visibility" {
  type        = string
  default     = "public"
  description = "A template category filter."
  validation {
    condition     = contains(toset(["public", "private"]), var.visibility)
    error_message = "Error: visibility value must be either public or private only."
  }
  sensitive = false
}

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
  default     = "generic_pool"
  description = "The instance pool name."
  validation {
    condition     = var.name != null && length(regexall("[^a-z-a-z-0-9]", var.name)) == 0
    error_message = "Error: name value must not null and must consist of alphabets, hyphens and numbers only."
  }
  sensitive = false
}

variable "template_id" {
  type        = string
  default     = null
  description = "The exoscale_compute_template ID to use when creating the instance."
  sensitive   = false
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

# $ exo compute instance-type list ↵
# syntax: <family>.<size>, e.g., standard.medium
# Warning: Updating `type` attribute stops or restarts the instance.
variable "instance_type" {
  type        = string
  default     = "standard.micro"
  description = "The managed compute instances type."
  validation {
    condition     = var.instance_type != null
    error_message = "Error: instance_type value must not null."
  }
  sensitive = false
}

variable "size" {
  type        = number
  default     = 1
  description = "The number of managed instances."
  validation {
    condition     = 0 < var.size && var.size < 4
    error_message = "Error: size value must in between `1` and `3`."
  }
  sensitive = false
}

variable "description" {
  type        = string
  default     = "Exoscale instance pool."
  description = "A free-form text describing the pool."
  validation {
    condition     = var.description != null
    error_message = "Error: description value must not null."
  }
  sensitive = false
}

variable "deploy_target_id" {
  type        = string
  default     = ""
  description = "A deploy target ID."
  validation {
    condition     = var.deploy_target_id != null
    error_message = "Error: deploy_target_id value must not null."
  }
  sensitive = false
}

# Warning: Updating `disk_size` attribute stops or restarts the instance.
variable "disk_size" {
  type        = number
  default     = 10
  description = "The managed instances disk size in GiB."
  validation {
    condition     = 10 <= var.disk_size
    error_message = "Error: disk_size value must minimum 10GiB or more."
  }
  sensitive = false
}

variable "instance_prefix" {
  type        = string
  default     = "pool"
  description = "The string used to prefix managed instances name."
  validation {
    condition     = var.instance_prefix != null
    error_message = "Error: instance_prefix value must not null."
  }
  sensitive = false
}

variable "ipv6" {
  type        = bool
  default     = false
  description = "Enable IPv6 on managed instances."
  validation {
    condition     = contains(toset([true, false]), var.ipv6)
    error_message = "Error: ipv6 value must be either `true` or `false` only."
  }
  sensitive = false
}

variable "key_pair" {
  type        = string
  default     = "generic"
  description = "The exoscale_ssh_key name to authorize in the managed instances."
  validation {
    condition     = var.key_pair != null
    error_message = "Error: key_pair value must not null."
  }
  sensitive = false
}

# The label `value` should begin with a non-numeric character,
# The label `value` contain only alphanumeric characters and *, +, !, _, ?
# The label `value` length upto 128 characters.
variable "labels" {
  type = map(string)
  default = {
    "AppName"           = "Shadow Flight"
    "Division"          = "Digital Health"
    "Developer"         = "Balaji Pothula"
    "DeveloperEmail"    = "balaji@significo.com"
    "Manager"           = "Joaquin Avellan"
    "ManagerEmail"      = "joaquin@significo.com"
    "ServiceOwner"      = "Caroline Nieto"
    "ServiceOwnerEmail" = "caroline@significo.com"
    "ProductOwner"      = "Chris Koha"
    "ProductOwnerEmail" = "chris@significo.com"
  }
  description = "A map of key, value labels."
  validation {
    condition     = var.labels != null && 0 < length(var.labels) && length(var.labels) < 51
    error_message = "Error: labels at least one or more expected upto 50."
  }
  sensitive = false
}

variable "user_data" {
  type        = string
  default     = ""
  description = "cloud-init configuration to apply to the managed instances."
  validation {
    condition     = var.user_data != null
    error_message = "Error: user_data value must not null."
  }
  sensitive = false
}

variable "affinity_group_ids" {
  type        = list(string)
  default     = []
  description = "A list of exoscale_anti_affinity_group."
  sensitive   = false
}

variable "elastic_ip_ids" {
  type        = list(string)
  default     = []
  description = "A list of exoscale_elastic_ip IDs."
  sensitive   = false
}

variable "network_ids" {
  type        = list(string)
  default     = []
  description = "A list of exoscale_private_network IDs."
  sensitive   = false
}

variable "security_group_ids" {
  type        = list(string)
  default     = []
  description = "A list of exoscale_security_group IDs."
  sensitive   = false
}

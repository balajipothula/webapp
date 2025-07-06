variable "cluster_id" {
  type        = string
  default     = ""
  description = "The parent `exoscale_sks_cluster` ID."
  validation {
    condition     = var.cluster_id != null
    error_message = "Error: cluster_id value must not null."
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
  default     = "webapp"
  description = "The SKS (Scalable Kubernetes Service) node pool name."
  validation {
    condition     = var.name != null && length(regexall("[^a-z-a-z-0-9]", var.name)) == 0
    error_message = "Error: name value must not null and must consist of alphabets, hyphens and numbers only."
  }
  sensitive = false
}

# $ exo compute instance-type list ↵
# syntax: <family>.<size>, e.g., standard.medium
# Warning: Updating `instance_type` attribute stops or restarts the instance.
variable "instance_type" {
  type        = string
  default     = "standard.micro"
  description = "The managed compute instances type."
  validation {
    condition     = "standard.micro" != var.instance_type && "standard.tiny" != var.instance_type
    error_message = "Error: type value must not null."
  }
  sensitive = false
}

variable "size" {
  type        = number
  default     = 1
  description = "The managed instances disk size."
  validation {
    condition     = 0 <= var.size && var.size <= 3
    error_message = "Error: size value must in between 0 to 3."
  }
  sensitive = false
}

variable "description" {
  type        = string
  default     = "Scalable Kubernetes Service  node pool description."
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

variable "instance_prefix" {
  type        = string
  default     = "pool"
  description = "The string used to prefix the managed instances name."
  validation {
    condition     = var.instance_prefix != null
    error_message = "Error: instance_prefix value must not null."
  }
  sensitive = false
}

variable "disk_size" {
  type        = number
  default     = 20
  description = "The managed instances disk size in GB (Giga Byte)."
  validation {
    condition     = 20 <= var.disk_size && var.disk_size <= 50000
    error_message = "Error: disk_size value must be in between 20GB and 50000GB (50TB [Tera Byte])."
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

variable "taints" {
  type        = map(string)
  default     = {}
  description = "A map of key, value Kubernetes taints."
  sensitive   = false
}

variable "anti_affinity_group_ids" {
  type        = set(string)
  default     = []
  description = "A list of exoscale_anti_affinity_group IDs to be attached to the managed instances."
  sensitive   = false
}

variable "private_network_ids" {
  type        = set(string)
  default     = []
  description = "A list of exoscale_private_network IDs to be attached to the managed instances."
  sensitive   = false
}

variable "security_group_ids" {
  type        = set(string)
  default     = []
  description = "A list of exoscale_security_group IDs to be attached to the managed instances."
  sensitive   = false
}

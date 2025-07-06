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
  description = "The SKS (Scalable Kubernetes Service) cluster name."
  validation {
    condition     = var.name != null && length(regexall("[^a-z-a-z-0-9]", var.name)) == 0
    error_message = "Error: name value must not null and must consist of alphabets, hyphens and numbers only."
  }
  sensitive = false
}

variable "description" {
  type        = string
  default     = "Scalable Kubernetes Service description."
  description = "A free-form text describing the cluster."
  validation {
    condition     = var.description != null
    error_message = "Error: description value must not null."
  }
  sensitive = false
}

variable "auto_upgrade" {
  type        = bool
  default     = false
  description = "Enable automatic upgrading of the control plane version."
  validation {
    condition     = contains(toset([true, false]), var.auto_upgrade)
    error_message = "Error: auto_upgrade value must be either `true` or `false` only."
  }
  sensitive = false
}

variable "cni" {
  type        = string
  default     = "calico"
  description = "The service level of the control plane."
  validation {
    condition     = contains(toset(["calico", "cilium"]), var.cni)
    error_message = "Error: cni value must be either `calico` or `cilium` only."
  }
  sensitive = false
}

variable "exoscale_ccm" {
  type        = bool
  default     = true
  description = "Deploy the Exoscale CCM (Cloud Controller Manager) in the control plane."
  validation {
    condition     = contains(toset([true, false]), var.exoscale_ccm)
    error_message = "Error: exoscale_ccm value must be either `true` or `false` only."
  }
  sensitive = false
}

variable "metrics_server" {
  type        = bool
  default     = true
  description = "Deploy the Kubernetes Metrics Server in the control plane."
  validation {
    condition     = contains(toset([true, false]), var.metrics_server)
    error_message = "Error: metrics_server value must be either `true` or `false` only."
  }
  sensitive = false
}

variable "service_level" {
  type        = string
  default     = "starter"
  description = "The service level of the control plane."
  validation {
    condition     = contains(toset(["pro", "starter"]), var.service_level)
    error_message = "Error: service_level value must be either `pro` or `starter` only."
  }
  sensitive = false
}

# $ exo compute sks versions ↵
variable "sks_version" {
  type        = string
  default     = "1.26.3"
  description = "The version of the control plane."
  validation {
    condition     = contains(toset(["1.24.13", "1.25.9", "1.26.4"]), var.sks_version)
    error_message = "Error: service_level value must be either `1.24.13`, `1.25.9` or `1.26.4` only."
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

# `oidc` configuration block argument.
variable "client_id" {
  type        = string
  default     = ""
  description = "The OpenID client ID."
  sensitive   = false
}

# `oidc` configuration block argument.
variable "issuer_url" {
  type        = string
  default     = ""
  description = "The OpenID provider URL (Uniform Resource Locator)."
  sensitive   = false
}

# `oidc` configuration block argument.
variable "groups_claim" {
  type        = string
  default     = ""
  description = "An OpenID JWT (JSON [JavaScript Object Notation] Web Token) claim to use as the user's group."
  sensitive   = false
}

# `oidc` configuration block argument.
variable "groups_prefix" {
  type        = string
  default     = ""
  description = "An OpenID prefix prepended to group claims."
  sensitive   = false
}

# `oidc` configuration block argument.
variable "required_claim" {
  type        = map(string)
  default     = {}
  description = "A map of key, value pairs that describes a required claim in the OpenID Token."
  sensitive   = false
}

# `oidc` configuration block argument.
variable "username_claim" {
  type        = string
  default     = ""
  description = "An OpenID JWT (JSON [JavaScript Object Notation] Web Token) claim to use as the user name."
  sensitive   = false
}

# `oidc` configuration block argument.
variable "username_prefix" {
  type        = string
  default     = ""
  description = "An OpenID prefix prepended to username claims."
  sensitive   = false
}

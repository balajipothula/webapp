variable "cluster_id" {
  type        = string
  default     = null
  description = "The parent `exoscale_sks_cluster` ID."
  sensitive   = false
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

variable "user" {
  type        = string
  default     = "kubernetes-admin"
  description = "Username in the generated kubeconfig."
  validation {
    condition     = var.user != null
    error_message = "Error: user value must not null."
  }
  sensitive = false
}

variable "groups" {
  type        = set(string)
  default     = ["system:masters"]
  description = "Group names in the generated Kubeconfig. The certificate present in the Kubeconfig will have these roles set in the Organization field."
  validation {
    condition     = var.groups != null
    error_message = "Error: groups value must not null."
  }
  sensitive = false
}

variable "ttl_seconds" {
  type        = number
  default     = 2592000
  description = "The Time-to-Live of the Kubeconfig in seconds, after which it will expire or become invalid."
  validation {
    condition     = 1 <= var.ttl_seconds && var.ttl_seconds <= 2592000
    error_message = "Error: ttl_seconds value must in between `1` and `2592000` (30 days)."
  }
  sensitive = false
}

variable "early_renewal_seconds" {
  type        = number
  default     = 0
  description = "Kubeconfig to have expired the given number of seconds before its actual CA certificate or client."
  validation {
    condition     = 0 <= var.early_renewal_seconds
    error_message = "Error: early_renewal_seconds value must be 0 or more."
  }
  sensitive = false
}

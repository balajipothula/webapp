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
  default     = "generic_nlb"
  description = "The NLB (Network Load Balancer) name."
  validation {
    condition     = var.name != null && length(regexall("[^a-z-a-z-0-9]", var.name)) == 0
    error_message = "Error: name value must not null and must consist of alphabets, hyphens and numbers only."
  }
  sensitive = false
}

variable "description" {
  type        = string
  default     = "Exoscale Network Load Balancer."
  description = "A free-form text describing the NLB (Network Load Balancer)."
  validation {
    condition     = var.description != null
    error_message = "Error: description value must not null."
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

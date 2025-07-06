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
  default     = "generic"
  description = "The name of the database service."
  validation {
    condition     = var.name != null
    error_message = "Error: name value must not null and must consist of alphabets, hyphens and numbers only."
  }
  sensitive = false
}

variable "type" {
  type        = string
  default     = "redis"
  description = "The type of the database service."
  validation {
    condition     = ("redis" == var.type)
    error_message = "Error: type value must be `redis` only."
  }
  sensitive = false
}

# $ exo dbaas type show pg --plans ↵
variable "plan" {
  type        = string
  default     = "startup-4"
  description = "The plan of the database service."
  validation {
    condition     = contains(toset(["hobbyist-2", "startup-4", "business-4", "premium-4", "startup-8", "business-8", "premium-8", "startup-16", "business-16", "premium-16", "startup-32", "business-32", "premium-32", "startup-64", "business-64", "premium-64", "startup-128", "business-128", "premium-128", "startup-225", "business-225", "premium-225"]), var.plan)
    error_message = "Error: plan value must be `hobbyist-2`, `startup-4`, `business-4`, `premium-4`, `startup-8`, `business-8`, `premium-8`, `startup-16`, `business-16`, `premium-16`, `startup-32`, `business-32`, `premium-32`, `startup-64`, `business-64`, `premium-64`, `startup-128`, `business-128`, `premium-128`, `startup-225`, `business-225` or `premium-225` only."
  }
  sensitive = false
}

variable "maintenance_dow" {
  type        = string
  default     = "sunday"
  description = "The day of week to perform the automated database service maintenance."
  validation {
    condition     = contains(toset(["never", "sunday", "monday", "tuesday", "wednesday", "thursday", "friday", "saturday"]), var.maintenance_dow)
    error_message = "Error: maintenance_dow value must be `never`, `sunday`, `monday`, `tuesday`, `wednesday`, `thursday`, `friday` or `saturday` only."
  }
  sensitive = false
}

variable "maintenance_time" {
  type        = string
  default     = "02:00:00"
  description = "The time of day to perform the automated database service maintenance."
  sensitive   = false
}

variable "termination_protection" {
  type        = bool
  default     = true
  description = "The database service protection boolean flag against termination / power-off."
  validation {
    condition     = contains(toset([true, false]), var.termination_protection)
    error_message = "Error: termination_protection value must be `true` or `false` only."
  }
  sensitive = false
}

# `redis` configuration block variable.
variable "redis_block" {
  type = list(object({
    ip_filter      = set(string)
    redis_settings = string
  }))
  default     = []
  description = "redis database service type specific arguments."
  sensitive   = false
}

/*
# `redis` configuration block argument.
variable "ip_filter" {
  type        = set(string)
  default     = null
  description = "A list of CIDR blocks to allow incoming connections from."
  sensitive   = false
}

# `redis` configuration block argument.
# $ exo dbaas type show redis --settings=redis ↵
variable "redis_settings" {
  type        = string
  default     = null
  description = "REDIS (REmote DIctionary Server) configuration settings in JSON (JavaScript Object Notation) format."
  sensitive   = false
}
*/

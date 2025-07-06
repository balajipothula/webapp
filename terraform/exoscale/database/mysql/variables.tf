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
  default     = "mysql"
  description = "The type of the database service."
  validation {
    condition     = ("mysql" == var.type)
    error_message = "Error: type value must be `mysql` only."
  }
  sensitive = false
}

# $ exo dbaas type show pg --plans ↵
variable "plan" {
  type        = string
  default     = "hobbyist-2"
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

# `mysql` configuration block variable.
variable "mysql_block" {
  type = list(object({
    admin_username  = string
    admin_password  = string
    backup_schedule = string
    ip_filter       = set(string)
    mysql_settings  = string
    mysql_version   = string
  }))
  default     = []
  description = "mysql database service type specific arguments."
  validation {
    condition     = (length(var.mysql_block) == 1)
    error_message = "Error: mysql_block variable list length must be `1`."
  }
  validation {
    condition     = alltrue([for mysql in var.mysql_block : (4 < length(mysql.admin_username) && length(mysql.admin_username) < 64)])
    error_message = "Error: admin_username length must be in between 4 to 64 characters."
  }
  validation {
    condition     = alltrue([for mysql in var.mysql_block : can(regex("^[a-z]+[a-z0-9_]+[a-z0-9]+$", mysql.admin_username))])
    error_message = "Error: admin_username length must be in between 4 to 64 characters."
  }
  validation {
    condition     = alltrue([for mysql in var.mysql_block : (8 <= length(mysql.admin_password) && length(mysql.admin_password) <= 256)])
    error_message = "Error: admin_password length must be in between 8 to 256 characters."
  }
  validation {
    condition     = alltrue([for mysql in var.mysql_block : can(regex("^[a-zA-Z0-9-_]+$", mysql.admin_password))])
    error_message = "Error: admin_password consist only lower case letters, upper case letters, digits,   ."
  }
  validation {
    condition     = alltrue([for mysql in var.mysql_block : can(regex("^([01]?[0-9]|2[0-3]):[0-5][0-9]$", mysql.backup_schedule))])
    error_message = "Error: backup_schedule format should be HH:MM."
  }
  validation {
    condition     = alltrue([for mysql in var.mysql_block : contains(toset(["8"]), mysql.mysql_version)])
    error_message = "Error: version value must be `8` only."
  }
  sensitive = false
}

/*
# `mysql` configuration block argument.
variable "admin_username" {
  type        = string
  default     = "significo"
  description = "A custom administrator account username."
  validation {
    condition     = (4 < length(var.admin_username) && length(var.admin_username) < 64)
    error_message = "Error: admin_username length must be in between 4 to 64 characters."
  }
  validation {
    condition     = can(regex("^[a-z]+[a-z0-9_]+[a-z0-9]+$", var.admin_username))
    error_message = "Error: admin_username value must start with lower case alphabets, consist only numbers, underscore and end with lower case alphabets or numbers."
  }
  sensitive = true
}

# `mysql` configuration block argument.
variable "admin_password" {
  type        = string
  default     = "Significo_2023"
  description = "A custom administrator account password."
  validation {
    condition     = (8 <= length(var.admin_password) && length(var.admin_password) <= 256)
    error_message = "Error: admin_password length must be in between 8 to 100 characters."
  }
  validation {
    condition     = can(regex("^[a-zA-Z0-9-_]+$", var.admin_password))
    error_message = "Error: admin_password consist of lower alphabets, upper alphabets, digits, hyphen and underscore only."
  }
  sensitive = true
}

# `mysql` configuration block argument.
variable "backup_schedule" {
  type        = string
  default     = "01:00"
  description = "The automated backup schedule."
  validation {
    condition     = can(regex("^([01]?[0-9]|2[0-3]):[0-5][0-9]$", var.backup_schedule))
    error_message = "Error: backup_schedule format should be HH:MM."
  }
  sensitive = false
}

# `mysql` configuration block argument.
variable "ip_filter" {
  type        = set(string)
  default     = null
  description = "A list of CIDR blocks to allow incoming connections from."
  sensitive   = false
}

# `mysql` configuration block argument.
# $ exo dbaas type show mysql --settings=mysql ↵
variable "mysql_settings" {
  type        = string
  default     = <<-EOT
    "{ 
      \"connect_timeout\": 3600,
      \"sql_mode\": \"ANSI,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION,NO_ZERO_DATE,NO_ZERO_IN_DATE,STRICT_ALL_TABLES\",
      \"sql_require_primary_key\": true
    }"
  EOT
  description = "MySQL configuration settings in JSON (JavaScript Object Notation) format."
  validation {
    condition     = (null != var.mysql_settings)
    error_message = "Error: mysql_settings value must not null."
  }
  sensitive = false
}

# `mysql` configuration block argument.
# $ exo dbaas type show mysql ↵
variable "mysql_version" {
  type        = string
  default     = 8
  description = "MySQL major version."
  validation {
    condition     = contains(toset(["8"]), var.mysql_version)
    error_message = "Error: mysql_version value must be `8` only."
  }
  sensitive = false
}
*/

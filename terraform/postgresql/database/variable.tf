variable "name" {
  type        = string
  default     = "postgres"
  description = "The name of the database."
  validation {
    condition     = var.name != null && 0 < length(var.name) && length(var.name) < 64
    error_message = "Error: name (database name) length must be in between 1 and 63 only."
  }
  sensitive = false
}

variable "owner" {
  type        = string
  default     = "DEFAULT"
  description = "The role name of the user who will own the database."
  validation {
    condition     = var.owner != null
    error_message = "Error: owner must not null."
  }
  sensitive = false
}

variable "tablespace_name" {
  type        = string
  default     = "DEFAULT"
  description = "The name of the tablespace that will be associated with the database."
  validation {
    condition     = var.tablespace_name != null
    error_message = "Error: tablespace_name must not null."
  }
  sensitive = false
}

variable "connection_limit" {
  type        = number
  default     = -1
  description = "How many concurrent connections can be established to the database."
  validation {
    condition     = -1 <= var.connection_limit && var.connection_limit <= 100
    error_message = "Error: disk_size value must minimum 10GiB or more."
  }
  sensitive = false
}

variable "allow_connections" {
  type        = bool
  default     = true
  description = "Allow database connections or not."
  validation {
    condition     = contains(toset([true, false]), var.allow_connections)
    error_message = "Error: allow_connections value must be either `true` or `false` only."
  }
  sensitive = false
}

variable "is_template" {
  type        = bool
  default     = true
  description = "Clone database by any user with CREATEDB or not."
  validation {
    condition     = contains(toset([true, false]), var.is_template)
    error_message = "Error: is_template value must be either `true` or `false` only."
  }
  sensitive = false
}

variable "template" {
  type        = string
  default     = "template0"
  description = "The name of the template database from which to create the database."
  validation {
    condition     = var.template != null
    error_message = "Error: template must not null."
  }
  sensitive = false
}

variable "encoding" {
  type        = string
  default     = "UTF8"
  description = "Character set encoding to use in the database."
  validation {
    condition     = contains(toset(["UTF8", "SQL_ASCII"]), var.encoding)
    error_message = "Error: encoding value must be either `UTF8` or `SQL_ASCII` only."
  }
  sensitive = false
}

variable "lc_collate" {
  type        = string
  default     = "DEFAULT"
  description = "Collation order to use in the database."
  validation {
    condition     = var.lc_collate != null
    error_message = "Error: lc_collate must not null."
  }
  sensitive = false
}

variable "lc_ctype" {
  type        = string
  default     = "DEFAULT"
  description = "Character classification to use in the database."
  validation {
    condition     = var.lc_ctype != null
    error_message = "Error: lc_ctype must not null."
  }
  sensitive = false
}

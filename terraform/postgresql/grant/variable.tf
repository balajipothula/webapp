variable "role" {
  type        = string
  default     = "public"
  description = "The name of the role to grant privileges."
  validation {
    condition     = var.role != null
    error_message = "Error: role must not null."
  }
  sensitive = false
}

variable "database" {
  type        = string
  default     = "postgres_db"
  description = "The database to grant privileges on for this role."
  validation {
    condition     = 0 < length(var.database) && length(var.database) < 64
    error_message = "Error: database name length must be in between 1 and 63 only."
  }
  sensitive = false
}

variable "schema" {
  type        = string
  default     = "public"
  description = "The database schema to grant privileges on for this role."
  validation {
    condition     = 0 < length(var.schema) && length(var.schema) < 64
    error_message = "Error: schema name length must be in between 1 and 63 only."
  }
  sensitive = false
}

variable "object_type" {
  type        = string
  default     = "table"
  description = "The PostgreSQL object type to grant the privileges."
  validation {
    condition     = contains(toset(["database", "schema", "table", "column", "sequence", "function", "procedure", "routine", "foreign_data_wrapper", "foreign_server"]), var.object_type)
    error_message = "Error: object_type value must be `database`, `schema`, `table`, `column`, `sequence`, `function`, `procedure`, `routine`, `foreign_data_wrapper` or `foreign_server` only."
  }
  sensitive = false
}

# List of privileges:
# SELECT, INSERT, UPDATE, DELETE, TRUNCATE, REFERENCES, TRIGGER, CREATE, CONNECT, TEMPORARY, EXECUTE, USAGE
variable "privileges" {
  type        = set(string)
  default     = toset(["CREATE", "INSERT", "SELECT", "UPDATE", "DELETE"])
  description = "The list of privileges to grant."
  sensitive   = false
}

variable "objects" {
  type        = set(string)
  default     = [] # ["abc_table", "xyz_table"]
  description = "The objects upon which to grant the privileges."
  sensitive = false
}

# Note: Only applicable, if `object_type` is `column`.
variable "columns" {
  type        = set(string)
  default     = [] # ["column_1", "column_2"]
  description = "The columns upon which to grant the privileges."
  sensitive = false
}

variable "with_grant_option" {
  type        = bool
  default     = false
  description = "Whether the recipient of these privileges can grant the same privileges to others."
  validation {
    condition     = contains(toset([true, false]), var.with_grant_option)
    error_message = "Error: with_grant_option value must be either `true` or `false` only."
  }
  sensitive = false
}

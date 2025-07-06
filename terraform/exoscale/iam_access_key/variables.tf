variable "name" {
  type        = string
  default     = "generic"
  description = "The IAM (Identity and Access Management) access key name."
  validation {
    condition     = var.name != null
    error_message = "Error: name value must not null."
  }
  sensitive = false
}

# $ exo iam access-key list-operations ↵
# Pick values from `OPERATIONS` column.
variable "operations" {
  type        = set(string)
  default     = []
  description = "A list of API operations to restrict the key."
  sensitive   = false
}

# syntax: <domain>/<type>:<name>
# e.g. sos/bucket:shadowflight-bucket
variable "resources" {
  type        = set(string)
  default     = []
  description = "A list of API resources to restrict the key."
  sensitive   = false
}

# $ exo iam access-key list-operations ↵
# Pick values from `TAG` column.
variable "tags" {
  type        = set(string)
  default     = []
  description = "A list of tags to restrict the key to."
  sensitive   = false
}

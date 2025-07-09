variable "name" {
  type        = string
  default     = "generic"
  description = "Name of the security group."
  sensitive = false
}

variable "description" {
  type        = string
  default     = "AWS Security Group."
  description = "Security group description."
  validation {
    condition     = var.description != null
    error_message = "Error: description value must not null."
  }
  sensitive = false
}

variable "egress_rules" {
  type = list(object({
    from_port        = number
    to_port          = number
    protocol         = string
    cidr_blocks      = optional(list(string)) # List of CIDR blocks.
    description      = optional(string)       # Description of this ingress rule.
    ipv6_cidr_blocks = optional(list(string)) # List of IPv6 CIDR blocks.
    prefix_list_ids  = optional(list(string)) # List of Prefix List IDs.
    security_groups  = optional(list(string)) # List of security groups.
    self             = optional(bool)         # Whether the security group itself will be added as a source to this ingress rule.
  }))
  default = []
  description = "Configuration block for egress rules."
  sensitive = false
}

variable "ingress_rules" {
  type = list(object({
    from_port        = number
    to_port          = number
    protocol         = string
    cidr_blocks      = optional(list(string)) # List of CIDR blocks.
    description      = optional(string)       # Description of this ingress rule.
    ipv6_cidr_blocks = optional(list(string)) # List of IPv6 CIDR blocks.
    prefix_list_ids  = optional(list(string)) # List of Prefix List IDs.
    security_groups  = optional(list(string)) # List of security groups.
    self             = optional(bool)         # Whether the security group itself will be added as a source to this ingress rule.
  }))
  default = []
  description = "Configuration block for ingress rules."
  sensitive = false
}

variable "name_prefix" {
  type        = string
  default     = "generic_prefix"
  description = "Creates a unique name beginning with the specified prefix."
  sensitive = false
}

variable "revoke_rules_on_delete" {
  type        = bool
  default     = false
  description = "Instruct Terraform to revoke all of the Security Groups attached ingress and egress rules before deleting the rule itself. "
  validation {
    condition     = var.revoke_rules_on_delete != null && contains(tolist([true, false]), var.revoke_rules_on_delete)
    error_message = "Error: revoke_rules_on_delete value must not null and revoke_rules_on_delete value either true or false only."
  }
  sensitive = false
}

variable "tags" {
  type = map(string)
  default = {
    "AppName"        = "WebAppFastAPI"
    "Division"       = "Platform"
    "DeveloperName"  = "Balaji Pothula"
    "DeveloperEmail" = "balan.pothula@gmail.com"
  }
  description = "Map of tags to assign to the Security Group." 
  validation {
    condition     = var.tags != null && 0 < length(var.tags) && length(var.tags) < 51
    error_message = "Error: tags at least one or more expected upto 50."
  }
  sensitive = false
}

variable "default_tags" {
  type = map(string)
  default = {
    "DeveloperName"  = "Balaji Pothula"
    "DeveloperEmail" = "balan.pothula@gmail.com"
  }
  description = "Map of default_tags to assign to the Security Group." 
  validation {
    condition     = var.default_tags != null && 0 < length(var.default_tags) && length(var.default_tags) < 51
    error_message = "Error: default_tags at least one or more expected upto 50."
  }
  sensitive = false
}

variable "vpc_id" {
  type        = string
  default     = null
  description = "VPC ID."
  sensitive = false
}

variable "security_group_id" {
  type        = string
  default     = "generic"
  description = "The parent exoscale_security_group ID."
  validation {
    condition     = var.security_group_id != null
    error_message = "Error: security_group_id value must not null."
  }
  sensitive = false
}

variable "type" {
  type        = string
  default     = "INGRESS"
  description = "The traffic direction to match."
  validation {
    condition     = contains(toset(["INGRESS", "EGRESS"]), var.type)
    error_message = "Error: type value must be either INGRESS or EGRESS only."
  }
  sensitive = false
}

variable "protocol" {
  type        = string
  default     = "TCP"
  description = "The network protocol to match."
  validation {
    condition     = contains(toset(["TCP", "UDP", "ICMP", "ICMPv6", "AH", "ESP", "GRE", "IPIP", "ALL"]), var.protocol)
    error_message = "Error: protocol value must be TCP, UDP, ICMP, ICMPv6, AH, ESP, GRE, IPIP or ALL only."
  }
  sensitive = false
}

variable "description" {
  type        = string
  default     = "Web Application security group rules."
  description = "A free-form text describing the security group rule."
  validation {
    condition     = var.description != null
    error_message = "Error: description value must not null."
  }
  sensitive = false
}

variable "cidr" {
  type        = string
  default     = "0.0.0.0/0"
  description = "A source or destination IP subnet to match."
  sensitive   = false
}

variable "start_port" {
  type        = number
  default     = 80
  description = "A TCP or UDP port range to match."
  validation {
    condition     = 0 <= var.start_port && var.start_port <= 65535
    error_message = "Error: start_port value must be in between 0 to 65535."
  }
  sensitive = false
}

variable "end_port" {
  type        = number
  default     = 80
  description = "A TCP or UDP port range to match."
  validation {
    condition     = 0 <= var.end_port && var.end_port <= 65535
    error_message = "Error: end_port value must be in between 0 to 65535."
  }
  sensitive = false
}

variable "icmp_type" {
  type        = number
  default     = 1
  description = "An ICMP (Internet Control Message Protocol) type."
  validation {
    condition     = 0 <= var.icmp_type && var.icmp_type <= 255
    error_message = "Error: icmp_type value must be in between 0 to 255."
  }
  sensitive = false
}

variable "icmp_code" {
  type        = number
  default     = 1
  description = "An ICMP (Internet Control Message Protocol) code."
  validation {
    condition     = 0 <= var.icmp_code && var.icmp_code <= 15
    error_message = "Error: icmp_code value must be in between 0 to 15."
  }
  sensitive = false
}

variable "user_security_group_id" {
  type        = string
  default     = ""
  description = "A source or destination security group ID to match."
  validation {
    condition     = var.user_security_group_id != null
    error_message = "Error: user_security_group_id value must not null."
  }
  sensitive = false
}

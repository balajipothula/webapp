variable "service_name" {
  type        = string
  default     = "com.amazonaws.eu-central-1.secretsmanager"
  description = "The service name."
  sensitive   = false
}

variable "vpc_id" {
  type        = string
  default     = null
  description = "The ID of the VPC in which the endpoint will be used."
  sensitive   = false
}

variable "policy" {
  type        = string
  default     = null
  description = "A policy to attach to the endpoint that controls access to the service."
  sensitive   = false
}

variable "private_dns_enabled" {
  type        = bool
  default     = true
  description = "Whether or not to associate a private hosted zone with the specified VPC."
  validation {
    condition     = var.private_dns_enabled != null && contains(tolist([true, false]), var.private_dns_enabled)
    error_message = "Error: private_dns_enabled value must not null and value either true or false only."
  }
  sensitive   = false
}

variable "subnet_ids" {
  type = list(string)
  default = null
  description = "The ID of one or more subnets in which to create a network interface for the endpoint."
  validation {
    condition     = var.subnet_ids == null || (0 < length(var.subnet_ids) && length(var.subnet_ids) < 4)
    error_message = "Error: subnet_ids must be null or a list of 1 to 3 subnet IDs."
  }
  sensitive = false
}

variable "security_group_ids" {
  type = list(string)
  default = null
  description = " The ID of one or more security groups to associate with the network interface."
  validation {
    condition     = var.security_group_ids == null || 0 < length(var.security_group_ids) && length(var.security_group_ids) < 6
    error_message = "Error: security_group_ids must be null or a list of 1 to 5 security group IDs."
  }
  sensitive   = false
}

variable "tags" {
  type = map(string)
  default = {
    "AppName"        = "WebAppFastAPI"
    "Division"       = "Platform"
  }
  description = "A map of tags to assign to the Lambda Function." 
  validation {
    condition     = var.tags != null && 0 < length(var.tags) && length(var.tags) < 51
    error_message = "Error: tags must be a map with 1 to 50 key-value pairs."
  }
  sensitive = false
}

variable "vpc_endpoint_type" {
  type        = string
  default     = "Interface"
  description = "The VPC endpoint type."
  validation {
    condition     = can(var.vpc_endpoint_type) && contains(["Gateway", "GatewayLoadBalancer", "Interface"], var.vpc_endpoint_type)
    error_message = "Error: vpc_endpoint_type must be either 'Gateway', 'GatewayLoadBalancer', or 'Interface'."
  }
  sensitive = false
}

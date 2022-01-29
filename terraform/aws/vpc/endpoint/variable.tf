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
  default = [
    "subnet-a54b1ecf",
    "subnet-9fa323e3",
    "subnet-1a42d556",
  ]
  description = "The ID of one or more subnets in which to create a network interface for the endpoint."
  validation {
    condition     = var.subnet_ids != null && 0 < length(var.subnet_ids) && length(var.subnet_ids) < 4
    error_message = "Error: subnet_ids value must not null."
  }
  sensitive = false
}

variable "security_group_ids" {
  type = list(string)
  default = [
    "",
  ]
  description = " The ID of one or more security groups to associate with the network interface."
  validation {
    condition     = var.security_group_ids != null && 0 < length(var.security_group_ids) && length(var.security_group_ids) < 6
    error_message = "Error: security_group_ids value must not null."
  }
  sensitive   = false
}

variable "tags" {
  type = map(string)
  default = {
    "Name"           = "WebAppFastAPI"
    "Division"       = "Platform"
    "DeveloperName"  = "Balaji Pothula"
    "DeveloperEmail" = "balan.pothula@gmail.com"
  }
  description = "A map of tags to assign to the Lambda Function." 
  validation {
    condition     = var.tags["Name"] != null && 3 <= length(var.tags["Name"]) && length(var.tags["Name"]) <= 64  && length(regexall("[^A-Za-z0-9-]", var.tags["Name"])) == 0
    error_message = "Error: tags of Name must not null, length must be in between 3 to 64 and only contain alphabets, numbers, and hyphens."
  }
  validation {
    condition     = var.tags != null && 1 <= length(var.tags) && length(var.tags) <= 50
    error_message = "Error: tags at least one or more expected upto 50."
  }
  sensitive = false
}

variable "vpc_endpoint_type" {
  type        = string
  default     = "Interface"
  description = "The VPC endpoint type."
  validation {
    condition     = var.vpc_endpoint_type != null && contains(tolist(["Gateway", "GatewayLoadBalancer", "Interface"]), var.vpc_endpoint_type)
    error_message = "Error: vpc_endpoint_type must not null and value either Gateway or GatewayLoadBalancer or Interface only."
  }
  sensitive = false
}

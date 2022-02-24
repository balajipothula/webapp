variable "ami" {
  type        = string
  default     = "ami-00e232b942edaf8f9"
  description = "AMI to use for the instance."
  validation {
    condition     = var.ami != null && 1 <= length(var.ami) && length(var.ami) <= 64
    error_message = "Error: ami value must not null, length must be in between 1 and 64 only."
  }
  sensitive = false
}

variable "associate_public_ip_address" {
  type        = bool
  default     = false
  description = "Whether to associate a public IP address with an instance in a VPC."
  validation {
    condition     = var.associate_public_ip_address != null && contains(tolist([true, false]), var.associate_public_ip_address)
    error_message = "Error: publish value must not null and value either true or false only."
  }
  sensitive = false
}

variable "availability_zone" {
  type        = string
  default     = "eu-central-1a"
  description = "AZ to start the instance in."
  validation {
    condition     = var.availability_zone != null && contains(tolist(["eu-central-1a", "eu-central-1b", "eu-central-1c"]), var.availability_zone)
    error_message = "Error: availability_zone value must not null and must be eu-central-1a , eu-central-1b , eu-central-1c ."
  }
  sensitive = false
}

variable "capacity_reservation_preference" {
  type        = string
  default     = "none"
  description = "Describes an instance's Capacity Reservation targeting option."
  validation {
    condition     = var.capacity_reservation_preference != null && contains(tolist(["open", "none"]), var.capacity_reservation_preference)
    error_message = "Error: capacity_reservation_preference value must not null and value either open or none only."
  }
  sensitive = false
}

variable "disable_api_termination" {
  type        = bool
  default     = false
  description = "If true, enables EC2 Instance Termination Protection."
  validation {
    condition     = var.disable_api_termination != null && contains(tolist([true, false]), var.disable_api_termination)
    error_message = "Error: disable_api_termination value must not null and value either true or false only."
  }
  sensitive = false
}

variable "ebs_optimized" {
  type        = bool
  default     = false
  description = "If true, the launched EC2 instance will be EBS-optimized."
  validation {
    condition     = var.ebs_optimized != null && contains(tolist([true, false]), var.ebs_optimized)
    error_message = "Error: ebs_optimized value must not null and value either true or false only."
  }
  sensitive = false
}

variable "hibernation" {
  type        = bool
  default     = true
  description = "If true, the launched EC2 instance will support hibernation."
  validation {
    condition     = var.hibernation != null && contains(tolist([true, false]), var.hibernation)
    error_message = "Error: hibernation value must not null and value either true or false only."
  }
  sensitive = false
}

variable "instance_initiated_shutdown_behavior" {
  type        = string
  default     = "stop"
  description = "Shutdown behavior for the instance."
  validation {
    condition     = var.instance_initiated_shutdown_behavior != null && contains(tolist(["stop", "terminate"]), var.instance_initiated_shutdown_behavior)
    error_message = "Error: instance_initiated_shutdown_behavior value must not null and must be stop or terminate."
  }
  sensitive = false
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "The instance type to use for the instance."
  validation {
    condition     = var.instance_type != null && contains(tolist(["t2.nano", "t2.micro"]), var.instance_type)
    error_message = "Error: instance_type value must not null and must be t2.nano , t2.micro , ..."
  }
  sensitive = false
}

variable "ipv6_address_count" {
  type        = number
  default     = 1
  description = "A number of IPv6 addresses to associate with the primary network interface."
  validation {
    condition     = var.ipv6_address_count != null && 0 < var.ipv6_address_count && var.ipv6_address_count < 4
    error_message = "Error: ipv6_address_count value must not null and must be in between 1 and 3."
  }
  sensitive = false
}

variable "subnet_id" {
  type        = string
  default     = "subnet-1a42d556"
  description = "VPC Subnet ID to launch in."
  validation {
    condition     = var.subnet_id != null
    error_message = "Error: subnet_id value must not null."
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
  description = "A map of tags to assign to the Lambda Function." 
  validation {
    condition     = var.tags != null && 0 < length(var.tags) && length(var.tags) < 51
    error_message = "Error: tags at least one or more expected upto 50."
  }
  sensitive = false
}

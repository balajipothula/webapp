# User defined argument.
variable "ami_map" {
  type        = map(string)
  default     = {
    "eu-central-1" = "ami-0d271bb6d5ee95925"
    "us-east-1"    = "ami-0fe78f0c5bf927432"
  }
  description = "A map of AWS Regions and AMI Names." 
  validation {
    condition     = var.ami_map != null && 0 < length(var.ami_map) && length(var.ami_map) < 11
    error_message = "Error: ami_map at least one or more expected upto 10."
  }
  sensitive   = false
}

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

variable "ebs_block_device" {
  type        = list(map(string))
  default     = []
  description = "One or more configuration blocks with additional EBS block devices to attach to the instance."
  sensitive   = false
}

# ebs_block_device > delete_on_termination
variable "delete_on_termination" {
  type        = bool
  default     = true
  description = "Whether the volume should be destroyed on instance termination."
  validation {
    condition     = var.delete_on_termination != null && contains(tolist([true, false]), var.delete_on_termination)
    error_message = "Error: delete_on_termination value must not null and value either true or false only."
  }
  sensitive = false
}

# ebs_block_device > device_name
variable "device_name" {
  type        = string
  default     = "/dev/sdh"
  description = "Device name."
  validation {
    condition     = var.device_name != null && contains(tolist(["/dev/sdh", "xvdh"]), var.device_name)
    error_message = "Error: device_name value must not null and must be /dev/sdh or xvdh."
  }
  sensitive = false
}

# ebs_block_device > encrypted
variable "encrypted" {
  type        = bool
  default     = false
  description = "Enables EBS encryption on the volume."
  validation {
    condition     = var.encrypted != null && contains(tolist([true, false]), var.encrypted)
    error_message = "Error: encrypted value must not null and value either true or false only."
  }
  sensitive = false
}

# ebs_block_device > volume_size
variable "volume_size" {
  type        = number
  default     = 10
  description = "A number of IPv6 addresses to associate with the primary network interface."
  validation {
    condition     = var.volume_size != null && 10 <= var.volume_size && var.volume_size <= 20 
    error_message = "Error: ipv6_address_count value must not null and must be in between 10 and 20."
  }
  sensitive = false
}

# ebs_block_device > volume_type
variable "volume_type" {
  type        = string
  default     = "gp2"
  description = " Type of volume."
  validation {
    condition     = var.volume_type != null && contains(tolist(["standard", "gp2", "gp3", "io1", "io2", "sc1", "st1"]), var.volume_type)
    error_message = "Error: volume_type value must not null and must be standard, gp2, gp3, io1, io2, sc1, or st1."
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

variable "key_name" {
  type        = string
  default     = "generic"
  description = "Key name of the Key Pair to use for the instance."
  validation {
    condition     = var.key_name != null
    error_message = "Error: key_name value must not null."
  }
  sensitive = false
}

variable "monitoring" {
  type        = bool
  default     = false
  description = "If true, the launched EC2 instance will have detailed monitoring enabled."
  validation {
    condition     = var.monitoring != null && contains(tolist([true, false]), var.monitoring)
    error_message = "Error: monitoring value must not null and value either true or false only."
  }
  sensitive = false
}

variable "root_block_device" {
  type        = list(map(string))
  default     = []
  description = "Configuration block to customize details about the root block device of the instance."
  sensitive   = false
}

variable "security_groups" {
  type    = list(string)
  default = [
    "default",
  ]
  description = "A list of security group names to associate with."
  validation {
    condition     = var.security_groups != null && 0 < length(var.security_groups) && length(var.security_groups) < 6
    error_message = "Error: security_groups value must not null and security_groups length must be in between 1 and 5."
  }
  sensitive = false
}

variable "subnet_id" {
  type        = string
  default     = "subnet-013922d91332c8ab8"
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

variable "tenancy" {
  type        = string
  default     = "default"
  description = "VPC Subnet ID to launch in."
  validation {
    condition     = var.tenancy != null
    error_message = "Error: tenancy value must not null."
  }
  sensitive = false
}

variable "user_data" {
  type        = string
  default     = null
  description = "User data to provide when launching the instance. Do not pass gzip-compressed data via this argument"
  sensitive   = false
}

variable "vpc_security_group_ids" {
  type    = list(string)
  default = [
    "sg-086a967f",
  ]
  description = "A list of security group IDs to associate with."
  validation {
    condition     = var.vpc_security_group_ids != null && 0 < length(var.vpc_security_group_ids) && length(var.vpc_security_group_ids) < 6
    error_message = "Error: vpc_security_group_ids value must not null and vpc_security_group_ids length must be in between 1 and 5."
  }
  sensitive = false
}

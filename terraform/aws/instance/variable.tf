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

variable "count" {
  type        = number
  default     = 1
  description = "Number of EC2 instances to create."
  validation {
    condition     = var.count != null && 0 < var.count && var.count < 4
    error_message = "Error: ami value must not null, length must be in between 1 and 3 only."
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

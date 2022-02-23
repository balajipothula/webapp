variable "ami" {
  type        = string
  default     = "ami-0dafa01c8100180f8"
  description = "AMI to use for the instance."
  validation {
    condition     = var.ami != null && 1 <= length(var.ami) && length(var.ami) <= 64
    error_message = "Error: ami value must not null, length must be in between 1 and 64 only."
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

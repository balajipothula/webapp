variable "encryption_configuration" {
  type        = list(map(string))
  default     = []
  description = "Encryption configuration for the repository."
  sensitive   = false
}

// encryption_configuration configuration block argument.
variable "encryption_type" {
  type        = string
  default     = "AES256"
  description = "The encryption type to use for the repository."
  validation {
    condition     = var.encryption_type != null && contains(toset(["AES256", "KMS"]), var.encryption_type)
    error_message = "Error: encryption_type value must not null, encryption_type value must be either AES256 or KMS."
  }
  sensitive   = false
}

// encryption_configuration configuration block argument.
variable "kms_key" {
  type        = string
  default     = " "
  description = "The ARN of the KMS key to use when encryption_type is KMS."
  validation {
    condition     = var.kms_key != null
    error_message = "Error: kms_key value must not null."
  }
  sensitive   = false
}

variable "image_scanning_configuration" {
  type        = list(map(string))
  default     = []
  description = "Configuration block that defines image scanning configuration for the repository."
  sensitive   = false
}

variable "image_tag_mutability" {
  type        = string
  default     = "IMMUTABLE"
  description = "The tag mutability setting for the repository."
  validation {
    condition     = var.image_tag_mutability != null && contains(toset(["IMMUTABLE", "MUTABLE"]), var.image_tag_mutability)
    error_message = "Error: image_tag_mutability value must not null, image_tag_mutability value must be either IMMUTABLE or MUTABLE."
  }
  sensitive   = false
}

// image_scanning_configuration configuration block argument.
variable "scan_on_push" {
  type        = bool
  default     = true
  description = "The tag mutability setting for the repository."
  validation {
    condition     = var.scan_on_push != null && contains(toset([true, false]), var.scan_on_push)
    error_message = "Error: scan_on_push value must not null, scan_on_push value must be either true or false."
  }
  sensitive   = false
}

variable "name" {
  type        = string
  default     = "generic"
  description = "Name of the repository."
  validation {
    condition     = var.name != null
    error_message = "Error: name value must not null."
  }
  sensitive   = false
}

variable "tags" {
  type        = map(string)
  default     = {
    "Name"              = "Generic"
    "Division"          = "Infrastructure"
    "Developer"         = "Balaji Pothula"
    "DeveloperEmail"    = "balan.pothula@gmail.com"
    "Manager"           = "John"
    "ManagerEmail"      = "john@gmail.com"
    "ServiceOwner"      = "Ali"
    "ServiceOwnerEmail" = "ali@gmail..com"
    "ProductOwner"      = "Ram"
    "ProductOwnerEmail" = "ram@gmail.com"
  }
  description = "A map of tags to assign to the resource."
  validation {
    condition     = var.tags != null && 1 <= length(var.tags) && length(var.tags) <= 50
    error_message = "Error: tags at least one or more expected upto 50."
  }
  sensitive   = false
}

variable "description" {
  type        = string
  default     = "AWS IAM Policy Module."
  description = "Description of the IAM policy."
  validation {
    condition     = var.description != null && 0 <= length(var.description) && length(var.description) <= 256
    error_message = "Error: description value must not null and description lenght not more than 256 charecters."
  }
  sensitive = false
}

variable "name" {
  type        = string
  default     = "AdministratorAccess"
  description = "The name of the policy."
  validation {
    condition     = var.name != null && 0 <= length(var.name) && length(var.name) <= 256
    error_message = "Error: name value must not null and name lenght not more than 256 charecters."
  }
  sensitive = false
}

variable "name_prefix" {
  type        = string
  default     = "Generic"
  description = "Creates a unique name beginning with the specified prefix."
  validation {
    condition     = var.name_prefix != null && 0 <= length(var.name_prefix) && length(var.name_prefix) <= 16
    error_message = "Error: name_prefix value must not null and name_prefix lenght not more than 16 charecters."
  }
  sensitive = false
}

variable "path" {
  type        = string
  default     = "/"
  description = "Path in which to create the policy."
  validation {
    condition     = var.path != null && var.path == "/"
    error_message = "Error: path value must not null and path must be /."
  }
  sensitive = false
}

variable "policy" {
  type        = string
  default     = null
  description = "The policy document."
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
  description = "Map of resource tags for the IAM Policy." 
  validation {
    condition     = var.tags["AppName"] != null && 3 <= length(var.tags["AppName"]) && length(var.tags["AppName"]) <= 64  && length(regexall("[^A-Za-z0-9-]", var.tags["AppName"])) == 0
    error_message = "Error: tags of AppName must not null, length must be in between 3 to 64 and only contain alphabets, numbers, and hyphens."
  }
  validation {
    condition     = var.tags != null && 1 <= length(var.tags) && length(var.tags) <= 50
    error_message = "Error: tags at least one or more expected upto 50."
  }
  sensitive = false
}

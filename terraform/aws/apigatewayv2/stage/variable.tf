variable "api_id" {
  type        = string
  default     = "$default"
  description = "The API identifier."
  validation {
    condition     = var.api_id != null
    error_message = "Error: api_id must be not null."
  }
  sensitive = false
}

variable "name" {
  type        = string
  default     = "$default"
  description = "The name of the stage."
  validation {
    condition     = var.name != null && 0 <= length(var.name) && length(var.name) <= 128
    error_message = "Error: name length must be in between 1 and 128 only."
  }
  sensitive = false
}

variable "auto_deploy" {
  type        = bool
  default     = true
  description = "Whether updates to an API automatically trigger a new deployment."
  validation {
    condition     = var.auto_deploy != null && contains(tolist([true, false]), var.auto_deploy)
    error_message = "Error: auto_deploy must not null and value either true or false."
  }
  sensitive = false
}

// access_log_settings block argument.
variable "destination_arn" {
  type        = string
  default     = "arn:aws:logs:::log-group:/aws/lambda/webapp:*"
  description = "The ARN of the CloudWatch Logs log group to receive access logs."
  sensitive = false
}

// access_log_settings block argument.
variable "format" {
  type        = string
  default     = null
  description = "A single line format of the access logs of data, as specified by selected $context variables"
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
    condition     = var.tags["AppName"] != null && 3 <= length(var.tags["AppName"]) && length(var.tags["AppName"]) <= 64  && length(regexall("[^A-Za-z0-9-]", var.tags["AppName"])) == 0
    error_message = "Error: tags of AppName must not null, length must be in between 3 to 64 and only contain alphabets, numbers, and hyphens."
  }
  validation {
    condition     = var.tags != null && 1 <= length(var.tags) && length(var.tags) <= 50
    error_message = "Error: tags at least one or more expected upto 50."
  }
  sensitive = false
}

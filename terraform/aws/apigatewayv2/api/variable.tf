variable "name" {
  type        = string
  default     = "webapp"
  description = "The name of the API."
  validation {
    condition     = var.name != null && 0 <= length(var.name) && length(var.name) <= 128
    error_message = "Error: name length must be in between 1 and 128 only."
  }
  sensitive = false
}

variable "protocol_type" {
  type        = string
  default     = "HTTP"
  description = "The API protocol."
  validation {
    condition     = var.protocol_type != null && contains(tolist(["HTTP", "WEBSOCKET"]), var.protocol_type)
    error_message = "Error: protocol_type must not null and value either HTTP or WEBSOCKET."
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
    condition     = var.tags["AppName"] != null && 3 <= length(var.tags["AppName"]) && length(var.tags["AppName"]) <= 64  && length(regexall("[^A-Za-z0-9-]", var.tags["AppName"])) == 0
    error_message = "Error: tags of AppName must not null, length must be in between 3 to 64 and only contain alphabets, numbers, and hyphens."
  }
  validation {
    condition     = var.tags != null && 1 <= length(var.tags) && length(var.tags) <= 50
    error_message = "Error: tags at least one or more expected upto 50."
  }
  sensitive = false
}

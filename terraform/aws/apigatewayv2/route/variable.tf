variable "api_id" {
  type        = string
  default     = null
  description = "The API identifier."
  sensitive = false
}

variable "route_key" {
  type        = string
  default     = "ANY /"
  description = " The route key for the route."
  validation {
    condition     = var.route_key != null
    error_message = "Error: route_key must not null."
  }
  sensitive = false
}

variable "target" {
  type        = string
  default     = null
  description = "The target for the route."
  sensitive = false
}

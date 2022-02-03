variable "api_id" {
  type        = string
  default     = null
  description = "The API identifier."
  sensitive = false
}

variable "integration_type" {
  type        = string
  default     = "AWS_PROXY"
  description = "The integration type of an integration."
  validation {
    condition     = var.integration_type != null
    error_message = "Error: integration_type must not null."
  }
  sensitive = false
}

variable "integration_uri" {
  type        = string
  default     = null
  description = "The URI of the Lambda function for a Lambda proxy integration"
  sensitive = false
}

variable "integration_method" {
  type        = string
  default     = "GET"
  description = "The integration's HTTP method."
  validation {
    condition     = var.integration_method != null
    error_message = "Error: integration_method must not null."
  }
  sensitive = false
}

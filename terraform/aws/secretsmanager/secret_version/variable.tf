variable "secret_id" {
  type        = string
  default     = "generic"
  description = "Specifies the secret to which you want to add a new version."
  validation {
    condition     = var.secret_id != null
    error_message = "Error: secret_id must not null."
  }
  sensitive = false
}

variable "secret_string" {
  type = map(string)
  default = {
    "dbInstanceIdentifier" = "webapp"
    "engine"               = "aurora-postgresql"
    "host"                 = "webapp.cluster-cxxn79rkxpwp.eu-central-1.rds.amazonaws.com"
    "port"                 = "5432"
    "resourceId"           = "cluster-BSINHSF55FNPNAG72B7GPHH4B4"
    "username"             = "webapp"
    "password"             = "WebApp#2022"
  }
  description = "Specifies text data that you want to encrypt and store in this version of the secret." 
  validation {
    condition     = var.secret_string["dbInstanceIdentifier"] != null && 3 <= length(var.secret_string["dbInstanceIdentifier"]) && length(var.secret_string["dbInstanceIdentifier"]) <= 64  && length(regexall("[^A-Za-z0-9-]", var.secret_string["dbInstanceIdentifier"])) == 0
    error_message = "Error: secret_string of dbInstanceIdentifier must not null, length must be in between 3 to 64 and only contain alphabets, numbers, and hyphens."
  }
  validation {
    condition     = var.secret_string != null && 0 < length(var.secret_string) && length(var.secret_string) < 33
    error_message = "Error: secret_string at least one or more expected upto 50."
  }
  sensitive = true
}

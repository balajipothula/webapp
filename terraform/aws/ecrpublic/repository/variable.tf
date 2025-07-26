# Resource  type : aws_ecrpublic_repository
# Resource  name : generic
# Variable  name : repository_name

variable "repository_name" {
  type        = string
  default     = "ecrpublic-repo-generic"
  description = "Name of the repository."
  validation {
    condition     = var.repository_name != null && 0 < length(var.repository_name) && length(var.repository_name) < 257
    error_message = "Error: repository_name must be between 1 and 256 characters."
  }
  sensitive = false
}

variable "catalog_data" {

  type = object({
    about_text        = optional(string)       # ✅ Optional argument, but keep it.
    architectures     = optional(list(string)) # ✅ Optional argument, but keep it.
    description       = optional(string)       # ✅ Optional argument, but keep it.
    logo_image_blob   = optional(string)       # ✅ Optional argument, but keep it.
    operating_systems = optional(list(string)) # ✅ Optional argument, but keep it.
    usage_text        = optional(string)       # ✅ Optional argument, but keep it.
  })

  default = {
    about_text        = null
    architectures     = null
    description       = null
    logo_image_blob   = null
    operating_systems = null
    usage_text        = null
  }

  description = "Catalog data configuration for the repository."

  validation {
    condition = (
      var.catalog_data == null ||
      (
        var.catalog_data.architectures == null ||
        alltrue([
          for arch in var.catalog_data.architectures : arch == null || contains(["ARM", "ARM 64", "x86", "x86-64"], arch)
        ])
      )
    )
    error_message = "Error: architectures must only include supported values: ARM, ARM 64, x86, x86-64."
  }

  validation {
    condition = (
      var.catalog_data == null ||
      (
        var.catalog_data.operating_systems == null ||
        alltrue([
          for os in var.catalog_data.operating_systems : os == null || contains(["Linux", "Windows"], os)
        ])
      )
    )
    error_message = "Error: operating_systems must only include supported values: Linux, Windows."
  }

  sensitive = false

}

variable "tags" {
  type = map(string)
  default = {
    AppName        = "WebAppFastAPI"
    Division       = "Platform"
  }
  description = "Map of tags to assign to the bucket."
  validation {
    condition     = var.tags != null && 0 < length(var.tags) && length(var.tags) < 51
    error_message = "Error: tags must contain between 1 and 50 entries."
  }
  sensitive = false
}

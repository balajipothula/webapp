# Resource  type : aws_ecrpublic_repository
# Resource  name : generic
# Attribute name : repository_name
# Argument       : var.repository_name

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.75.1"
    }
  }
  required_version = ">= 1.0.5"
}

resource "aws_ecrpublic_repository" "generic" {

  provider = aws

  repository_name = var.repository_name                        # 🔒 Required argument
  dynamic "catalog_data" {                                     # ✅ Optional argument, but keep it.
    for_each = var.catalog_data != null ? [var.catalog_data] : []
    content {
      about_text        = catalog_data.value.about_text        # ✅ Optional argument, but keep it.
      architectures     = catalog_data.value.architectures     # ✅ Optional argument, but keep it.
      description       = catalog_data.value.description       # ✅ Optional argument, but keep it.
      logo_image_blob   = catalog_data.value.logo_image_blob   # ✅ Optional argument, but keep it.
      operating_systems = catalog_data.value.operating_systems # ✅ Optional argument, but keep it.
      usage_text        = catalog_data.value.usage_text        # ✅ Optional argument, but keep it.
    }
  }  
  tags = var.tags                                              # ✅ Optional argument, but keep it.

}

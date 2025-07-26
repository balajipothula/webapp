# Resource  type : aws_ecrpublic_repository_policy
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

resource "aws_ecrpublic_repository_policy" "generic" {

  repository_name = var.repository_name # 🔒 Required argument.
  policy          = var.policy          # 🔒 Required argument.

}

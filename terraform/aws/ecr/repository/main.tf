# Resource  type : aws_ecr_repository
# Resource  name : generic
# Attribute name : name
# Argument       : var.name
# Variable  name : name
resource "aws_ecr_repository" "generic" {

  name                 = var.name                 # Required argument.

  encryption_configuration {                      # Optional configuration block, but keep it.
    encryption_type    = var.encryption_type      # Optional block argument but keep it.
  //kms_key            = var.kms_key              # Optional block argument, but will become mandatory when encryption_type is KMS.
  }

  image_tag_mutability = var.image_tag_mutability # Optional argument, but keep it.

  dynamic "image_scanning_configuration" {        # Optional configuration block, but keep it.
    for_each           = var.image_scanning_configuration
    content {
      scan_on_push     = null                     # Required block argument.
    }
  }

  tags                 = var.tags                 # Optional argument, but keep it.

}

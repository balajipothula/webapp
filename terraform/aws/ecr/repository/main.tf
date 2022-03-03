# Resource  type : aws_ecr_repository
# Resource  name : generic
# Attribute name : name
# Argument       : var.name
# Variable  name : name
resource "aws_ecr_repository" "generic" {

  name                 = var.name                         # Required argument.

  dynamic "encryption_configuration" {                    # Optional configuration block, but keep it.
    for_each           = var.encryption_configuration     # Fetching encryption_configuration block arguments.
    content {
      encryption_type  = null                             # Optional block argument but keep it.
      kms_key          = null                             # Optional block argument, but will become mandatory when encryption_type is KMS.
    }
  }

  image_tag_mutability = var.image_tag_mutability         # Optional argument, but keep it.

  dynamic "image_scanning_configuration" {                # Optional configuration block, but keep it.
    for_each           = var.image_scanning_configuration # Fetching image_scanning_configuration block arguments.
    content {
      scan_on_push     = true                             # Required block argument.
    }
  }

  tags                 = var.tags                         # Optional argument, but keep it.

}

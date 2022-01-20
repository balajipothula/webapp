# Resource  type : aws_s3_bucket
# Resource  name : generic
# Attribute name : bucket
# Argument       : var.bucket
# Variable  name : bucket
resource "aws_s3_bucket_object" "generic" {

  bucket        = var.bucket # Required argument.
  key           = var.key    # Required argument.
  acl           = var.acl    # Optional argument but keep it.
  content        = var.content # Optional argument but keep it.
  tags          = var.tags   # Optional argument but keep it.

}
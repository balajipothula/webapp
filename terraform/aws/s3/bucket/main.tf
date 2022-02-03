# Resource  type : aws_s3_bucket
# Resource  name : generic
# Attribute name : bucket
# Argument       : var.bucket
# Variable  name : bucket
resource "aws_s3_bucket" "generic" {

  bucket        = var.bucket                                          # Optional argument but keep it.
//bucket_prefix = var.bucket_prefix                                   # Optional argument, conflicts with bucket.
  acl           = var.acl                                             # Optional argument but keep it.
  policy        = file("${path.module}/json/AmazonS3FullAccess.json") # Optional argument but keep it.
  tags          = var.tags                                            # Optional argument but keep it.

}

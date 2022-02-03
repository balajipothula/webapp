# Resource  type : aws_s3_bucket_object
# Resource  name : generic
# Attribute name : source
# Argument       : var.source_code
# Variable  name : source_code
resource "aws_s3_bucket_object" "generic" {

  bucket  = var.bucket      # Required argument.
  key     = var.key         # Required argument.
  acl     = var.acl         # Optional argument but keep it.
  etag    = var.etag        # Optional argument but keep it.
  source  = var.source_code # Optional argument but keep it.
  tags    = var.tags        # Optional argument but keep it.

}

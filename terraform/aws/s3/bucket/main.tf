# Resource  type : aws_s3_bucket
# Resource  name : generic
# Attribute name : bucket
# Argument       : var.bucket
resource "aws_s3_bucket" "generic" {

  bucket              = var.bucket              # ✅ Optional argument, but keep it, ❗ Forces new resource.
//bucket_prefix       = var.bucket_prefix       # ✅ Optional argument, ❗ Forces new resource.
  force_destroy       = var.force_destroy       # ✅ Optional argument, but keep it.
  object_lock_enabled = var.object_lock_enabled # ✅ Optional argument, ❗ Forces new resource.
  tags                = var.tags                # ✅ Optional argument but keep it.

}

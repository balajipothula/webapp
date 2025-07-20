# Resource  type : aws_s3_bucket_policy
# Resource  name : generic
# Attribute name : bucket
# Argument       : var.bucket
resource "aws_s3_bucket_policy" "generic" {

  bucket = var.bucket # 🔒 Required argument.
  policy = var.policy # 🔒 Required argument

}

# Data Source: aws_region
data "aws_region" "current" {
}

data "aws_iam_policy_document" "webapp_aws_s3_bucket_iam_policy" {

  statement {
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::804756347993:root"]
    }
    actions = [
      "s3:GetObject"
    ]
    resources = [
      "arn:aws:s3:::webapp-aws-lambda-src-s3-bucket-11/*"
    ]
  }

}

# Resource  type : aws_s3_bucket
# Resource  name : generic
# Attribute name : bucket
# Argument       : var.bucket
# Variable  name : bucket
resource "aws_s3_bucket" "generic" {

  bucket        = var.bucket        # Optional argument but keep it.
//bucket_prefix = var.bucket_prefix # Optional argument, conflicts with bucket.
  acl           = var.acl           # Optional argument but keep it.
//policy        = null              # Optional argument but keep it.
  policy = data.aws_iam_policy_document.webapp_aws_s3_bucket_iam_policy.json
  tags          = var.tags          # Optional argument but keep it.

}

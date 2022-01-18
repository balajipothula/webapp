resource "aws_iam_policy" "generic" {

  description = var.description                                  # Optional argument but keep it.
  name        = var.name                                         # Optional argument but keep it.
  path        = "/"
  policy      = file("${path.module}/json/LambdaIAMPolicy.json") # Required argument.

}

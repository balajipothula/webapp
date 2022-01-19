resource "aws_iam_policy" "generic" {

  description = var.description                                      # Optional argument but keep it.
  name        = var.name                                             # Optional argument but keep it.
  path        = var.path                                             # Optional argument but keep it.
  policy      = null                                                 # Required argument.
//policy      = file("${path.module}/json/AdministratorAccess.json") # Required argument.

}

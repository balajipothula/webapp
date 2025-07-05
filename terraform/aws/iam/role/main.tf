resource "aws_iam_role" "generic" {

  #assume_role_policy    = file("${path.module}/json/LambdaIAMRole.json") # Required argument.
  assume_role_policy    = var.assume_role_policy    # Required argument.
  description           = var.description           # Optional argument but keep it.
  force_detach_policies = var.force_detach_policies # Optional argument but keep it.
  name                  = var.name                  # Optional argument but keep it.

}

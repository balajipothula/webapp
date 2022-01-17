resource "aws_iam_role" "generic" {

  assume_role_policy    = file("${path.module}/json/WebAppLambdaRole.json")
  description           = var.description
  force_detach_policies = var.force_detach_policies
  name                  = var.name

}

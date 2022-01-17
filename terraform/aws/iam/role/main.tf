resource "aws_iam_role" "generic" {

  assume_role_policy    = file("${path.module}/json/WebAppLambdaRole.json")
  description           = "Role policy for WebApp Lambda Function."
  force_detach_policies = false 
  name                  = "WebAppLambdaRole3"

}

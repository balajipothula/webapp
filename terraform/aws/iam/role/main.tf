resource "aws_iam_role" "generic" {

  assume_role_policy    = file("./terraform/aws/role/json/WebAppLambdaRole.json")
  description           = "Role policy for WebApp Lambda Function."
  force_detach_policies = false 
  name                  = "WebAppLambdaRole"

}

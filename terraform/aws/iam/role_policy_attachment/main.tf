resource "aws_iam_role_policy_attachment" "generic" {

  role       = var.role       # Required argument.
  policy_arn = var.policy_arn # Required argument.

}

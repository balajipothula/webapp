/*
resource "aws_iam_role_policy_attachment" "generic" {

  role       = var.role       # Required argument.
  policy_arn = var.policy_arn # Required argument.

}
*/

# Resource type : aws_iam_policy
# Resource name : generic
# Argument name : policy
# Variable name : policy
resource "aws_iam_policy_attachment" "generic" {  

  name       = var.name        # 🔒 Required argument — ❗ Forces new resource.
  policy_arn = var.policy_arn  # 🔒 Required argument — ❗ Forces new resource.
  users      = var.users       # ✅ Optional argument.
  roles      = var.roles       # ✅ Optional argument.
  groups     = var.groups      # ✅ Optional argument.

}

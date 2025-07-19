# Resource type : aws_iam_role
# Resource name : generic
# Argument name : assume_role_policy
# Variable name : assume_role_policy
resource "aws_iam_role" "generic" {

  lifecycle {
    ignore_changes = [
      description,
    ]
  }

  assume_role_policy    = var.assume_role_policy    # 🔒 Required argument.
  description           = var.description           # ✅ Optional argument but keep it.
  force_detach_policies = var.force_detach_policies # ✅ Optional argument but keep it.
  name                  = var.name                  # ✅ Optional argument but keep it.

}

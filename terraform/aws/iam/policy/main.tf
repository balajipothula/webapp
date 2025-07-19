# Resource type : aws_iam_policy
# Resource name : generic
# Argument name : policy
# Variable name : policy
resource "aws_iam_policy" "generic" {

  lifecycle {
    ignore_changes = [
      description,
    ]
  }

  description = var.description # ✅ Optional argument, but keep it, ❗ Forces new resource.
//name_prefix = var.name_prefix # ✅ Optional argument — conflicts with `name`. ❗ Forces new resource.
  name        = var.name        # ✅ Optional argument — conflicts with `name_prefix`, ❗ Forces new resource. 
  path        = var.path        # ✅ Optional argument, but keep it.
  policy      = var.policy      # 🔒 Required argument.
  tags        = var.tags        # ✅ Optional argument, but keep it.

}

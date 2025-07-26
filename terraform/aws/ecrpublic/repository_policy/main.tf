# Resource  type : aws_ecrpublic_repository_policy
# Resource  name : generic
# Attribute name : repository_name
# Argument       : var.repository_name


resource "aws_ecrpublic_repository_policy" "generic" {

  repository_name = var.repository_name # 🔒 Required argument.
  policy          = var.policy          # 🔒 Required argument.

}

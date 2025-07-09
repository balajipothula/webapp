# Data Source: aws_vpc
data "aws_vpc" "default" {
  default = true
}


# Resource type : aws_security_group
# Resource name : generic
# Argument name : name
# Variable name : name
resource "aws_security_group" "generic" {

  name        = var.name                                           # ✅ Optional argument, ❗ Forces new resource.
  description = var.description                                    # ✅ Optional argument, ❗ Forces new resource.

  dynamic "egress" {
    for_each = var.egress_rules
    content {
      from_port        = egress.value.from_port                    # 🔒 Required argument.
      to_port          = egress.value.to_port                      # 🔒 Required argument.
      protocol         = egress.value.protocol                     # 🔒 Required argument.
      cidr_blocks      = egress.value.cidr_blocks                  # ✅ Optional argument — recommended to keep.
      description      = try(egress.value.description, null)       # ✅ Optional argument — recommended to keep.
      ipv6_cidr_blocks = try(egress.value.ipv6_cidr_blocks, null)  # ✅ Optional argument — recommended to keep.
      prefix_list_ids  = try(egress.value.prefix_list_ids, null)   # ✅ Optional argument — recommended to keep.
      security_groups  = try(egress.value.security_groups, null)   # ✅ Optional argument — recommended to keep.
      self             = try(egress.value.self, null)              # ✅ Optional argument — recommended to keep.
    }
  }  

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port        = ingress.value.from_port                   # 🔒 Required argument.
      to_port          = ingress.value.to_port                     # 🔒 Required argument.
      protocol         = ingress.value.protocol                    # 🔒 Required argument.
      cidr_blocks      = ingress.value.cidr_blocks                 # ✅ Optional argument — recommended to keep.
      description      = try(ingress.value.description, null)      # ✅ Optional argument — recommended to keep.
      ipv6_cidr_blocks = try(ingress.value.ipv6_cidr_blocks, null) # ✅ Optional argument — recommended to keep.
      prefix_list_ids  = try(ingress.value.prefix_list_ids, null)  # ✅ Optional argument — recommended to keep.
      security_groups  = try(ingress.value.security_groups, null)  # ✅ Optional argument — recommended to keep.
      self             = try(ingress.value.self, null)             # ✅ Optional argument — recommended to keep.
    }
  }
  
  name_prefix             = var.name_prefix                        # ✅ Optional argument — 🤜💥🤛 Conflicts with `name`.
  revoke_rules_on_delete  = var.revoke_rules_on_delete             # ✅ Optional argument.
  tags                    = var.tags                               # ✅ Optional argument — recommended to keep.
  vpc_id                  = data.aws_vpc.default.id                # ✅ Optional argument, ❗ Forces new resource.

}

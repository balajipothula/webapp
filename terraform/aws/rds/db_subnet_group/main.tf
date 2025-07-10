# Data Source: aws_vpc
data "aws_vpc" "default" {
  default = true
}

# Data Source: aws_subnets
# Fetch subnet IDs in default VPC
data "aws_subnets" "available" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# Resource type : aws_db_subnet_group
# Resource name : generic
# Argument name : name
# Variable name : name
resource "aws_db_subnet_group" "generic" {

  name        = var.name                       # ✅ Optional argument, ❗ Forces new resource.
  name_prefix = var.name_prefix                # ✅ Optional argument, ❗ Forces new resource — 🤜💥🤛 Conflicts with `name`.
  description = var.description                # ✅ Optional argument — recommended to keep.
  subnet_ids  = data.aws_subnets.available.ids # 🔒 Required argument
  tags        = var.tags                       # ✅ Optional argument — recommended to keep.

}

# Data Source: aws_vpc
data "aws_vpc" "default" {
  default = true
}

# Data Source: aws_subnet_ids
data "aws_subnet_ids" "available" {
  vpc_id = data.aws_vpc.default.id
}

# Data Source: aws_subnet
data "aws_subnet" "default" {
  for_each = data.aws_subnet_ids.available.ids
  id       = each.value
}

# Resource type : aws_default_security_group
# Resource name : default
# Argument name : vpc_id
# Variable name : vpc_id
resource "aws_default_security_group" "default" {

  vpc_id = data.aws_vpc.default.id

  ingress {
    cidr_blocks = [for subnet in data.aws_subnet.default : subnet.cidr_block]
    description = "Internet Control Message rule."
    protocol    = "icmp"
    to_port     = 1
    from_port   = 1
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "All outbound traffic rule."
    protocol    = "all"
    to_port     = 0
    from_port   = 0
  }
 
}

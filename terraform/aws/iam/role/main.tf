# Data Source: aws_region
data "aws_region" "current" {
}

# Data Source: aws_vpc
data "aws_vpc" "default" {
}

# Data Source: aws_subnet_ids
data "aws_subnet_ids" "available" {
  vpc_id = data.aws_vpc.default.id
}

# Data Source: aws_security_groups
data "aws_security_groups" "default" {
  filter {
    name   = "group-name"
    values = ["default"]
  }
  filter {
    name   = "description"
    values = ["default VPC security group"]
  }
}

resource "aws_iam_role" "generic" {

  assume_role_policy    = file("./json/WebAppLambdaRole.json")
  description           = "Role policy for WebApp Lambda Function."
  force_detach_policies = false 
  name                  = "WebAppLambdaRole"

}

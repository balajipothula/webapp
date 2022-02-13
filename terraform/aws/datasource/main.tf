data "aws_arn" "current" {
  arn = "arn:aws:iam:*:*:role/WebAppLambdaRole"
}

data "aws_availability_zones" "current" {
  all_availability_zones = true
  state                  = "available"
}

data "aws_billing_service_account" "main" {}

data "aws_caller_identity" "current" {}

data "aws_default_tags" "current" {}

data "aws_ip_ranges" "all" {
  regions  = [data.aws_region.current]
  services = ["amazon"]
}

data "aws_partition" "current" {}

data "aws_region" "current" {
}

data "aws_regions" "all" {
  all_regions = true
}

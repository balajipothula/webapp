output "aws_region" {
  value       = data.aws_region.current.name
  description = "The name of the selected region."
  sensitive   = false
}

output "aws_vpc" {
  value       = data.aws_vpc.default.id
  description = "The id of the specific VPC to retrieve."
  sensitive   = false
}

output "aws_subnet_ids" {
  value       = data.aws_subnet_ids.available.ids
  description = "A set of all the subnet ids found."
  sensitive   = false
}

output "aws_security_groups" {
  value       = data.aws_security_groups.default.ids
  description = "IDs of the matches security groups."
  sensitive   = false
}

# Resource  type : aws_iam_role
# Resource  name : generic
# Attribute name : arn
output "arn" {
  value       = aws_iam_role.generic.arn
  description = "ARN specifying the role."
  sensitive   = false
}

# Resource  type : aws_iam_role
# Resource  name : generic
# Attribute name : name
output "name" {
  value       = aws_iam_role.generic.name
  description = "Name of the role."
  sensitive   = false
}
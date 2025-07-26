/*
output "aws_region_current_name" {
  value       = data.aws_region.current.name
  description = "The name of the selected region."
  sensitive   = false
}

output "aws_caller_identity_current_account_id" {
  value       = data.aws_caller_identity.current.account_id
  description = "AWS Account ID number of the account that owns or contains the calling entity."
  sensitive   = false
}

output "aws_caller_identity_current_arn" {
  value       = data.aws_caller_identity.current.arn
  description = "ARN associated with the calling entity."
  sensitive   = false
}

output "aws_vpc_default_id" {
  value       = data.aws_vpc.default.id
  description = "The id of the specific VPC to retrieve."
  sensitive   = false
}

output "aws_vpc_default_cidr_block" {
  value       = data.aws_vpc.default.cidr_block
  description = "The CIDR block for the association."
  sensitive   = false
}

output "aws_availability_zones_available_names" {
  value       = data.aws_availability_zones.available.names
  description = "A list of the Availability Zone names available to the account."
  sensitive   = false
}

output "aws_subnet_ids_available_ids" {
  value       = data.aws_subnet_ids.available.ids
  description = "A set of all the subnet ids found."
  sensitive   = false
}

output "aws_security_groups_default_ids" {
  value       = data.aws_security_groups.default.ids
  description = "IDs of the matches security groups."
  sensitive   = false
}
*/


output "webapp_aws_ecrpublic_repository__repository_uri" {
  value       = module.webapp_aws_ecrpublic_repository.repository_uri
  description = "The URI of the repository."
  sensitive   = false
}

output "aws_ecrpublic_authorization_token__info__authorization_token" {
  value       = data.aws_ecrpublic_authorization_token.info.authorization_token
  description = "Temporary IAM authentication credentials to access the ECR repository encoded in base64 in the form of user_name:password."
  sensitive   = false
}

output "aws_ecrpublic_authorization_token__info__expires_at" {
  value       = data.aws_ecrpublic_authorization_token.info.expires_at
  description = "Time in UTC RFC3339 format when the authorization token expires."
  sensitive   = false
}

output "aws_ecrpublic_authorization_token__info__id" {
  value       = data.aws_ecrpublic_authorization_token.info.id
  description = "Region of the authorization token."
  sensitive   = false
}

output "aws_ecrpublic_authorization_token__info__password" {
  value       = data.aws_ecrpublic_authorization_token.info.password
  description = "Password decoded from the authorization token."
  sensitive   = true
}

output "aws_ecrpublic_authorization_token__info__user_name" {
  value       = data.aws_ecrpublic_authorization_token.info.user_name
  description = "User name decoded from the authorization token."
  sensitive   = false
}

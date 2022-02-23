# Resource  type : aws_instance
# Resource  name : generic
# Attribute name : arn
output "arn" {
  value       = aws_instance.generic.arn
  description = "The ARN of the instance."
  sensitive   = false
}

output "capacity_reservation_specification" {
  value       = aws_instance.generic.capacity_reservation_specification
  description = "Capacity reservation specification of the instance."
  sensitive   = false
}

output "instance_state" {
  value       = aws_instance.generic.instance_state
  description = "The state of the instance."
  sensitive   = false
}

output "outpost_arn" {
  value       = aws_instance.generic.outpost_arn
  description = "The ARN of the Outpost the instance is assigned to."
  sensitive   = false
}

output "password_data" {
  value       = aws_instance.generic.password_data
  description = "Base-64 encoded encrypted password data for the instance."
  sensitive   = false
}

output "primary_network_interface_id" {
  value       = aws_instance.generic.primary_network_interface_id
  description = "The ID of the instance's primary network interface."
  sensitive   = false
}

output "private_dns" {
  value       = aws_instance.generic.private_dns
  description = "The private DNS name assigned to the instance."
  sensitive   = false
}

output "public_dns" {
  value       = aws_instance.generic.public_dns
  description = "The public DNS name assigned to the instance."
  sensitive   = false
}

output "public_ip" {
  value       = aws_instance.generic.public_ip
  description = "The public IP address assigned to the instance."
  sensitive   = false
}

output "tags_all" {
  value       = aws_instance.generic.public_ip
  description = "A map of tags assigned to the resource."
  sensitive   = false
}
/*
# ebs_block_device > volume_id
output "ebs_block_device_volume_id" {
  value       = aws_instance.generic.ebs_block_device.1.volume_id
  description = "ID of the volume."
  sensitive   = false
}
*/
# root_block_device > volume_id
output "root_block_device_volume_id" {
  value       = aws_instance.generic.root_block_device.0.volume_id
  description = "ID of the volume."
  sensitive   = false
}
/*
# root_block_device > device_name
output "device_name" {
  value       = aws_instance.generic.device_name
  description = "Device name."
  sensitive   = false
}
*/

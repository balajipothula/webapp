# exoscale provider information.
terraform {

  # Terraform binary version.
  required_version = "1.4.5"

  required_providers {

    exoscale = {
      source  = "exoscale/exoscale"
      version = "0.48.0"
    }

  }

}

/*
 * Resource type  : exoscale_security_group_rule
 * Resource name  : generic
 * Attribute name : security_group_id
 * Argument name  : var.security_group_id
 * Variable name  : security_group_id
 */
resource "exoscale_security_group_rule" "generic" {

  # Importing exoscale provider.
  provider = exoscale

  security_group_id = var.security_group_id # Required argument.
  type              = var.type              # Required argument.
  protocol          = var.protocol          # Required argument.
  description       = var.description       # Optional argument.
  cidr              = var.cidr              # Optional argument, conflicts with `user_security_group_id`.
  start_port        = var.start_port        # Optional argument, conflicts with `icmp_code`.
  end_port          = var.end_port          # Optional argument, conflicts with `icmp_code`, `icmp_type`.
  //icmp_type              = var.icmp_type              # Optional argument, conflicts with `end_port`
  //icmp_code              = var.icmp_code              # Optional argument, conflicts with `start_port`, `end_port`.
  //user_security_group_id = var.user_security_group_id # Optional argument, conflicts with `cidr`.




  # Operation Timeouts:
  # `timeouts` block arguments allows you to customize how long
  # certain operations are allowed to take before being considered to have failed.
  timeouts {
    create = "5m"
    delete = "5m"
    read   = "5m"
  }

}


# Resource type : aws_vpc_endpoint
# Resource name : generic
# Argument name : service_name
# Variable name : service_name

resource "aws_vpc_endpoint" "generic" {

  service_name        = var.service_name        # 🔒 Required argument.
  vpc_id              = var.vpc_id              # 🔒 Required argument.
//policy              = var.policy              # ✅ Optional argument.
  private_dns_enabled = var.private_dns_enabled # ✅ Optional argument, but applicable for endpoints of type Interface.
  subnet_ids          = var.subnet_ids          # ✅ Optional argument, but applicable for endpoints of type GatewayLoadBalancer and Interface.
  security_group_ids  = var.security_group_ids  # ✅ Optional argument, but required for endpoints of type Interface.
  tags                = var.tags                # ✅ Optional argument, but keep it.
  vpc_endpoint_type   = var.vpc_endpoint_type   # ✅ Optional argument, but keep it.

}

# Security Group

resource "aws_security_group" "efs" {
  name = "${local.name_prefix}-efs-sg"

  vpc_id = var.network_values.vpc_id

  tags = merge(local.tags, {
    Name = "${local.name_prefix}-efs-sg"
  })
}

resource "aws_vpc_security_group_egress_rule" "efs_outbound_all" {
  security_group_id = aws_security_group.efs.id

  ip_protocol = "-1"
  cidr_ipv4   = "0.0.0.0/0"

  tags = merge(local.tags, {
    Name = "${local.name_prefix}-efs-sg outbound all"
  })
}

resource "aws_vpc_security_group_ingress_rule" "efs_inbound_all_vpc" {
  security_group_id = aws_security_group.efs.id

  from_port   = 2049
  to_port     = 2049
  ip_protocol = "tcp"
  cidr_ipv4   = "0.0.0.0/0"

  tags = merge(local.tags, {
    Name = "${local.name_prefix}-efs-sg inbound http"
  })
}

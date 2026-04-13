locals {
  security_group_resource_name = "ecs-sg"
}

resource "aws_security_group" "ecs_security_group" {
  name        = "${var.cluster_name}--${local.security_group_resource_name}"
  description = "ECS security group"

  vpc_id = var.vpc_id

  ingress {
    from_port   = var.service_port
    to_port     = var.service_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name     = "${var.cluster_name}--${local.security_group_resource_name}"
    Resource = "ecs-security-group"
  }
}
# Parameter Store

resource "aws_ssm_parameter" "vpc" {
  name  = "${var.project_name}/vpc/vpc_id"
  type  = "String"
  value = aws_vpc.main.id
}


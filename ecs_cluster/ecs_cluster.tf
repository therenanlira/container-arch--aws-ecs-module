resource "aws_ecs_cluster" "main" {
  name = "${terraform.workspace}--${var.project_name}--ecs-cluster"

  setting {
    name  = "containerInsights"
    value = "disabled"
  }

  tags = {
    Name = "${terraform.workspace}--${var.project_name}--ecs-cluster"
  }
}

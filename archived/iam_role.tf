locals {
  iam_resource_name = "service-execution"
}

resource "aws_iam_role" "service_execution_role" {
  name = "${var.service_name}--${local.iam_resource_name}--role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name     = "${var.service_name}--${local.iam_resource_name}--role"
    Resource = "service-execution-role"
  }
}

resource "aws_iam_role_policy" "service_execution_policy" {
  name = "${var.service_name}--${local.iam_resource_name}--policy"
  role = aws_iam_role.service_execution_role.name
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
          "elasticloadbalancing:DeregisterTargets",
          "elasticloadbalancing:Describe*",
          "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
          "elasticloadbalancing:RegisterTargets",
          "ec2:Describe*",
          "ec2:AuthorizeSecurityGroupIngress",
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "ssm:GetParameters",
          "secretsmanager:GetSecretValue",
        ],
        Resource = "*"
      }
    ]
  })
}

locals {
  taskdef_resource_name = "task-def"
}

resource "aws_ecs_task_definition" "ecs_task_definition" {
  family = "${var.cluster_name}--${var.service_name}--${local.taskdef_resource_name}"

  network_mode             = "awsvpc"
  requires_compatibilities = var.capabilities

  cpu                = var.service_cpu
  memory             = var.service_memory
  execution_role_arn = aws_iam_role.service_execution_role.arn
  task_role_arn      = var.service_task_execution_role_arn

  dynamic "volume" {
    for_each = var.efs_volumes

    content {
      configure_at_launch = false
      name                = volume.value.volume_name

      efs_volume_configuration {
        file_system_id          = volume.value.file_system_id
        root_directory          = volume.value.file_system_root
        transit_encryption      = "ENABLED"
        transit_encryption_port = 2049
      }
    }
  }

  container_definitions = jsonencode([
    {
      name        = var.service_name
      image       = var.container_image
      cpu         = var.service_cpu
      memory      = var.service_memory
      essential   = true
      environment = var.environment_variables
      secrets     = var.secrets

      portMappings = [
        {
          containerPort = var.service_port
          hostPort      = var.service_port
          protocol      = "tcp"
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.log_group.name
          "awslogs-region"        = var.region
          "awslogs-stream-prefix" = var.service_name
        }
      }

      mountPoints = [
        for volume in var.efs_volumes : {
          sourceVolume  = volume.volume_name
          containerPath = volume.mount_point
          readOnly      = volume.read_only
        }
      ]

    }
  ])

  tags = {
    Name     = "${var.service_name}--${local.taskdef_resource_name}"
    Resource = "task-definition"
  }
}
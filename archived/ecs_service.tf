locals {
  ecs_service_resource_name = "ecs-service"
}

resource "aws_ecs_service" "ecs_service" {
  name            = var.service_name
  cluster         = var.cluster_name
  task_definition = aws_ecs_task_definition.ecs_task_definition.arn
  desired_count   = var.service_task_count
  # launch_type     = var.service_launch_type

  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 100

  deployment_circuit_breaker {
    enable   = true
    rollback = true
  }

  dynamic "capacity_provider_strategy" {
    for_each = var.service_launch_type
    content {
      capacity_provider = capacity_provider_strategy.value.capacity_provider
      weight            = capacity_provider_strategy.value.weight
    }
  }

  dynamic "ordered_placement_strategy" {
    for_each = var.service_launch_type == "EC2" ? [0] : []
    content {
      type  = "spread"
      field = "attribute:ecs.availability-zone"
    }
  }

  network_configuration {
    subnets          = var.private_subnets
    security_groups  = [aws_security_group.ecs_security_group.id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.ecs_target_group.arn
    container_name   = var.service_name
    container_port   = var.service_port
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [desired_count]
  }

  tags = {
    Name     = "${var.cluster_name}--${local.ecs_service_resource_name}"
    Resource = "ecs-service"
  }
}
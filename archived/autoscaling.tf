resource "aws_appautoscaling_target" "ecs_target" {
  min_capacity = var.task_minimum
  max_capacity = var.task_maximum

  resource_id        = "service/${var.cluster_name}/${aws_ecs_service.ecs_service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}
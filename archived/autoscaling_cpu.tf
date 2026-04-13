locals {
  cpu_out_resource_name           = "cpu-scale-out"
  cpu_in_resource_name            = "cpu-scale-in"
  cpu_tracking_resource_name      = "cpu-scale-tracking"
  requests_tracking_resource_name = "requests-scale-tracking"
}

resource "aws_appautoscaling_policy" "ecs_cpu_scale_out" {
  count = var.scale_type == "cpu" ? 1 : 0
  name  = "${var.cluster_name}--${var.service_name}--${local.cpu_out_resource_name}--policy"

  resource_id        = aws_appautoscaling_target.ecs_target.resource_id
  service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension

  policy_type = "StepScaling"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = var.scale_out_cooldown
    metric_aggregation_type = var.scale_out_statistic

    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = var.scale_out_adjustment
    }
  }
}

resource "aws_cloudwatch_metric_alarm" "ecs_cpu_scale_out_alarm" {
  count = var.scale_type == "cpu" ? 1 : 0

  alarm_name        = "${var.cluster_name}--${var.service_name}--${local.cpu_out_resource_name}--alarm"
  alarm_description = "Scale out when CPU exceeds ${var.scale_out_cpu_threshold}%"

  comparison_operator = var.scale_out_comparison_operator
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  statistic           = var.scale_out_statistic

  period             = var.scale_out_period
  evaluation_periods = var.scale_out_evaluation_periods
  threshold          = var.scale_out_cpu_threshold

  dimensions = {
    ClusterName = var.cluster_name
    ServiceName = var.service_name
  }

  alarm_actions = [aws_appautoscaling_policy.ecs_cpu_scale_out[count.index].arn]
}

resource "aws_appautoscaling_policy" "ecs_cpu_scale_in" {
  count = var.scale_type == "cpu" ? 1 : 0
  name  = "${var.cluster_name}--${var.service_name}--${local.cpu_in_resource_name}--policy"

  resource_id        = aws_appautoscaling_target.ecs_target.resource_id
  service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension

  policy_type = "StepScaling"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = var.scale_in_cooldown
    metric_aggregation_type = var.scale_in_statistic

    step_adjustment {
      metric_interval_upper_bound = 0
      scaling_adjustment          = var.scale_in_adjustment
    }

    step_adjustment {
      metric_interval_lower_bound = 0
      metric_interval_upper_bound = var.scale_in_cpu_threshold
      scaling_adjustment          = var.scale_in_adjustment
    }

    step_adjustment {
      metric_interval_lower_bound = var.scale_in_cpu_threshold
      scaling_adjustment          = 0
    }
  }
}


resource "aws_cloudwatch_metric_alarm" "ecs_cpu_scale_in_alarm" {
  count = var.scale_type == "cpu" ? 1 : 0

  alarm_name        = "${var.cluster_name}--${var.service_name}--${local.cpu_in_resource_name}--alarm"
  alarm_description = "Scale in when CPU exceeds ${var.scale_in_cpu_threshold}%"

  comparison_operator = var.scale_in_comparison_operator
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  statistic           = var.scale_in_statistic

  period             = var.scale_in_period
  evaluation_periods = var.scale_in_evaluation_periods
  threshold          = var.scale_in_cpu_threshold

  dimensions = {
    ClusterName = var.cluster_name
    ServiceName = var.service_name
  }

  alarm_actions = [aws_appautoscaling_policy.ecs_cpu_scale_in[count.index].arn]
}

resource "aws_appautoscaling_policy" "ecs_target_cpu_tracking" {
  count = var.scale_type == "cpu_tracking" ? 1 : 0
  name  = "${var.cluster_name}--${var.service_name}--${local.cpu_tracking_resource_name}--policy"

  resource_id        = aws_appautoscaling_target.ecs_target.resource_id
  service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension

  policy_type = "TargetTrackingScaling"

  target_tracking_scaling_policy_configuration {
    target_value       = var.scale_cpu_tracking
    scale_in_cooldown  = var.scale_in_cooldown
    scale_out_cooldown = var.scale_out_cooldown

    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
  }
}

resource "aws_appautoscaling_policy" "ecs_target_requests_tracking" {
  count = var.scale_type == "requests_tracking" ? 1 : 0
  name  = "${var.cluster_name}--${var.service_name}--${local.requests_tracking_resource_name}--policy"

  resource_id        = aws_appautoscaling_target.ecs_target.resource_id
  service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension

  policy_type = "TargetTrackingScaling"

  target_tracking_scaling_policy_configuration {
    target_value       = var.scale_cpu_tracking
    scale_in_cooldown  = var.scale_in_cooldown
    scale_out_cooldown = var.scale_out_cooldown

    predefined_metric_specification {
      predefined_metric_type = "ALBRequestCountPerTarget"
      resource_label         = "${data.aws_alb.alb_arn.arn_suffix}/${aws_lb_target_group.ecs_target_group.arn_suffix}"
    }
  }
}

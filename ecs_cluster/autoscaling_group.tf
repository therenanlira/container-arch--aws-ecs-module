resource "aws_autoscaling_group" "these" {
  for_each = toset(var.capacity_provider_strategies)

  name_prefix = "${terraform.workspace}--${var.project_name}--${replace(each.value, "_", "-")}--asg"

  vpc_zone_identifier = [
    for sub in var.network_conf.private_subnet_ids : sub
  ]

  desired_capacity = var.ecs_autoscaling[each.value].desired
  max_size         = var.ecs_autoscaling[each.value].maximum
  min_size         = var.ecs_autoscaling[each.value].minimum

  launch_template {
    id      = aws_launch_template.these[each.value].id
    version = aws_launch_template.these[each.value].latest_version
  }

  tag {
    key                 = "Name"
    value               = "${terraform.workspace}--${var.project_name}--${replace(each.value, "_", "-")}--asg"
    propagate_at_launch = true
  }

  tag {
    key                 = "AmazonECSManaged"
    value               = true
    propagate_at_launch = true
  }

  dynamic "tag" {
    for_each = local.tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}

resource "aws_ecs_capacity_provider" "these" {
  for_each = toset(var.capacity_provider_strategies)

  name = "${terraform.workspace}--${var.project_name}--${replace(each.value, "_", "-")}--cp"

  auto_scaling_group_provider {
    auto_scaling_group_arn = aws_autoscaling_group.these[each.value].arn

    managed_scaling {
      maximum_scaling_step_size = 10
      minimum_scaling_step_size = 1
      status                    = "ENABLED"
      target_capacity           = 90
    }
  }
}

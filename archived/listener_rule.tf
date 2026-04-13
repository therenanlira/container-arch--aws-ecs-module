resource "aws_lb_listener_rule" "ecs_listener_rule" {
  listener_arn = var.service_listener_arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs_target_group.arn
  }

  condition {
    host_header {
      values = var.service_hosts
    }
  }
}
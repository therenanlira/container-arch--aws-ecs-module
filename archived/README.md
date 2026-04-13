# container-arch--aws-ecs
<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_appautoscaling_policy.ecs_cpu_scale_in](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |
| [aws_appautoscaling_policy.ecs_cpu_scale_out](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |
| [aws_appautoscaling_policy.ecs_target_cpu_tracking](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |
| [aws_appautoscaling_policy.ecs_target_requests_tracking](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |
| [aws_appautoscaling_target.ecs_target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_target) | resource |
| [aws_cloudwatch_log_group.log_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_metric_alarm.ecs_cpu_scale_in_alarm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.ecs_cpu_scale_out_alarm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_ecs_service.ecs_service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_ecs_task_definition.ecs_task_definition](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_iam_role.service_execution_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.service_execution_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_lb_listener_rule.ecs_listener_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule) | resource |
| [aws_lb_target_group.ecs_target_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_security_group.ecs_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_alb.alb_arn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/alb) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alb_arn"></a> [alb\_arn](#input\_alb\_arn) | The ARN of the ALB | `string` | `null` | no |
| <a name="input_capabilities"></a> [capabilities](#input\_capabilities) | The capabilities for the task definition | `list(string)` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The name of the ECS cluster | `string` | n/a | yes |
| <a name="input_container_image"></a> [container\_image](#input\_container\_image) | The container image to run | `string` | n/a | yes |
| <a name="input_efs_volumes"></a> [efs\_volumes](#input\_efs\_volumes) | The EFS volumes for the task definition | <pre>list(object({<br/>    volume_name      = string<br/>    file_system_id   = string<br/>    file_system_root = string<br/>    mount_point      = string<br/>    read_only        = bool<br/>  }))</pre> | `[]` | no |
| <a name="input_environment_variables"></a> [environment\_variables](#input\_environment\_variables) | The environment variables for the task definition | <pre>list(object({<br/>    name  = string<br/>    value = string<br/>  }))</pre> | n/a | yes |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | The SSM parameter name for the private subnet 1 | `list(string)` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The region where the resources will be created | `string` | n/a | yes |
| <a name="input_scale_cpu_tracking"></a> [scale\_cpu\_tracking](#input\_scale\_cpu\_tracking) | The name of the CPU tracking resource | `number` | `50` | no |
| <a name="input_scale_in_adjustment"></a> [scale\_in\_adjustment](#input\_scale\_in\_adjustment) | The number of tasks to add when scaling in | `number` | `-1` | no |
| <a name="input_scale_in_comparison_operator"></a> [scale\_in\_comparison\_operator](#input\_scale\_in\_comparison\_operator) | The comparison operator for scaling in | `string` | `"LessThanOrEqualToThreshold"` | no |
| <a name="input_scale_in_cooldown"></a> [scale\_in\_cooldown](#input\_scale\_in\_cooldown) | The cooldown for scaling in | `number` | `60` | no |
| <a name="input_scale_in_cpu_threshold"></a> [scale\_in\_cpu\_threshold](#input\_scale\_in\_cpu\_threshold) | The CPU threshold for scaling in | `number` | `30` | no |
| <a name="input_scale_in_evaluation_periods"></a> [scale\_in\_evaluation\_periods](#input\_scale\_in\_evaluation\_periods) | The evaluation periods for scaling in | `number` | `2` | no |
| <a name="input_scale_in_period"></a> [scale\_in\_period](#input\_scale\_in\_period) | The period for scaling in | `number` | `60` | no |
| <a name="input_scale_in_statistic"></a> [scale\_in\_statistic](#input\_scale\_in\_statistic) | The statistic for scaling in | `string` | `"Average"` | no |
| <a name="input_scale_out_adjustment"></a> [scale\_out\_adjustment](#input\_scale\_out\_adjustment) | The number of tasks to add when scaling out | `number` | `1` | no |
| <a name="input_scale_out_comparison_operator"></a> [scale\_out\_comparison\_operator](#input\_scale\_out\_comparison\_operator) | The comparison operator for scaling out | `string` | `"GreaterThanOrEqualToThreshold"` | no |
| <a name="input_scale_out_cooldown"></a> [scale\_out\_cooldown](#input\_scale\_out\_cooldown) | The cooldown for scaling out | `number` | `30` | no |
| <a name="input_scale_out_cpu_threshold"></a> [scale\_out\_cpu\_threshold](#input\_scale\_out\_cpu\_threshold) | The CPU threshold for scaling out | `number` | `50` | no |
| <a name="input_scale_out_evaluation_periods"></a> [scale\_out\_evaluation\_periods](#input\_scale\_out\_evaluation\_periods) | The evaluation periods for scaling out | `number` | `2` | no |
| <a name="input_scale_out_period"></a> [scale\_out\_period](#input\_scale\_out\_period) | The period for scaling out | `number` | `30` | no |
| <a name="input_scale_out_statistic"></a> [scale\_out\_statistic](#input\_scale\_out\_statistic) | The statistic for scaling out | `string` | `"Average"` | no |
| <a name="input_scale_requests_tracking"></a> [scale\_requests\_tracking](#input\_scale\_requests\_tracking) | The name of the requests tracking resource | `number` | `30` | no |
| <a name="input_scale_type"></a> [scale\_type](#input\_scale\_type) | The scale type for the task definition | `string` | n/a | yes |
| <a name="input_secrets"></a> [secrets](#input\_secrets) | Secret Manager or Parameter Store list of secrets | <pre>list(object({<br/>    name      = string<br/>    valueFrom = string<br/>  }))</pre> | `[]` | no |
| <a name="input_service_cpu"></a> [service\_cpu](#input\_service\_cpu) | The number of CPU units to reserve for the service | `number` | n/a | yes |
| <a name="input_service_healthcheck"></a> [service\_healthcheck](#input\_service\_healthcheck) | The healthcheck for the service | `map(string)` | n/a | yes |
| <a name="input_service_hosts"></a> [service\_hosts](#input\_service\_hosts) | The hosts for the service | `list(string)` | n/a | yes |
| <a name="input_service_launch_type"></a> [service\_launch\_type](#input\_service\_launch\_type) | The launch type for the service | <pre>list(object({<br/>    capacity_provider = string<br/>    weight            = number<br/>  }))</pre> | <pre>[<br/>  {<br/>    "capacity_provider": "SPOT",<br/>    "weight": 100<br/>  }<br/>]</pre> | no |
| <a name="input_service_listener_arn"></a> [service\_listener\_arn](#input\_service\_listener\_arn) | The listener rule for the service | `string` | n/a | yes |
| <a name="input_service_memory"></a> [service\_memory](#input\_service\_memory) | The amount of memory to reserve for the service | `number` | n/a | yes |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | The name of the ECS service | `string` | n/a | yes |
| <a name="input_service_port"></a> [service\_port](#input\_service\_port) | The port on which the service listens | `number` | n/a | yes |
| <a name="input_service_task_count"></a> [service\_task\_count](#input\_service\_task\_count) | The number of tasks to run | `number` | n/a | yes |
| <a name="input_service_task_execution_role_arn"></a> [service\_task\_execution\_role\_arn](#input\_service\_task\_execution\_role\_arn) | The task execution role for the service | `string` | n/a | yes |
| <a name="input_task_maximum"></a> [task\_maximum](#input\_task\_maximum) | The maximum number of tasks to run | `number` | n/a | yes |
| <a name="input_task_minimum"></a> [task\_minimum](#input\_task\_minimum) | The minimum number of tasks to run | `number` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The SSM parameter name for the VPC ID | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
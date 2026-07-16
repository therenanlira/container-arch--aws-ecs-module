# CloudWatch Log Group

resource "aws_cloudwatch_log_group" "main" {
  name = "${local.name_prefix}-loggroup"

  tags = merge(local.tags, {
    Name = "${local.name_prefix}-loggroup"
  })
}

resource "aws_efs_file_system" "main" {
  creation_token   = "${local.name_prefix}-efs"
  performance_mode = var.performance_mode
  throughput_mode  = var.throughput_mode

  tags = {
    Name = "${local.name_prefix}-efs"
  }
}

resource "aws_efs_mount_target" "main" {
  for_each = var.network_values.private_subnet_ids

  file_system_id = aws_efs_file_system.main.id
  subnet_id      = each.value

  security_groups = [
    aws_security_group.efs.id
  ]
}

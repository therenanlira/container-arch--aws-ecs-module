# Variables

output "service_name" {
  value = var.service_name
}

output "performance_mode" {
  value = var.performance_mode
}

output "throughput_mode" {
  value = var.throughput_mode
}

# General

output "arn" {
  value = aws_efs_file_system.main.arn
}

output "id" {
  value = aws_efs_file_system.main.id
}

output "name" {
  value = aws_efs_file_system.main.name
}

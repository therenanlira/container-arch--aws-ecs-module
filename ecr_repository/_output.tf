# Variables

output "service_name" {
  value = var.service_name
}

output "name" {
  value = aws_ecr_repository.main.name
}

output "repository_url" {
  value = aws_ecr_repository.main.repository_url
}

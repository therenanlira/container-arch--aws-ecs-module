locals {
  name_prefix = "${terraform.workspace}--${var.project_name}-"

  tags = {
    Project     = var.project_name
    Region      = data.aws_region.current.region
    Environment = var.environment
    Workspace   = terraform.workspace
    ManagedBy   = "Terraform"
  }
}

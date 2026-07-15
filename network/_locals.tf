locals {
  name_prefix = "${terraform.workspace}--${var.project_name}-"

  subnet_private_blocks = cidrsubnet(var.cidr_block, 2, 0)
  subnet_public_blocks  = cidrsubnet(var.cidr_block, 2, 1)
  subnet_data_blocks    = cidrsubnet(var.cidr_block, 2, 2)

  vpc_azs = toset(slice(data.aws_availability_zones.available.names, 0, var.subnet_count))

  tags = {
    Project     = var.project_name
    Region      = data.aws_region.current.region
    Environment = var.environment
    Workspace   = terraform.workspace
    ManagedBy   = "Terraform"
  }
}

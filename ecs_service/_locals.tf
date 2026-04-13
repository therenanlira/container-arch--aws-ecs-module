locals {
  name_prefix = "${terraform.workspace}--${var.service_name}-"

  tags = {
    Service = var.service_name
  }
}

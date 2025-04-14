locals {
  sd_resource_name = "sd-service"
}

resource "aws_service_discovery_service" "sd_service" {
  count = var.sd_namespace != null ? 1 : 0
  name  = "${var.cluster_name}--${local.sd_resource_name}"

  dns_config {
    namespace_id = var.sd_namespace

    dns_records {
      ttl  = 10
      type = "A"
    }

    routing_policy = "MULTIVALUE"
  }

  health_check_custom_config {
    failure_threshold = 1
  }

  tags = {
    Name = "${var.cluster_name}--${local.sd_resource_name}"
  }
}
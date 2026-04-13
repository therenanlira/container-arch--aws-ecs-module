workspaces = {
  dev = {
    allowed_accounts = ["923672208632"]
    environment      = "dev"
    aws_region       = "us-east-1"

    project_name = "container-arch"

    service_name       = ""
    cluster_name       = ""
    vpc_id             = ""
    private_subnet_ids = []
    service_port       = 80
    service_cpu        = 256
    service_memory     = 512
    service_listener   = 80
  }
}

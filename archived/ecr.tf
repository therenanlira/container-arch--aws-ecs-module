# resource "aws_ecr_repository" "ecr_repository" {
#   name = "${var.cluster_name}/${var.service_name}"

#   force_delete = true
#   image_scanning_configuration {
#     scan_on_push = true
#   }

#   tags = {
#     Name     = "${var.service_name}/${var.service_name}"
#     Resource = "ecr-repository"
#   }
# }
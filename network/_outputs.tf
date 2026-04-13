########################################
########### Variables
########################################

output "project_name" {
  description = "The name of the project, used for tagging and naming resources."
  value       = var.project_name
}

output "cidr_block" {
  description = "The CIDR block for the VPC."
  value       = var.cidr_block
}

output "subnet_count" {
  description = "The number of subnets created in the VPC."
  value       = var.subnet_count
}

output "vpce_gateways" {
  description = "A list of AWS services for which VPC endpoints were created."
  value       = var.vpce_gateways
}

########################################
########### Network
########################################

output "vpc_id" {
  value = aws_vpc.main.id
}

output "private_subnet_ids" {
  value = { for az in local.vpc_azs : az => aws_subnet.these_private[az].id }
}

output "public_subnet_ids" {
  value = { for az in local.vpc_azs : az => aws_subnet.these_public[az].id }
}

output "data_subnet_ids" {
  value = { for az in local.vpc_azs : az => aws_subnet.these_data[az].id }
}

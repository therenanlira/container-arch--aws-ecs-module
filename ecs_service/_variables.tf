# General

variable "network_values" {
  description = "The network configuration for the ECS cluster, including VPC and subnets."
  type = object({
    vpc_id             = string
    private_subnet_ids = map(string)
  })
}

variable "project_name" {
  description = "The name of the project, used for tagging and naming resources."
  type        = string
}

variable "cluster_name" {
  description = "The ARN of the ECS cluster where the service will be deployed."
  type        = string
}

variable "service_name" {
  description = "The name of the ECS service."
  type        = string
}

variable "service_port" {
  description = "The port on which the service will listen."
  type        = number
}

variable "service_cpu" {
  description = "The number of CPU units to reserve for the service."
  type        = number
}

variable "service_mem" {
  description = "The amount of memory (in MiB) to reserve for the service."
  type        = number
}

variable "service_healthcheck" {
  description = "A map with health check values"
  type        = map(string)
}

variable "service_launch_type" {
  description = "The ECS Service Launch Type"
  type        = string
  validation {
    condition     = strcontains(var.service_launch_type, "EC2")
    error_message = "The acceptable values are: \"EC2\" or \"spot\""
  }
}

variable "service_task_count" {
  description = "The amount of tasks that will be running"
  type        = number
}

variable "service_hosts" {
  description = "List of hosts to be used in ECS Service"
  type        = list(string)
}

variable "service_listener" {
  description = "The Load Balancer Listener to be forwarded for"
  type        = string
}

# Task Definition

variable "capabilities" {
  description = "A list of acceptable capabilities"
  type        = list(string)
  validation {
    condition     = contains(var.capabilities, "EC2")
    error_message = "The list must contains one or all of these values: [\"EC2\"]"
  }
}

variable "environment_variables" {
  description = "A list of map containing the environemnt variables"
  type        = list(map(string))
}

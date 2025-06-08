variable "name_prefix" {
  type        = string
  description = "Prefix for resource names"
}

variable "ecs_asg_arn" {
  type        = string
  description = "ARN of the ECS Auto Scaling Group"
}

variable "execution_role_arn" {
  type        = string
  description = "ARN of the ECS task execution role"
}

variable "task_role_arn" {
  type        = string
  description = "ARN of the ECS task role"
}

variable "subnet1_id" {
  type        = string
  description = "ID of the first subnet"
}

variable "subnet2_id" {
  type        = string
  description = "ID of the second subnet"
}

variable "security_group_id" {
  type        = string
  description = "Security group ID for the ECS service"
}

variable "target_group_arn" {
  type        = string
  description = "ARN of the ECS target group"
}

variable "image" {
  type        = string
  description = "Docker image to use for the ECS task"
  default     = "public.ecr.aws/g7c4w4n7/hello123:latest" # Example image
}

variable "task_cpu" {
  type        = number
  description = "CPU units for the ECS task"
  default     = 1024
}

variable "task_memory" {
  type        = number
  description = "Memory for the ECS task (MB)"
  default     = 2048
}

variable "container_cpu" {
  type        = number
  description = "CPU units for the container"
  default     = 512
}

variable "container_memory" {
  type        = number
  description = "Memory for the container (MB)"
  default     = 1024
}

variable "container_port" {
  type        = number
  description = "Port for the container"
  default     = 80
}

variable "desired_count" {
  type        = number
  description = "Desired number of tasks in the ECS service"
  default     = 2
}

variable "target_capacity" {
  type        = number
  description = "Target capacity for the ECS capacity provider"
  default     = 3
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all resources"
  default     = {}
}

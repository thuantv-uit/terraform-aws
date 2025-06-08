variable "aws_region" {
  type        = string
  description = "AWS region"
  default     = "us-east-1"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "name_prefix" {
  type        = string
  description = "Prefix for resource names"
  default     = "thuantv"
}

variable "availability_zone_1" {
  type        = string
  description = "First availability zone"
  default     = "us-east-1a"
}

variable "availability_zone_2" {
  type        = string
  description = "Second availability zone"
  default     = "us-east-1b"
}

variable "ami_id" {
  type        = string
  description = "AMI ID for the ECS-optimized EC2 instances"
  default     = "ami-0e9bbd70d26d7cf4f" # Có thể thay bằng AMI mới nhất
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
  default     = "t3.medium"
}

variable "ebs_volume_size" {
  type        = number
  description = "Size of the EBS volume in GB"
  default     = 30
}

variable "asg_desired_capacity" {
  type        = number
  description = "Desired capacity of the Auto Scaling Group"
  default     = 2
}

variable "asg_max_size" {
  type        = number
  description = "Maximum size of the Auto Scaling Group"
  default     = 3
}

variable "asg_min_size" {
  type        = number
  description = "Minimum size of the Auto Scaling Group"
  default     = 1
}

variable "ecs_image" {
  type        = string
  description = "Docker image to use for the ECS task"
  default     = "public.ecr.aws/g7c4w4n7/hello123:latest" # Replace with your Docker image
}

variable "ecs_task_cpu" {
  type        = number
  description = "CPU units for the ECS task"
  default     = 1024
}

variable "ecs_task_memory" {
  type        = number
  description = "Memory for the ECS task (MB)"
  default     = 2048
}

variable "ecs_container_cpu" {
  type        = number
  description = "CPU units for the container"
  default     = 512
}

variable "ecs_container_memory" {
  type        = number
  description = "Memory for the container (MB)"
  default     = 1024
}

variable "ecs_container_port" {
  type        = number
  description = "Port for the container"
  default     = 80
}

variable "ecs_desired_count" {
  type        = number
  description = "Desired number of tasks in the ECS service"
  default     = 2
}

variable "ecs_target_capacity" {
  type        = number
  description = "Target capacity for the ECS capacity provider"
  default     = 3
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all resources"
  default = {
    Environment = "production"
    Project     = "myapp"
  }
}

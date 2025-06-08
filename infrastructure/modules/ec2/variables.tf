variable "name_prefix" {
  type        = string
  description = "Prefix for resource names"
  default     = "my"
}

variable "ami_id" {
  type        = string
  description = "AMI ID for the ECS-optimized EC2 instances"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
  default     = "t3.medium"
}

variable "key_name" {
  type        = string
  description = "Name of the EC2 key pair"
}

variable "ebs_volume_size" {
  type        = number
  description = "Size of the EBS volume in GB"
  default     = 30
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
  description = "ID of the security group"
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC"
}

variable "iam_instance_profile_name" {
  type        = string
  description = "Name of the IAM instance profile"
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

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all resources"
  default     = {}
}

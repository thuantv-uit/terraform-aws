variable "aws_region" {
  type        = string
  description = "AWS region for the VPC"
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
  description = "Availability Zone for the first subnet"
  default     = "us-east-1a"
}

variable "availability_zone_2" {
  type        = string
  description = "Availability Zone for the second subnet"
  default     = "us-east-1b"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all resources"
  default     = {}
}

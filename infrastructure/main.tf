terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.4"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# Tạo cặp khóa RSA
resource "tls_private_key" "ecs_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Tạo EC2 Key Pair trong AWS
resource "aws_key_pair" "ecs_key" {
  key_name   = "${var.name_prefix}-ecs-key"
  public_key = tls_private_key.ecs_key.public_key_openssh
}

# Lưu private key vào file cục bộ
resource "local_file" "ecs_private_key" {
  content         = tls_private_key.ecs_key.private_key_pem
  filename        = "${path.module}/my-ecs-key.pem"
  file_permission = "0400"
}

module "vpc" {
  source              = "./modules/vpc"
  aws_region          = var.aws_region
  vpc_cidr            = var.vpc_cidr
  name_prefix         = var.name_prefix
  availability_zone_1 = var.availability_zone_1
  availability_zone_2 = var.availability_zone_2
  tags = {
    Environment = "production"
    Project     = "thuantv"
  }
}

module "ec2" {
  source                    = "./modules/ec2"
  name_prefix               = var.name_prefix
  ami_id                    = var.ami_id
  instance_type             = var.instance_type
  key_name                  = aws_key_pair.ecs_key.key_name
  ebs_volume_size           = var.ebs_volume_size
  subnet1_id                = module.vpc.subnet1_id
  subnet2_id                = module.vpc.subnet2_id
  security_group_id         = module.vpc.security_group_id
  vpc_id                    = module.vpc.vpc_id
  iam_instance_profile_name = module.vpc.test_profile_name
  asg_desired_capacity      = var.asg_desired_capacity
  asg_max_size              = var.asg_max_size
  asg_min_size              = var.asg_min_size
  tags                      = var.tags
}

module "ecs" {
  source             = "./modules/ecs"
  name_prefix        = var.name_prefix
  ecs_asg_arn        = module.ec2.ecs_asg_arn
  execution_role_arn = module.vpc.ecs_task_execution_role_arn
  task_role_arn      = module.vpc.ecs_task_role_arn
  subnet1_id         = module.vpc.subnet1_id
  subnet2_id         = module.vpc.subnet2_id
  security_group_id  = module.vpc.security_group_id
  target_group_arn   = module.ec2.ecs_tg_arn
  image              = var.ecs_image
  task_cpu           = var.ecs_task_cpu
  task_memory        = var.ecs_task_memory
  container_cpu      = var.ecs_container_cpu
  container_memory   = var.ecs_container_memory
  container_port     = var.ecs_container_port
  desired_count      = var.ecs_desired_count
  target_capacity    = var.ecs_target_capacity
  tags               = var.tags
}

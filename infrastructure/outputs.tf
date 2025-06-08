output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "subnet1_id" {
  description = "The ID of the first subnet"
  value       = module.vpc.subnet1_id
}

output "subnet2_id" {
  description = "The ID of the second subnet"
  value       = module.vpc.subnet2_id
}

output "security_group_id" {
  description = "The ID of the security group"
  value       = module.vpc.security_group_id
}

output "test_profile_name" {
  description = "The name of the IAM instance profile"
  value       = module.vpc.test_profile_name
}

output "test_role_name" {
  description = "The name of the IAM role"
  value       = module.vpc.test_role_name
}

output "ecs_task_execution_role_arn" {
  description = "ARN of the ECS Task Execution Role"
  value       = module.vpc.ecs_task_execution_role_arn
}

output "ecs_task_role_arn" {
  description = "ARN of the ECS Task Role"
  value       = module.vpc.ecs_task_role_arn
}

output "ecs_instance_role_arn" {
  description = "ARN of the EC2 Instance Role"
  value       = module.vpc.ecs_instance_role_arn
}

output "ecs_lt_id" {
  description = "The ID of the ECS Launch Template"
  value       = module.ec2.ecs_lt_id
}

output "ecs_asg_arn" {
  description = "The ARN of the ECS Auto Scaling Group"
  value       = module.ec2.ecs_asg_arn
}

output "ecs_alb_arn" {
  description = "The ARN of the ECS Application Load Balancer"
  value       = module.ec2.ecs_alb_arn
}

output "ecs_tg_arn" {
  description = "The ARN of the ECS Target Group"
  value       = module.ec2.ecs_tg_arn
}

output "ecs_cluster_arn" {
  description = "ARN of the ECS cluster"
  value       = module.ecs.ecs_cluster_arn
}

output "ecs_task_definition_arn" {
  description = "ARN of the ECS task definition"
  value       = module.ecs.ecs_task_definition_arn
}

output "ecs_service_name" {
  description = "Name of the ECS service"
  value       = module.ecs.ecs_service_name
}

output "ecs_key_name" {
  description = "Name of the EC2 Key Pair"
  value       = aws_key_pair.ecs_key.key_name
}

output "private_key_file" {
  description = "Path to the private key file for SSH access"
  value       = local_file.ecs_private_key.filename
}

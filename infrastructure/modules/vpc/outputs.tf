output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "subnet1_id" {
  description = "The ID of the first subnet"
  value       = aws_subnet.subnet1.id
}

output "subnet2_id" {
  description = "The ID of the second subnet"
  value       = aws_subnet.subnet2.id
}

output "security_group_id" {
  description = "The ID of the security group"
  value       = aws_security_group.security_group.id
}

output "test_profile_name" {
  description = "The name of the IAM instance profile"
  value       = aws_iam_instance_profile.test_profile.name
}

output "test_role_name" {
  description = "The name of the IAM role"
  value       = aws_iam_role.role.name
}

output "ecs_task_execution_role_arn" {
  description = "ARN of the ECS Task Execution Role"
  value       = aws_iam_role.ecs_task_execution_role.arn
}

output "ecs_task_role_arn" {
  description = "ARN of the ECS Task Role"
  value       = aws_iam_role.ecs_task_role.arn
}

output "ecs_instance_role_arn" {
  description = "ARN of the EC2 Instance Role"
  value       = aws_iam_role.role.arn
}

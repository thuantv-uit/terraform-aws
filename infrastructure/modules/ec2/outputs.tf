output "ecs_lt_id" {
  description = "The ID of the ECS Launch Template"
  value       = aws_launch_template.ecs_lt.id
}

output "ecs_asg_arn" {
  description = "The ARN of the ECS Auto Scaling Group"
  value       = aws_autoscaling_group.ecs_asg.arn
}

output "ecs_alb_arn" {
  description = "The ARN of the ECS Application Load Balancer"
  value       = aws_lb.ecs_alb.arn
}

output "ecs_tg_arn" {
  description = "The ARN of the ECS Target Group"
  value       = aws_lb_target_group.ecs_tg.arn
}

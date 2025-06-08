output "codecommit_repository_arn" {
  value       = module.codecommit.repository_arn
  description = "ARN của kho lưu trữ CodeCommit"
}

output "codecommit_clone_url_http" {
  value       = module.codecommit.clone_url_http
  description = "URL HTTPS để clone kho lưu trữ CodeCommit"
}

output "ecr_repository_url" {
  value       = module.ecr.repository_url
  description = "URL của kho lưu trữ ECR"
}

output "codecommit_role_arn" {
  value       = module.iam_roles.codecommit_role_arn
  description = "ARN của vai trò IAM cho CodeCommit"
}

output "codebuild_role_arn" {
  value       = module.iam_roles.codebuild_role_arn
  description = "ARN của vai trò IAM cho CodeBuild"
}

output "codepipeline_role_arn" {
  value       = module.iam_roles.codepipeline_role_arn
  description = "ARN của vai trò IAM cho CodePipeline"
}

output "ecs_role_arn" {
  value       = module.iam_roles.ecs_role_arn
  description = "ARN của vai trò IAM cho ECS"
}

output "codebuild_project_arn" {
  value       = module.codebuild.project_arn
  description = "ARN của dự án CodeBuild"
}

output "codebuild_project_name" {
  value       = module.codebuild.project_name
  description = "Tên của dự án CodeBuild"
}

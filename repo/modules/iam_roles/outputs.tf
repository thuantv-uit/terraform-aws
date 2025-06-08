output "codecommit_role_arn" {
  value       = aws_iam_role.codecommit.arn
  description = "ARN của vai trò IAM cho CodeCommit"
}

output "codebuild_role_arn" {
  value       = aws_iam_role.codebuild.arn
  description = "ARN của vai trò IAM cho CodeBuild"
}

output "codepipeline_role_arn" {
  value       = aws_iam_role.codepipeline.arn
  description = "ARN của vai trò IAM cho CodePipeline"
}

output "ecs_role_arn" {
  value       = aws_iam_role.ecs.arn
  description = "ARN của vai trò IAM cho ECS"
}

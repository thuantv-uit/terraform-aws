output "project_arn" {
  value       = aws_codebuild_project.build_project.arn
  description = "ARN của dự án CodeBuild"
}

output "project_name" {
  value       = aws_codebuild_project.build_project.name
  description = "Tên của dự án CodeBuild"
}

output "codepipeline_arn" {
  description = "ARN of the CodePipeline"
  value       = aws_codepipeline.ecs_pipeline.arn
}

output "codepipeline_name" {
  description = "Name of the CodePipeline"
  value       = aws_codepipeline.ecs_pipeline.name
}

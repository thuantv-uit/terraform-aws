output "codepipeline_arn" {
  description = "ARN of the CodePipeline"
  value       = module.codepipeline.codepipeline_arn
}

output "codepipeline_name" {
  description = "Name of the CodePipeline"
  value       = module.codepipeline.codepipeline_name
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "pipeline_name" {
  description = "Name of the CodePipeline"
  type        = string
}

variable "codecommit_repository_arn" {
  description = "ARN of the CodeCommit repository"
  type        = string
}

variable "codecommit_repository_name" {
  description = "Name of the CodeCommit repository"
  type        = string
}

variable "codebuild_project_name" {
  description = "Name of the CodeBuild project"
  type        = string
}

variable "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
}

variable "ecs_service_name" {
  description = "Name of the ECS service"
  type        = string
}

variable "codepipeline_role_arn" {
  description = "ARN of the IAM role for CodePipeline"
  type        = string
}

variable "artifact_bucket_name" {
  description = "Name of the S3 bucket for pipeline artifacts"
  type        = string
}

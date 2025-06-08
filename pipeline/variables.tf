variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "pipeline_name" {
  description = "Name of the CodePipeline"
  type        = string
  default     = "thuan-codepipeline"
}

variable "codecommit_repository_arn" {
  description = "ARN of the CodeCommit repository"
  type        = string
  default     = "arn:aws:iam::211125312293:role/thuan-CodeCommitFullAccessRole"
}

variable "codecommit_repository_name" {
  description = "Name of the CodeCommit repository"
  type        = string
  default     = "thuan-codecommit-repo"
}

variable "codebuild_project_name" {
  description = "Name of the CodeBuild project"
  type        = string
  default     = "thuan-codebuild-project"
}

variable "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
  default     = "my-ecs-cluster"
}

variable "ecs_service_name" {
  description = "Name of the ECS service"
  type        = string
  default     = "myu-ecs-service"
}

variable "codepipeline_role_arn" {
  description = "ARN of the IAM role for CodePipeline"
  type        = string
  default     = "arn:aws:iam::211125312293:role/thuan-CodePipelineFullAccessRole"

}

variable "artifact_bucket_name" {
  description = "Name of the S3 bucket for pipeline artifacts"
  type        = string
  default     = "thuan-codepipeline-artifacts"
}

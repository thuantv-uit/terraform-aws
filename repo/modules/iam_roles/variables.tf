variable "codecommit_role_name" {
  description = "Tên của vai trò IAM cho CodeCommit"
  type        = string
}

variable "codebuild_role_name" {
  description = "Tên của vai trò IAM cho CodeBuild"
  type        = string
}

variable "codepipeline_role_name" {
  description = "Tên của vai trò IAM cho CodePipeline"
  type        = string
}

variable "ecs_role_name" {
  description = "Tên của vai trò IAM cho ECS"
  type        = string
}

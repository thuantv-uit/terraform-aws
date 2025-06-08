variable "region" {
  description = "Khu vực AWS để triển khai tài nguyên"
  type        = string
  default     = "us-east-1"
}

variable "codecommit_repository_name" {
  description = "Tên của kho lưu trữ CodeCommit"
  type        = string
  default     = "thuan-codecommit-repo"
}

variable "codecommit_repository_description" {
  description = "Mô tả của kho lưu trữ CodeCommit"
  type        = string
  default     = "Kho lưu trữ CodeCommit được tạo bởi Terraform"
}

variable "ecr_repository_name" {
  description = "Tên của kho lưu trữ ECR"
  type        = string
  default     = "thuan-ecr-repo"
}

variable "codecommit_role_name" {
  description = "Tên của vai trò IAM cho CodeCommit"
  type        = string
  default     = "thuan-CodeCommitFullAccessRole"
}

variable "codebuild_role_name" {
  description = "Tên của vai trò IAM cho CodeBuild"
  type        = string
  default     = "thuan-CodeBuildFullAccessRole"
}

variable "codepipeline_role_name" {
  description = "Tên của vai trò IAM cho CodePipeline"
  type        = string
  default     = "thuan-CodePipelineFullAccessRole"
}

variable "ecs_role_name" {
  description = "Tên của vai trò IAM cho ECS"
  type        = string
  default     = "thuan-ECSFullAccessRole"
}


variable "codebuild_project_name" {
  description = "Tên của dự án CodeBuild"
  type        = string
  default     = "thuan-codebuild-project"
}

variable "codebuild_project_description" {
  description = "Mô tả của dự án CodeBuild"
  type        = string
  default     = "Dự án CodeBuild để xây dựng image container"
}

variable "buildspec" {
  description = "Nội dung hoặc đường dẫn tới tệp buildspec.yml"
  type        = string
  default     = "buildspec.yml"
}

variable "codebuild_compute_type" {
  description = "Loại máy tính cho môi trường build"
  type        = string
  default     = "BUILD_GENERAL1_SMALL"
}

variable "codebuild_build_image" {
  description = "Image Docker cho môi trường build"
  type        = string
  default     = "aws/codebuild/standard:4.0"
}

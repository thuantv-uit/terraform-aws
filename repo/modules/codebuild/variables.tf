variable "project_name" {
  description = "Tên của dự án CodeBuild"
  type        = string
}

variable "project_description" {
  description = "Mô tả của dự án CodeBuild"
  type        = string
  default     = "Dự án CodeBuild để xây dựng image container"
}

variable "codecommit_clone_url_http" {
  description = "URL HTTPS của kho lưu trữ CodeCommit"
  type        = string
}

variable "ecr_repository_url" {
  description = "URL của kho lưu trữ ECR"
  type        = string
}

variable "codebuild_role_arn" {
  description = "ARN của vai trò IAM cho CodeBuild"
  type        = string
}

variable "buildspec" {
  description = "Nội dung hoặc đường dẫn tới tệp buildspec.yml"
  type        = string
  default     = "buildspec.yml"
}

variable "compute_type" {
  description = "Loại máy tính cho môi trường build"
  type        = string
  default     = "BUILD_GENERAL1_SMALL"
}

variable "build_image" {
  description = "Image Docker cho môi trường build"
  type        = string
  default     = "aws/codebuild/standard:5.0"
}

resource "aws_codebuild_project" "build_project" {
  name         = var.project_name
  description  = var.project_description
  service_role = var.codebuild_role_arn

  # Nguồn mã từ CodeCommit
  source {
    type      = "CODECOMMIT"
    location  = var.codecommit_clone_url_http
    buildspec = var.buildspec
  }

  # Môi trường build
  environment {
    compute_type                = var.compute_type
    image                       = var.build_image
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true # Cần cho Docker build

    environment_variable {
      name  = "ECR_REPOSITORY_URL"
      value = var.ecr_repository_url
    }
  }

  # Artifact (không cần lưu artifact vì đẩy trực tiếp vào ECR)
  artifacts {
    type = "NO_ARTIFACTS"
  }

  tags = {
    Name = var.project_name
  }
}

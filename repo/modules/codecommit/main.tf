resource "aws_codecommit_repository" "repository" {
  repository_name = var.repository_name
  description     = var.repository_description

  tags = {
    Name = var.repository_name
  }
}

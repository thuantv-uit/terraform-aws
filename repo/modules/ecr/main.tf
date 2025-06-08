resource "aws_ecr_repository" "repository" {
  name = var.repository_name

  tags = {
    Name = var.repository_name
  }
}

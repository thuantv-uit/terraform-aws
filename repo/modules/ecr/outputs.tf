output "repository_url" {
  value       = aws_ecr_repository.repository.repository_url
  description = "URL của kho lưu trữ ECR"
}

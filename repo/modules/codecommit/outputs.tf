output "repository_arn" {
  value       = aws_codecommit_repository.repository.arn
  description = "ARN của kho lưu trữ CodeCommit"
}

output "clone_url_http" {
  value       = aws_codecommit_repository.repository.clone_url_http
  description = "URL HTTPS để clone kho lưu trữ CodeCommit"
}

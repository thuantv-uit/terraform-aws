output "access_key_id" {
  value       = aws_iam_access_key.user_key.id
  sensitive   = true
  description = "Access Key ID của IAM user"
}

output "secret_access_key" {
  value       = aws_iam_access_key.user_key.secret
  sensitive   = true
  description = "Secret Access Key của IAM user"
}

output "git_credentials" {
  value = {
    username = aws_iam_service_specific_credential.codecommit_git_credentials.service_user_name
    password = aws_iam_service_specific_credential.codecommit_git_credentials.service_password
  }
  sensitive   = true
  description = "Thông tin xác thực HTTPS Git cho AWS CodeCommit"
}

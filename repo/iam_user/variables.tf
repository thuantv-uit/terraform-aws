variable "region" {
  description = "Khu vực AWS để triển khai tài nguyên"
  type        = string
  default     = "us-east-1"
}

variable "user_name" {
  description = "Tên của IAM user"
  type        = string
  default     = "thuan_iam"
}

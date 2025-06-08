resource "aws_iam_user" "user" {
  name = var.user_name
  path = "/"

  tags = {
    Name = var.user_name
  }
}

resource "aws_iam_user_policy_attachment" "admin_access" {
  user       = aws_iam_user.user.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_access_key" "user_key" {
  user = aws_iam_user.user.name
}

resource "aws_iam_service_specific_credential" "codecommit_git_credentials" {
  user_name    = aws_iam_user.user.name
  service_name = "codecommit.amazonaws.com"
}

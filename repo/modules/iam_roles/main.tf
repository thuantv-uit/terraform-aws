# Vai trò IAM cho CodeCommit
resource "aws_iam_role" "codecommit" {
  name = var.codecommit_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "codecommit.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name = var.codecommit_role_name
  }
}

resource "aws_iam_role_policy_attachment" "codecommit_policy" {
  role       = aws_iam_role.codecommit.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeCommitFullAccess"
}

# Vai trò IAM cho CodeBuild
resource "aws_iam_role" "codebuild" {
  name = var.codebuild_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "codebuild.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name = var.codebuild_role_name
  }
}

# Chính sách codeBuildBatchPolicy
resource "aws_iam_policy" "codebuild_batch_policy" {
  name        = "codeBuildBatchPolicy"
  description = "Policy for CodeBuild batch operations"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Resource = [
          "arn:aws:codebuild:us-east-1:211125312293:project/simplehttp-cb"
        ]
        Action = [
          "codebuild:StartBuild",
          "codebuild:StopBuild",
          "codebuild:RetryBuild"
        ]
      }
    ]
  })
}

# Gắn chính sách codeBuildBatchPolicy vào vai trò
resource "aws_iam_role_policy_attachment" "codebuild_batch_policy_attachment" {
  role       = aws_iam_role.codebuild.name
  policy_arn = aws_iam_policy.codebuild_batch_policy.arn
}

# Chính sách codeBuildServiceRolePolicy
resource "aws_iam_policy" "codebuild_service_role_policy" {
  name        = "codeBuildServiceRolePolicy"
  description = "Policy for CodeBuild service role permissions"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "VisualEditor0"
        Effect = "Allow"
        Action = [
          "ecr:GetDownloadUrlForLayer",
          "ecr:GetAuthorizationToken",
          "codecommit:GitPull",
          "s3:GetBucketAcl",
          "logs:CreateLogGroup",
          "logs:PutLogEvents",
          "s3:PutObject",
          "s3:GetObject",
          "logs:CreateLogStream",
          "ecr:BatchGetImage",
          "s3:GetBucketLocation",
          "s3:GetObjectVersion",
          "ecr:BatchCheckLayerAvailability"
        ]
        Resource = "*"
      }
    ]
  })
}

# Gắn chính sách codeBuildServiceRolePolicy vào vai trò
resource "aws_iam_role_policy_attachment" "codebuild_service_role_policy_attachment" {
  role       = aws_iam_role.codebuild.name
  policy_arn = aws_iam_policy.codebuild_service_role_policy.arn
}

# Gắn chính sách AmazonEC2ContainerRegistryPowerUser
resource "aws_iam_role_policy_attachment" "codebuild_ecr_policy" {
  role       = aws_iam_role.codebuild.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
}

# Vai trò IAM cho CodePipeline
resource "aws_iam_role" "codepipeline" {
  name = var.codepipeline_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "codepipeline.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name = var.codepipeline_role_name
  }
}

resource "aws_iam_role_policy_attachment" "codepipeline_policy" {
  role       = aws_iam_role.codepipeline.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCodePipeline_FullAccess"
}

resource "aws_iam_role_policy_attachment" "codepipeline_ecr_policy" {
  role       = aws_iam_role.codepipeline.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
}

resource "aws_iam_role_policy_attachment" "codepipeline_codebuild_policy" {
  role       = aws_iam_role.codepipeline.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeBuildAdminAccess"
}

resource "aws_iam_role_policy_attachment" "codepipeline_codecommit_policy" {
  role       = aws_iam_role.codepipeline.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeCommitFullAccess"
}

# Vai trò IAM cho ECS
resource "aws_iam_role" "ecs" {
  name = var.ecs_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ecs.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name = var.ecs_role_name
  }
}

resource "aws_iam_role_policy_attachment" "ecs_policy" {
  role       = aws_iam_role.ecs.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonECS_FullAccess"
}

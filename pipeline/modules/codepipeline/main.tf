resource "aws_s3_bucket" "artifact_bucket" {
  bucket = var.artifact_bucket_name
  tags = {
    Name        = "${var.pipeline_name}-artifacts"
    Environment = "production"
  }
}

resource "aws_s3_bucket_ownership_controls" "artifact_bucket_ownership" {
  bucket = aws_s3_bucket.artifact_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "artifact_bucket_acl" {
  bucket     = aws_s3_bucket.artifact_bucket.id
  acl        = "private"
  depends_on = [aws_s3_bucket_ownership_controls.artifact_bucket_ownership]
}

resource "aws_codepipeline" "ecs_pipeline" {
  name     = var.pipeline_name
  role_arn = var.codepipeline_role_arn

  artifact_store {
    location = aws_s3_bucket.artifact_bucket.bucket
    type     = "S3"
  }

  stage {
    name = "Source"
    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeCommit"
      version          = "1"
      output_artifacts = ["source_output"]
      configuration = {
        RepositoryName       = var.codecommit_repository_name
        BranchName           = "main"
        PollForSourceChanges = "true"
      }
    }
  }

  stage {
    name = "Build"
    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      configuration = {
        ProjectName = var.codebuild_project_name
      }
    }
  }

  stage {
    name = "Deploy"
    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "ECS"
      version         = "1"
      input_artifacts = ["build_output"]
      configuration = {
        ClusterName = var.ecs_cluster_name
        ServiceName = var.ecs_service_name
        FileName    = "imagedefinitions.json"
      }
    }
  }

  tags = {
    Name        = var.pipeline_name
    Environment = "production"
  }
}

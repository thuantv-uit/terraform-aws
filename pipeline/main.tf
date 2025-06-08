terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

module "codepipeline" {
  source                     = "./modules/codepipeline"
  region                     = var.region
  pipeline_name              = var.pipeline_name
  codecommit_repository_arn  = var.codecommit_repository_arn
  codecommit_repository_name = var.codecommit_repository_name
  codebuild_project_name     = var.codebuild_project_name
  ecs_cluster_name           = var.ecs_cluster_name
  ecs_service_name           = var.ecs_service_name
  codepipeline_role_arn      = var.codepipeline_role_arn
  artifact_bucket_name       = var.artifact_bucket_name
}

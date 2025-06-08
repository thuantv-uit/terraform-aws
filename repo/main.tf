provider "aws" {
  region = var.region
}

module "codecommit" {
  source                 = "./modules/codecommit"
  repository_name        = var.codecommit_repository_name
  repository_description = var.codecommit_repository_description
}

module "ecr" {
  source          = "./modules/ecr"
  repository_name = var.ecr_repository_name
}

module "iam_roles" {
  source                 = "./modules/iam_roles"
  codecommit_role_name   = var.codecommit_role_name
  codebuild_role_name    = var.codebuild_role_name
  codepipeline_role_name = var.codepipeline_role_name
  ecs_role_name          = var.ecs_role_name
}

module "codebuild" {
  source                    = "./modules/codebuild"
  project_name              = var.codebuild_project_name
  project_description       = var.codebuild_project_description
  codecommit_clone_url_http = module.codecommit.clone_url_http
  ecr_repository_url        = module.ecr.repository_url
  codebuild_role_arn        = module.iam_roles.codebuild_role_arn
  buildspec                 = var.buildspec
  compute_type              = var.codebuild_compute_type
  build_image               = var.codebuild_build_image
}

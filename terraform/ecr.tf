resource "aws_ecr_repository" "flask_app" {
  name         = var.ecr_repo_name
  force_delete = true
}
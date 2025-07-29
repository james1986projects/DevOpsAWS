# Only create the ECR repository in prod
resource "aws_ecr_repository" "flask_app" {
  count        = var.environment == "prod" ? 1 : 0
  name         = var.ecr_repo_name
  force_delete = true
}

# In test, read the existing repo created by prod
data "aws_ecr_repository" "flask_app" {
  count = var.environment == "test" ? 1 : 0
  name  = var.ecr_repo_name
}

# Use this to reference the repo URL regardless of environment
output "ecr_repo_url" {
  value = coalesce(
    try(aws_ecr_repository.flask_app[0].repository_url, null),
    try(data.aws_ecr_repository.flask_app[0].repository_url, null)
  )
}

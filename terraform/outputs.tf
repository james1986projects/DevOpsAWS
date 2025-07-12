#outputs.tf

output "alb_dns_name" {
  value = aws_lb.flask_alb.dns_name
}

output "ecs_cluster_name" {
  value = aws_ecs_cluster.flask_cluster.name
}

output "ecs_service_name" {
  value = aws_ecs_service.flask_service.name
}

output "ecr_repo_url" {
  value = aws_ecr_repository.flask_app.repository_url
}

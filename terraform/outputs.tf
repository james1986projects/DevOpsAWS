output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = aws_lb.flask_alb.dns_name
}

output "ecr_repo_url" {
  description = "ECR repository URL for the Flask app"
  value       = aws_ecr_repository.flask_app.repository_url
}

output "ecs_cluster_name" {
  description = "ECS Cluster Name"
  value       = aws_ecs_cluster.flask_cluster.name
}

output "ecs_service_name" {
  description = "ECS Service Name"
  value       = aws_ecs_service.flask_service.name
}

output "app_url" {
  description = "Public URL of the deployed application"
  value       = "devopsjames.com"
}

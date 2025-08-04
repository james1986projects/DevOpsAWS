output "app_url" {
  value = module.app_stack.app_url
}

output "alb_dns_name" {
  value = module.app_stack.alb_dns_name
}

output "ecs_cluster_name" {
  value = module.app_stack.ecs_cluster_name
}

output "ecs_service_name" {
  value = module.app_stack.ecs_service_name
}

output "ecr_repo_url" {
  value = module.app_stack.ecr_repo_url
}

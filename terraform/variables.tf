variable "region" {
  description = "AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Deployment environment name (e.g. test, prod)"
  type        = string
}

variable "domain_name" {
  description = "Root domain name (e.g. devopsjames.com)"
  type        = string
}

variable "subdomain" {
  description = "Subdomain for this environment (e.g. www, test)"
  type        = string
}

variable "ecs_desired_count" {
  description = "Desired number of ECS tasks to run"
  type        = number
}

variable "ecs_min_capacity" {
  description = "Minimum number of ECS tasks"
  type        = number
}

variable "ecs_max_capacity" {
  description = "Maximum number of ECS tasks"
  type        = number
}

variable "container_cpu" {
  description = "CPU units to allocate to the container"
  type        = number
}

variable "container_memory" {
  description = "Memory (in MB) to allocate to the container"
  type        = number
}

variable "image_tag" {
  description = "Docker image tag"
  type        = string
  default     = "latest"
}

variable "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
  default     = "flask-cluster"
}

variable "ecs_service_name" {
  description = "Name of the ECS service"
  type        = string
  default     = "flask-service"
}

variable "ecr_repo_name" {
  description = "Name of the ECR repository"
  type        = string
  default     = "flask-app"
}

variable "project_name" {
  description = "Project name for naming resources"
  type        = string
  default     = "secure-aws-webapp"
}

variable "dynamodb_table_name" {
  description = "DynamoDB table name"
  type        = string
  default     = "my-flask-app-table"
}

variable "acm_certificate_arn" {
  description = "ACM certificate ARN for HTTPS"
  type        = string
}

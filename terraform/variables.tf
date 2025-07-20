#variables.tf

variable "region" {
  default = "us-east-1"
}

variable "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  default     = "flask-cluster"
}

variable "ecs_service_name" {
  description = "Name of the ECS service"
  default     = "flask-service"
}

variable "image_tag" {
  description = "Docker image tag"
  default     = "latest"
}

variable "ecs_max_capacity" {
  description = "Maximum number of ECS tasks"
  type        = number
  default     = 4
}

variable "ecs_min_capacity" {
  description = "Minimum number of ECS tasks"
  type        = number
  default     = 1
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

variable "environment" {
  type        = string
  description = "Deployment environment name (e.g. test, prod)"
  default     = "dev"
}

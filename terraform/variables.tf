variable "region" {
  default = "us-east-1"
}

variable "environment" {
  description = "Deployment environment name (e.g., test, prod)"
  type        = string
}

variable "ecs_min_capacity" {
  type = number
}

variable "ecs_max_capacity" {
  type = number
}

variable "image_tag" {
  type = string
}

variable "ecs_cluster_name" {
  default = "flask-cluster"
}

variable "ecs_service_name" {
  default = "flask-service"
}

variable "ecr_repo_name" {
  default = "flask-app"
}

variable "project_name" {
  default = "secure-aws-webapp"
}

variable "dynamodb_table_name" {
  default = "my-flask-app-table"
}

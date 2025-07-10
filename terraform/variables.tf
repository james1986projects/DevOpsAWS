#vaitables.tf

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "dynamodb_table_name" {
  type        = string
  description = "Name of the DynamoDB table"
  default     = "flask-data"
}

variable "ecr_repo_name" {
  type        = string
  description = "Name of the ECR repository"
  default     = "flask-app"
}

variable "ecs_cpu" {
  type        = string
  description = "CPU units for the ECS task"
  default     = "256"
}

variable "ecs_memory" {
  type        = string
  description = "Memory for the ECS task in MiB"
  default     = "512"
}

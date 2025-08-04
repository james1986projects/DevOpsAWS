variable "acm_certificate_arn" {
  type        = string
  description = "ACM certificate for HTTPS"
}

variable "image_tag" {
  type        = string
  description = "Docker image tag to deploy"
}

variable "environment" {
  type        = string
  description = "Deployment environment (test or prod)"
}

variable "ecs_min_capacity" {
  type        = number
  description = "Minimum number of ECS tasks"
}

variable "ecs_max_capacity" {
  type        = number
  description = "Maximum number of ECS tasks"
}

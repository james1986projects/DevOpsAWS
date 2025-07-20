#variables.tf for test environment

variable "acm_certificate_arn" {
  type        = string
  description = "ACM cert for HTTPS"
}

variable "image_tag" {
  type        = string
  default     = "latest"
}

variable "environment" {
  type        = string
  default     = "test"
}

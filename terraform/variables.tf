###variables.tf
variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1" # or whatever region you're using
}

###variables.tf
variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1" # or whatever region you're using
}

variable "dynamodb_table_name" {
  type        = string
  description = "The name of the DynamoDB table for the ECS task to access"
}

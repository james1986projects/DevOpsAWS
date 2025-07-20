#cloudwatch.tf

resource "aws_cloudwatch_log_group" "flask_log_group" {
  name = "/ecs/${var.environment}/flask"
  retention_in_days = 7
}
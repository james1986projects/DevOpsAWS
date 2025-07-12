#cloudwatch.tf

resource "aws_cloudwatch_log_group" "flask_log_group" {
  name              = "/ecs/flask-app"
  retention_in_days = 7
}

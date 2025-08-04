#ecs.tf

resource "aws_ecs_cluster" "flask_cluster" {
  name = "${var.environment}-${var.ecs_cluster_name}"
}

resource "aws_ecs_task_definition" "flask_task" {
  family                   = "${var.environment}-flask-task"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_app_role.arn
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode([{
    name      = "flask-container"
    image = "${coalesce(
  try(aws_ecr_repository.flask_app[0].repository_url, null),
  try(data.aws_ecr_repository.flask_app[0].repository_url, null)
)}:${var.image_tag}"
    essential = true
    portMappings = [{
      containerPort = 5000
      hostPort      = 5000
    }]
    logConfiguration = {
      logDriver = "awslogs"
      options = {
        awslogs-group         = aws_cloudwatch_log_group.flask_log_group.name
        awslogs-region        = var.region
        awslogs-stream-prefix = "flask"
      }
    }
  }])

  depends_on = [
    aws_cloudwatch_log_group.flask_log_group,
    aws_iam_role.ecs_task_execution_role,
    aws_iam_role.ecs_task_app_role
  ]
}

resource "aws_ecs_service" "flask_service" {
  name            = "${var.environment}-${var.ecs_service_name}"
  cluster         = aws_ecs_cluster.flask_cluster.id
  task_definition = aws_ecs_task_definition.flask_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  health_check_grace_period_seconds = 60

  deployment_circuit_breaker {
    enable   = true
    rollback = true
  }

  network_configuration {
    subnets          = data.aws_subnets.default.ids
    assign_public_ip = true
    security_groups  = [aws_security_group.ecs_sg.id]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.flask_tg.arn
    container_name   = "flask-container"
    container_port   = 5000
  }

  # Ensure ECS service only starts after ALB + listeners are fully ready
  depends_on = [
    aws_lb_listener.http,
    aws_lb_listener.https
  ]
}

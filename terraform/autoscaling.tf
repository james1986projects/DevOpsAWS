#autoscaling.tf

resource "aws_appautoscaling_target" "ecs_service" {
  max_capacity       = var.ecs_max_capacity
  min_capacity       = var.ecs_min_capacity
  resource_id        = "service/${aws_ecs_cluster.flask_cluster.name}/${aws_ecs_service.flask_service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"

 depends_on = [aws_ecs_service.flask_service]
}

resource "aws_appautoscaling_policy" "scale_out" {
   name              = "${var.environment}-${var.project_name}-scale-out-policy"
  service_namespace  = "ecs"
  resource_id        = aws_appautoscaling_target.ecs_service.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_service.scalable_dimension
  policy_type        = "TargetTrackingScaling"

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }

    target_value       = 70.0
    scale_out_cooldown = 60
    scale_in_cooldown  = 120
  }
}

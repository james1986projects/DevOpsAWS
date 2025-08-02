#!/bin/bash
set -e

# --- Environment Variables for Terraform ---
export TF_VAR_environment=prod
export TF_VAR_image_tag=prod-latest
export MSYS_NO_PATHCONV=1

echo "Starting Terraform imports for PROD environment..."

# --- Security Groups ---
terraform import aws_security_group.alb_sg sg-029def392dd0901e2 || true
terraform import aws_security_group.ecs_sg sg-0639ab25e2d92cb83 || true

# --- ALB + Listeners + Target Group ---
terraform import aws_lb.flask_alb arn:aws:elasticloadbalancing:us-east-1:124482837913:loadbalancer/app/prod-flask-alb/db597be16de694df || true
terraform import aws_lb_target_group.flask_tg arn:aws:elasticloadbalancing:us-east-1:124482837913:targetgroup/prod-flask-tg/15235dc09d6d7d3a || true
terraform import aws_lb_listener.http arn:aws:elasticloadbalancing:us-east-1:124482837913:listener/app/prod-flask-alb/db597be16de694df/dbc176c9322be987 || true
terraform import aws_lb_listener.https arn:aws:elasticloadbalancing:us-east-1:124482837913:listener/app/prod-flask-alb/db597be16de694df/725c065135ce8f83 || true

# --- CloudWatch ---
terraform import aws_cloudwatch_log_group.flask_log_group /ecs/prod/flask || true

# --- DynamoDB ---
terraform import aws_dynamodb_table.flask_data prod-my-flask-app-table || true

# --- ECR ---
terraform import 'aws_ecr_repository.flask_app[0]' flask-app || true

# --- ECS ---
terraform import aws_ecs_cluster.flask_cluster prod-flask-cluster || true
terraform import aws_ecs_service.flask_service prod-flask-cluster/prod-flask-service || true
terraform import aws_ecs_task_definition.flask_task prod-flask-task || true

# --- IAM ---
terraform import aws_iam_role.ecs_task_execution_role prod-ecsTaskExecutionRole || true
terraform import aws_iam_role.ecs_task_app_role prod-ecsTaskAppRole || true
terraform import aws_iam_policy.dynamodb_policy arn:aws:iam::124482837913:policy/prod-ecs-dynamodb-access-policy || true
terraform import aws_iam_role_policy_attachment.ecs_execution_policy prod-ecsTaskExecutionRole/arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy || true
terraform import aws_iam_policy_attachment.dynamodb_policy_attach prod-ecs-dynamodb-access-policy || true

# --- Autoscaling ---
terraform import aws_appautoscaling_target.ecs_service service/prod-flask-cluster/prod-flask-service || true
terraform import aws_appautoscaling_policy.scale_out prod-secure-aws-webapp-scale-out-policy || true

# --- Route53 ---
terraform import aws_route53_record.root_domain Z09710571HRUUCYUCDJ4F_prod.devopsjames.com_A || true

echo "✅ All import attempts completed. Run 'terraform plan' to verify."

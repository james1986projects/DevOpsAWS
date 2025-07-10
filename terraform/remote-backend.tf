terraform {
  backend "s3" {
    bucket         = "secure-aws-webapp-tfstate"      
    key            = "terraform/ecs-fargate-app.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

terraform {
  backend "s3" {
    bucket         = "secure-aws-webapp-tfstate"
    key            = "env/test/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
  }
}
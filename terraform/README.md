# Terraform Infrastructure for Flask App on AWS Fargate

This Terraform configuration provisions a complete AWS infrastructure to run a Flask application in Docker on ECS Fargate, with DynamoDB for backend storage and CloudWatch for logging.

---

## 🗂️ Infrastructure Overview

The Terraform setup includes:

- VPC with public subnets and internet gateway  
- Application Load Balancer (ALB) for HTTP traffic  
- ECS Cluster & Fargate Service to run Docker containers  
- IAM Roles for ECS task execution and DynamoDB access  
- ECR Repository for storing the Docker image  
- DynamoDB Table for backend data  
- CloudWatch Logs for container logs  
- Terraform variables and outputs

---

## 📁 Project Structure

```
terraform/
├── alb.tf
├── cloudwatch.tf
├── ecr.tf
├── ecs.tf
├── iam.tf
├── main.tf
├── outputs.tf
├── variables.tf
├── vpc.tf
```

---

## 🔧 Prerequisites

- Terraform
- AWS CLI
- Docker
- AWS credentials configured (`aws configure`)

---

## 🚀 Deploying the Infrastructure

### 1. Initialize Terraform

```bash
cd terraform/
terraform init
```

### 2. Validate and Plan

```bash
terraform plan
```

### 3. Apply the Configuration

```bash
terraform apply
```

---

## 📦 Build and Push Docker Image to ECR

### 1. Authenticate Docker to ECR

```bash
aws ecr get-login-password --region <region> | \
docker login --username AWS --password-stdin <aws_account_id>.dkr.ecr.<region>.amazonaws.com
```

### 2. Build the Image

```bash
docker build -t flask-app .
```

### 3. Tag the Image

```bash
docker tag flask-app:latest <aws_account_id>.dkr.ecr.<region>.amazonaws.com/flask-app:latest
```

### 4. Push to ECR

```bash
docker push <aws_account_id>.dkr.ecr.<region>.amazonaws.com/flask-app:latest
```

---

## 🧪 Test the Deployed App

Use the ALB DNS name output by Terraform:

```bash
curl -X POST http://<alb-dns>/data \
  -H "Content-Type: application/json" \
  -d '{"value": "test123"}'

curl http://<alb-dns>/data
```

---

## 🔐 IAM & CloudWatch

- ECS Task IAM role allows access to DynamoDB and CloudWatch.
- Logs are available under `/ecs/flask-app` in CloudWatch Logs.

---

## 🧹 Destroy Infrastructure

```bash
terraform destroy
```

---

## 📌 Notes

- This setup is modular and production-ready.
- Future improvements: S3 static file hosting, HTTPS via ACM, CI/CD pipelines, autoscaling, and remote Terraform state.

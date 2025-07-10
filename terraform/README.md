# 🚀 Secure Flask Web App on AWS Fargate with Terraform

This project provisions a production-ready infrastructure on AWS to deploy a Flask application using Docker, ECS Fargate, and other AWS services. It includes remote Terraform state management with S3 and DynamoDB.

---

## 🧱 Project Overview

The infrastructure includes:

- **VPC** with public subnets and internet gateway  
- **ALB** (Application Load Balancer) to route HTTP traffic  
- **ECS Fargate** to run a containerized Flask app  
- **ECR** to store Docker images  
- **DynamoDB** as a backend key-value store  
- **CloudWatch Logs** for ECS container output  
- **Terraform Remote Backend** using S3 (with versioning + encryption) and DynamoDB (for state locking)

---

## 📁 Project Structure

```
secure-aws-webapp/
├── app/
│   ├── app.py
│   ├── Dockerfile
│   └── requirements.txt
├── terraform/
│   ├── alb.tf
│   ├── cloudwatch.tf
│   ├── ecr.tf
│   ├── ecs.tf
│   ├── iam.tf
│   ├── main.tf
│   ├── outputs.tf
│   ├── remote-backend.tf
│   ├── variables.tf
│   └── vpc.tf
├── terraform-backend/
│   └── backend-resources.tf
├── README.md
```

---

## ⚙️ Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/downloads)
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
- [Docker](https://www.docker.com/)
- AWS credentials configured using `aws configure`

---

## 🧰 Set Up Terraform Remote Backend (One-Time)

Provision S3 + DynamoDB for remote state storage:

```bash
cd terraform-backend/
terraform init
terraform apply
```

This creates:

- **S3 bucket**: `secure-aws-webapp-tfstate` with AES256 encryption and versioning  
- **DynamoDB table**: `terraform-locks` for safe locking of state files

---

## 🔗 Connect Terraform to Remote Backend

Once backend is created, configure the main Terraform project to use it:

```bash
cd ../terraform/
terraform init -migrate-state
```

This uses `remote-backend.tf` to point Terraform to your S3 + DynamoDB backend.

---

## 🚀 Deploy Infrastructure

From the `terraform/` directory:

### 1. Plan

```bash
terraform plan
```

### 2. Apply

```bash
terraform apply
```

Terraform provisions all required AWS infrastructure.

---

## 📦 Build and Push Flask App to ECR

### 1. Authenticate Docker to ECR

```bash
aws ecr get-login-password --region <region> | \
docker login --username AWS --password-stdin <aws_account_id>.dkr.ecr.<region>.amazonaws.com
```

### 2. Build and Tag the Docker Image

```bash
docker build -t flask-app .
docker tag flask-app:latest <aws_account_id>.dkr.ecr.<region>.amazonaws.com/flask-app:latest
```

### 3. Push Image to ECR

```bash
docker push <aws_account_id>.dkr.ecr.<region>.amazonaws.com/flask-app:latest
```

---

## 🔬 Test the Deployed Application

Once deployed, test your app using the ALB DNS name:

```bash
curl -X POST http://<alb-dns>/data \
  -H "Content-Type: application/json" \
  -d '{"value": "test123"}'

curl http://<alb-dns>/data
```

---

## 📚 CloudWatch Logging

- ECS container logs are available in **CloudWatch Logs** under `/ecs/flask-app`
- Useful for debugging and monitoring container output

---

## 🔐 IAM & Security

- **IAM Roles** grant secure access to required services:
  - ECS Task Role: DynamoDB read/write
  - Execution Role: CloudWatch + ECR pull
- **S3** state file encryption: AES256 encryption
- **DynamoDB** state locking prevents race conditions during deployment

---

## 🧹 Tear Down Infrastructure

### Destroy Application Infrastructure

```bash
cd terraform/
terraform destroy
```

### Destroy Remote Backend (if no longer needed)

```bash
cd ../terraform-backend/
terraform destroy
```

---

## 🧭 Future Enhancements

- ✅ HTTPS via ACM and Route 53  
- ✅ S3 versioning for backend bucket  
- 🔄 CI/CD deployment pipeline (GitHub Actions or CodePipeline)  
- 🔄 ECS autoscaling  
- 🔄 WAF + ALB rules for security  
- 🔄 Static file hosting on S3 (for frontend/static assets)

---

## 🔗 Project Repository

GitHub: [https://github.com/james1986projects/DevOpsAWS](https://github.com/james1986projects/DevOpsAWS)


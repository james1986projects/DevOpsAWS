# Terraform Infrastructure – Secure AWS Flask Web App

This directory contains the Terraform code used to provision the infrastructure for a secure, containerized Flask application deployed on AWS ECS Fargate behind an Application Load Balancer (ALB). It is part of the [DevOpsAWS Project](https://github.com/james1986projects/DevOpsAWS).

---

## Directory Structure

```
secure-aws-webapp/
├── app/                 # Flask application with Dockerfile
└── terraform/           # Infrastructure as Code using Terraform
    ├── main.tf
    ├── vpc.tf
    ├── ecs.tf
    ├── alb.tf
    ├── iam.tf
    ├── cloudwatch.tf
    ├── variables.tf
    ├── outputs.tf
```

---

## What This Terraform Code Does

The Terraform configuration provisions the following AWS infrastructure components:

### Core Infrastructure

- **VPC** with public/private subnets across two availability zones  
- **Internet Gateway** and route tables for external access  
- **Security Groups** for controlling inbound/outbound traffic  

### ECS & Compute

- **Elastic Container Registry (ECR)** to store the Flask Docker image  
- **ECS Cluster** using Fargate launch type  
- **Task Definition** for running the Docker container  
- **ECS Service** for deploying the app with Fargate  

### Load Balancing & Networking

- **Application Load Balancer (ALB)** with:
  - Listener on port 80 (HTTP)
  - Target group with type `ip` for Fargate
- Forwards web traffic to ECS tasks

### IAM Roles

- **ECS Task Execution Role** with ECR and CloudWatch access  
- Fine-grained IAM policies for secure access control  

### Monitoring & Logging

- **CloudWatch Log Groups** to capture container logs from ECS  

---

## Prerequisites

Before using Terraform:

- [Terraform CLI](https://developer.hashicorp.com/terraform/downloads) installed  
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) configured (`aws configure`)  
- Docker image built and pushed to ECR  
  See the [Flask App README](https://github.com/james1986projects/DevOpsAWS/blob/main/app/README.md) for build and push instructions.

---

## Usage

### 1. Clone the Repository

```bash
git clone https://github.com/james1986projects/DevOpsAWS.git
cd DevOpsAWS/terraform
```

### 2. Initialize Terraform

```bash
terraform init
```

### 3. Review the Plan

```bash
terraform plan
```

### 4. Apply the Configuration

```bash
terraform apply
```

Type `yes` to confirm when prompted.

---

## Outputs

After applying the Terraform configuration, the following outputs are provided:

- **ALB DNS Name** – Public URL to access the Flask web app  
- **ECS Service Name**  
- **ECS Cluster Name**

---

## Terraform State

This project currently uses **local Terraform state**.

For collaboration or production usage, it is recommended to use a **remote backend**, such as:

- **Amazon S3** for state storage  
- **DynamoDB** for state locking  

---

## Optional Enhancements (Planned)

- ✅ CloudWatch logging for ECS tasks  
- ✅ HTTPS support using ACM and a secure ALB listener  
- ✅ ECS Service autoscaling based on CPU or memory usage  
- ✅ S3 bucket for static file hosting or failover routing  
- ✅ CI/CD pipeline using GitHub Actions or AWS CodePipeline  
- ✅ Remote Terraform backend with S3 and DynamoDB  

---

This project demonstrates practical skills in AWS architecture, DevOps workflows, Infrastructure as Code, and secure application deployment.

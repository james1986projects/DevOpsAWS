# 🚀 Secure AWS WebApp Deployment

This project demonstrates how to securely deploy a containerized Flask web application to AWS ECS Fargate using Docker and Terraform.

As part of my continued learning in DevOps and cloud architecture, I'm building a production-style deployment from the ground up. The architecture will evolve over time, and I'll document troubleshooting steps and lessons learned along the way.

---

## 🔧 Technologies Used

- AWS ECS Fargate  
- Docker  
- Amazon ECR  
- Application Load Balancer (ALB)  
- AWS CloudWatch  
- Terraform  
- Python Flask
- DynamoDB 

---

## 📌 Project Highlights

- Containerized Flask app with Docker  
- Infrastructure as Code using Terraform  
- Deployment to ECS Fargate with ALB routing  
- CloudWatch log aggregation  
- Modular and production-ready structure
- DynamoDB for backend data

---

## 🗂️ Project Structure

| Folder      | Description                          |
|-------------|--------------------------------------|
| `/app`      | Flask app + Docker setup             |
| `/terraform`| All Terraform configurations (IaC)   |
| `/docs`     | Optional: screenshots, diagrams      |

---

## 📸 Architecture Diagram

*Coming soon – a visual diagram of the infrastructure components.*

---

## 🚀 Quick Start

### Prerequisites
- AWS account
- Docker installed
- Terraform installed and configured

### Deploy the App

# Clone the repository
git clone https://github.com/james1986projects/DevOpsAWS.git

# Navigate to the Terraform configuration
cd DevOpsAWS/terraform

# Deploy the infrastructure
terraform init
terraform apply

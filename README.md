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
- DynamoDB  
- Terraform (Infrastructure as Code)  
- Python Flask (3.11)

---

## 📌 Project Highlights

✅ Containerized Flask app with Docker  
✅ Infrastructure as Code using Terraform  
✅ Deployed to ECS Fargate with ALB routing  
✅ CloudWatch log aggregation  
✅ DynamoDB backend for persistent data  
✅ Modular and production-ready structure  
✅ Scalable and extensible (CI/CD, HTTPS, autoscaling coming soon)

---

## 🗂️ Project Structure

| Folder       | Description                          |
|--------------|--------------------------------------|
| `/app`       | Flask application and Docker setup   |
| `/terraform` | Terraform infrastructure code (IaC)  |
| `/docs`      | Optional: screenshots, diagrams      |

---

## 📸 Architecture Diagram

Coming soon – a visual diagram of the infrastructure components.

---

## 🚀 Quick Start

### Prerequisites

- AWS account with credentials configured (`aws configure`)
- Docker installed
- Terraform installed

---

### 1. Clone the Repository

```bash
git clone https://github.com/james1986projects/DevOpsAWS.git
cd DevOpsAWS
```

---

### 2. Build and Push Docker Image to Amazon ECR

```bash
cd app/
docker build -t flask-app .
docker tag flask-app:latest <aws_account_id>.dkr.ecr.<region>.amazonaws.com/flask-app:latest
docker push <aws_account_id>.dkr.ecr.<region>.amazonaws.com/flask-app:latest
```

---

### 3. Deploy the Infrastructure with Terraform

```bash
cd ../terraform
terraform init
terraform apply
```

---

## 🌐 Test the Application

Use the Application Load Balancer DNS output by Terraform:

```bash
curl -X POST http://<alb-dns>/data \
  -H "Content-Type: application/json" \
  -d '{"value": "test123"}'

curl http://<alb-dns>/data
```

---

## 📊 Monitoring & Logs

- Logs are stored in **CloudWatch Logs** under `/ecs/flask-app`
- DynamoDB stores the data posted to `/data`

---

## 🧹 Teardown

To remove all infrastructure:

```bash
terraform destroy
```

---

## 🔭 Future Improvements

- Enable HTTPS with AWS ACM
- Add CI/CD (GitHub Actions or CodePipeline)
- Implement autoscaling for ECS
- Enable S3 for static file hosting or failover
- Use S3 + DynamoDB for remote Terraform state backend

---

## 📁 Related Files

- [`/app/README.md`](./app/README.md) – Flask app and Docker setup  
- [`/terraform/README.md`](./terraform/README.md) – AWS infrastructure with Terraform  

---


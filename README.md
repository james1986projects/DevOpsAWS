# Secure AWS WebApp Deployment 🚀

This project showcases how to securely deploy a containerized Python Flask web application to **AWS ECS Fargate** using **Terraform** and **Docker**. It's part of my ongoing learning in DevOps and AWS cloud architecture. The project is modular, production-oriented, and well-documented with lessons learned and troubleshooting notes.

The infrastructure is built with **Infrastructure as Code** (IaC) using Terraform, and will continue to evolve over time with new features like S3 static hosting and DynamoDB integration.

---

## 🔧 Tech Stack

- **AWS ECS Fargate**
- **Application Load Balancer (ALB)**
- **Amazon Elastic Container Registry (ECR)**
- **AWS CloudWatch**
- **Terraform**
- **Docker**
- **Python Flask**

---

## 📌 Project Highlights

- ✅ Containerized Flask app using Docker
- ✅ Infrastructure provisioned with Terraform
- ✅ Load-balanced ECS Fargate service
- ✅ Centralized logging with CloudWatch
- ✅ Clean, modular repo structure for scalability
- ✅ GitHub documentation with troubleshooting and diagrams

---

## 🗂️ Project Structure

| Folder       | Description                             |
|--------------|-----------------------------------------|
| `/app`       | Flask application and Dockerfile setup  |
| `/terraform` | All Terraform configurations (IaC)      |
| `/docs`      | Architecture diagrams and screenshots   |

---

## 📸 Architecture Diagram

📌 *Coming Soon*  
*(Will be added in `/docs/architecture.png` once created. See below for help on how to generate one.)*

---

## 🚀 Quick Start

**Note**: You’ll need an AWS account, Terraform installed, and Docker set up locally.

```bash
# 1. Clone the repo
git clone https://github.com/YOUR_USERNAME/secure-aws-webapp.git

# 2. Navigate to Terraform configuration
cd secure-aws-webapp/terraform

# 3. Deploy the infrastructure
terraform init
terraform apply
The Flask app will be deployed to ECS Fargate and accessible via a load balancer.

🧠 To-Do (Planned Improvements)
 Add HTTPS support (ACM + ALB)

 Integrate S3 for static file hosting or failover

 Add DynamoDB for backend storage

 Implement autoscaling for ECS tasks

 Add CI/CD pipeline via GitHub Actions

 Create and upload architecture diagram

🙋‍♂️ Author
James Peckitt

GitHub Profile

📧 james_peckitt1986@hotmail.com

📜 AWS Certified Solutions Architect – Associate

📜 CompTIA Security+ Certified

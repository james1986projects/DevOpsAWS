# Internal Feedback Collection Web App

![Deploy to Test](https://github.com/james1986projects/DevOpsAWS/actions/workflows/deploy-test.yml/badge.svg)
![Deploy to Prod](https://github.com/james1986projects/DevOpsAWS/actions/workflows/deploy-prod.yml/badge.svg)

🌐 **Live Demo:** [https://devopsjames.com](https://devopsjames.com)

This repository demonstrates a **production-grade, containerized Flask web application** deployed to **AWS ECS Fargate**, showcasing **cloud, DevOps, and CI/CD best practices**.  

Key highlights:

- **Infrastructure as Code** with Terraform (modular, multi-environment)  
- **Multi-environment CI/CD** via GitHub Actions (develop → test, main → prod)  
- **Secure & Scalable AWS Architecture** (ECR, ALB, ACM, DynamoDB, CloudWatch)  
- **Full observability & automation** with logging, autoscaling, and IaC

![Architecture](https://github.com/user-attachments/assets/a7a4efb8-a7b1-4152-b3ff-67252a538ffa)

---

## 📄 Documentation

- [CI/CD Pipeline Overview](./CICD.md)
- [Terraform Infrastructure](./terraform)
- [Flask Application Source](./app)

---

## 🔹 Project Overview

This **Internal Feedback Collection Web App** is a lightweight tool for collecting:

- Bug reports  
- Feature requests  
- General internal feedback

Ideal for **internal SaaS tools** or dashboards, it allows staff to quickly submit input to dev or support teams.

The project demonstrates how to:

- Design **scalable, secure AWS cloud infrastructure**  
- Automate deployments with **multi-environment CI/CD**  
- Apply **Infrastructure as Code (IaC)** principles with **Terraform**

---

## 🔹 Key Features

### **1. Scalability & Reliability**
- **AWS ECS Fargate** handles container orchestration without EC2 management  
- **Application Load Balancer (ALB)** provides high availability across AZs  
- **ECS Autoscaling** ensures the app adapts to load changes

### **2. Security**
- **HTTPS via ACM** encrypts traffic end-to-end  
- **Route 53 + ALB** manage DNS and SSL seamlessly  
- **IAM task roles** grant least-privilege access to **DynamoDB**  
- **Optional AWS WAF** for protection against XSS/SQLi attacks

### **3. Observability**
- **AWS CloudWatch Logs** capture application & infrastructure logs  
- Integrated with ECS for task-level logging

### **4. Automation & CI/CD**
- **GitHub Actions** builds & pushes Docker images to **Amazon ECR**  
- **ECS Service Deployment** automatically triggered on each branch push:
  - `develop` → Test Environment (`test-latest` image)
  - `main` → Production Environment (`prod-latest` image)

### **5. Infrastructure as Code**
- **Terraform Modules** manage VPC, ECS, ALB, IAM, DynamoDB, and logging  
- **Remote backend** (S3 + DynamoDB) prevents state drift in team workflows

---

## 🚀 Deployment Workflow

1. Developer pushes to `develop` → **Deploy to Test**  
2. Validate functionality in the test environment  
3. Merge `develop → main` → **Deploy to Production**

The CI/CD pipeline ensures **fast, repeatable, and safe deployments**.

---

## 🏆 Skills Demonstrated

- **Cloud Architecture** (AWS ECS, ALB, DynamoDB, ACM, CloudWatch)  
- **Infrastructure as Code** (Terraform with remote state)  
- **CI/CD & Automation** (GitHub Actions, Docker, ECR, ECS)  
- **Security Best Practices** (IAM least privilege, HTTPS, optional WAF)  
- **Scalable Application Deployment** with autoscaling & observability

---

# CI/CD Pipeline – Secure AWS Flask App

This project demonstrates a **production-grade DevOps workflow** using:

- **AWS ECS Fargate** (serverless container hosting)
- **Amazon ECR** (Docker image registry)
- **Elastic Load Balancer (HTTPS with ACM)**
- **Terraform** (Infrastructure as Code)
- **GitHub Actions** (CI/CD pipeline)

---

## **Pipeline Overview**

- **Branch strategy:**
  - `develop` → **Test Environment**
  - `main` → **Production Environment**

- **Pipeline Flow:**
  1. Developer commits code
  2. GitHub Actions triggers:
     - Builds Docker image
     - Tags image as `test-latest` or `prod-latest`
     - Pushes to **Amazon ECR**
     - Forces ECS service deployment
  3. ECS pulls the new image and replaces old tasks automatically

---

## **Deployment Steps**

1. Push to `develop` → Deploys to **Test**  
2. Validate functionality in test  
3. Merge `develop` → `main` → Deploys to **Production**

---

## **Key AWS Services**

- **ECS Fargate** – Containerized Flask app hosting  
- **ECR** – Stores immutable Docker images  
- **ALB + ACM** – HTTPS traffic handling  
- **DynamoDB** – Backend storage  
- **CloudWatch** – Centralized logging

---

## **GitHub Actions Workflows**

- `.github/workflows/deploy-test.yml`  
- `.github/workflows/deploy-prod.yml`  

### **Deploy to Test**
- Trigger: Push to `develop`  
- Tags Docker image: `test-latest`  
- Deploys ECS service: `test-flask-service`

### **Deploy to Prod**
- Trigger: Push to `main`  
- Tags Docker image: `prod-latest`  
- Deploys ECS service: `prod-flask-service`

---

## **CI/CD Benefits**

- **Automated multi-environment deployments**  
- **Immutable Docker image builds**  
- **Full Infrastructure as Code with Terraform**  
- **Follows Git Flow for safe production releases**

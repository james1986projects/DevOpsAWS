# Secure AWS Platform Deployment (DevOpsAWS)

Production-style AWS platform demonstrating Infrastructure as Code, containerised application deployment, and CI/CD automation in a multi-environment architecture.

---

## Overview

This project implements a secure, scalable cloud-native application platform deployed on AWS using Terraform and modern DevOps practices.

The architecture reflects real-world platform engineering patterns including multi-environment deployments, infrastructure automation, and container orchestration using ECS Fargate.

---

## Key Capabilities

- Infrastructure as Code using Terraform (modular, reusable architecture)
- Multi-environment CI/CD pipelines (develop → test → production)
- Container orchestration using AWS ECS Fargate
- Secure networking with ALB, ACM, and Route53
- Observability via CloudWatch logging and metrics
- IAM least privilege security model
- Automated deployments using GitHub Actions and Amazon ECR

---

## Deployment Model

- Develop branch → Test environment deployment
- Main branch → Production environment deployment
- Automated Docker image build and deployment via CI/CD pipeline

---

## AWS Services Used

ECS Fargate, ECR, ALB, ACM, Route53, CloudWatch, IAM, DynamoDB, S3, VPC

---

## Engineering Focus

This project demonstrates:

- Cloud platform engineering practices
- Infrastructure as Code design patterns
- Secure AWS architecture design
- CI/CD automation and release engineering
- Observability and operational readiness


## Internal Feedback Collection Web App

This Flask application is designed as a lightweight internal tool to collect user feedback, bug reports, and feature requests within an organization. It serves staff who interact with internal SaaS tools or dashboards and want a quick way to submit input to development or support teams.

The backend is powered by AWS DynamoDB for fast, scalable storage of structured feedback data. The entire application runs on AWS ECS Fargate behind an Application Load Balancer (ALB), with HTTPS and custom domain support via Route 53 and ACM. Logs are centralized in CloudWatch for observability.

While this is a simple app, the architecture is production-grade — designed with security, scalability, and automation in mind. It showcases DevOps best practices using:

- Infrastructure as Code (Terraform)
- Remote state storage (S3 + DynamoDB locking)
- Containerized deployment via ECS Fargate
- HTTPS and DNS via ACM and Route 53
- IAM roles for least-privilege access to DynamoDB
- Logging, monitoring, and autoscaling
- CI/CD pipeline integration via GitHub Actions

## Architecture

<img width="1536" height="1024" alt="architecturediamgram" src="https://github.com/user-attachments/assets/a7a4efb8-a7b1-4152-b3ff-67252a538ffa" />

## Project Features

This project demonstrates how to deploy and manage a scalable, secure, and observable Flask web application using AWS services and modern DevOps practices.

### Scalability & Reliability
- **ECS Fargate** removes the need to manage EC2 instances and handles container orchestration.
- **Application Load Balancer (ALB)** ensures high availability and distributes traffic across multiple availability zones.

### Security
- **HTTPS via ACM** encrypts data in transit with TLS certificates managed by AWS.
- **Route 53** manages a custom domain (`devopsjames.com`) with automatic DNS propagation.
- **IAM task roles** provide scoped, least-privilege access to the DynamoDB backend.
- **WAF** (optional) protects against threats like SQL injection and XSS. Although not strictly necessary for internal-only apps, it’s included to demonstrate secure practices.

### Monitoring & Observability
- **CloudWatch Logs** capture application and infrastructure logs for debugging and alerting.
- **ECS service autoscaling** ensures the app can respond to load increases.

### Infrastructure as Code
- **Terraform modules** manage the full infrastructure in a consistent, repeatable way.
- **Remote backend** uses S3 (for storage) and DynamoDB (for state locking) to support team workflows and prevent state drift.

### Automation & CI/CD
- **GitHub Actions** pipeline builds Docker images, pushes to ECR, and triggers ECS Fargate deployments.
- Supports rapid iteration and consistent delivery to production.

### Internal Tooling Use Case
- This setup is ideal for internal microtools that replace manual processes (like spreadsheets or emails).
- Scalable, secure, and production-ready — yet simple enough for fast iteration.

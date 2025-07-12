
## Internal Feedback Collection Web App

This Flask application is designed as a lightweight internal tool to collect user feedback, bug reports, and feature requests within an organization. It serves staff who interact with internal SaaS tools or dashboards and want a quick way to submit input to development or support teams.

The backend is powered by AWS DynamoDB for fast, scalable storage of structured feedback data. The entire application runs on AWS ECS Fargate behind an Application Load Balancer, providing automatic scaling and high availability. Logs are centralized in CloudWatch for observability.

While this is a simple app, the architecture is production-grade — designed with security, scalability, and automation in mind. It showcases DevOps best practices using:

- Infrastructure as Code (Terraform)
- Remote state storage (S3 + DynamoDB)
- Containerized deployment via ECS Fargate
- Logging, monitoring, and autoscaling
- Secure communication via HTTPS and optional WAF protections
- CI/CD pipeline integration via GitHub Actions

## Architecture

<img width="1536" height="1024" alt="architecturediamgram" src="https://github.com/user-attachments/assets/a7a4efb8-a7b1-4152-b3ff-67252a538ffa" />

## Project features

This project demonstrates how to deploy and manage a scalable, secure, and observable Flask web application using AWS services and modern DevOps practices.

### Scalability & Reliability
- **ECS Fargate** removes the need to manage EC2 instances and handles container orchestration.
- **Application Load Balancer (ALB)** ensures high availability and distributes traffic across multiple availability zones.

### Security
- **HTTPS via ACM** encrypts data in transit, securing user-submitted feedback.
- **WAF** provides protection against common threats like SQL injection and XSS attacks. Although this is not required for a strictly internal facing app, I'm including one in the project.
- **IAM roles and least-privilege access** are enforced via Terraform.

### Monitoring & Observability
- **CloudWatch Logs** capture application and infrastructure logs for debugging and alerting.
- **ECS service autoscaling** ensures the app responds to traffic spikes.

### Infrastructure as Code
- **Terraform modules** manage the full infrastructure in a consistent, repeatable way.
- **Remote state storage (S3 + DynamoDB)** supports team collaboration and prevents state drift.

### Automation & CI/CD
- **GitHub Actions** automates Docker builds, pushes to ECR, and deploys updates to ECS.
- Promotes rapid iteration and continuous delivery.

### Internal Tooling Use Case
- This setup is ideal for internal microtools that replace manual processes (like spreadsheets or emails).
- Scalable, secure, and production-ready — yet simple enough for fast iteration.

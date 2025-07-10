# Flask App Setup for AWS Fargate with Docker and DynamoDB

This guide explains how to create and run a Flask application using Docker, push it to Amazon ECR, and deploy it using Terraform to AWS ECS Fargate. The app integrates with DynamoDB to store and retrieve backend data.

---

## 🧠 App Overview

This Flask app exposes a `/data` endpoint:

- `POST /data` — Stores a new item in DynamoDB with a generated UUID.
- `GET /data` — Retrieves all items from DynamoDB.

---

## 🛠️ Requirements

- Python 3.11
- Flask
- Boto3 (for DynamoDB integration)

---

## 📁 App Structure

```
app/
├── app.py
├── requirements.txt
└── Dockerfile
```

---

## 🔧 Local Docker Build & Test (Optional)

You can test the app locally in Docker before pushing to ECR:

```bash
docker build -t flask-aws-app .
docker run -d -p 5000:5000 flask-aws-app
```

Then visit:

```
http://localhost:5000/data
```

---

## 🐳 Dockerfile

```Dockerfile
FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 5000

CMD ["python", "app.py"]
```

---

## 📦 requirements.txt

```
flask
boto3
```

---

## 🚀 Build and Push Docker Image to Amazon ECR

### 1. Authenticate Docker to ECR

```bash
aws ecr get-login-password --region <aws-region> | docker login --username AWS --password-stdin <aws_account_id>.dkr.ecr.<aws-region>.amazonaws.com
```

### 2. Build Docker Image

```bash
docker build -t flask-app:latest .
```

### 3. Tag Image for ECR

```bash
docker tag flask-app:latest <aws_account_id>.dkr.ecr.<aws-region>.amazonaws.com/flask-app:latest
```

### 4. Push Image to ECR

```bash
docker push <aws_account_id>.dkr.ecr.<aws-region>.amazonaws.com/flask-app:latest
```

✅ This image is referenced in the ECS Task Definition created by Terraform.

---

## ✅ Endpoint Usage

### Add Data to DynamoDB

```bash
curl -X POST http://<your-alb-dns>/data \
  -H "Content-Type: application/json" \
  -d '{"value": "test123"}'
```

**Response:**

```json
{
  "id": "e007d4fd-4838-488f-9507-8d8ec6cfa6c5",
  "message": "Item added"
}
```

### Retrieve All Items

```bash
curl http://<your-alb-dns>/data
```

---

## 🧪 Deployment & Testing Notes

- App deployed via ECS Fargate using Terraform
- Logs viewable in CloudWatch Logs under `/ecs/flask-app`
- DynamoDB table (`flask-data`) created via Terraform
- IAM roles scoped to allow `PutItem`, `GetItem`, `Scan`, etc.

---

## 📌 Previously: EC2-based Setup (Deprecated)

This project originally ran on an EC2 instance using Docker. It has since been migrated to ECS Fargate for scalability, automation, and best practices. The EC2 workflow is now deprecated.

---

## 🛠️ Troubleshooting Notes

- Initial issues with Flask/Python environment on EC2 (PEP 668) were resolved by containerizing with Docker.
- Docker now handles all lifecycle concerns—no systemd services or venv setup required.
- Removed legacy setup scripts and EC2-specific content from repo for clarity.

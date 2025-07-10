# Flask App for AWS Fargate with Docker and DynamoDB

This guide explains how to build a Flask application using Docker, push it to Amazon ECR, and deploy it with Terraform to AWS ECS Fargate.  
The app integrates with **DynamoDB** to store and retrieve backend data.

---

## App Overview

This Flask app exposes a `/data` endpoint:

- `POST /data` — Stores a new item in DynamoDB with a generated UUID.
- `GET /data` — Retrieves all items from DynamoDB.

---

## Requirements

- Python 3.11  
- Flask  
- boto3

---

## App Structure

app/
├── app.py
├── requirements.txt
└── Dockerfile

yaml
Copy
Edit

---

## Local Docker Build & Test (Optional)

You can test the app locally before pushing to ECR:

```bash
docker build -t flask-aws-app .
docker run -d -p 5000:5000 flask-aws-app
Visit in your browser:

bash
Copy
Edit
http://localhost:5000/data
Dockerfile
Dockerfile
Copy
Edit
FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 5000

CMD ["python", "app.py"]
requirements.txt
text
Copy
Edit
flask
boto3
Build and Push Docker Image to Amazon ECR
1. Authenticate Docker to ECR
bash
Copy
Edit
aws ecr get-login-password --region <aws-region> \
  | docker login --username AWS --password-stdin <aws_account_id>.dkr.ecr.<aws-region>.amazonaws.com
2. Build Docker Image
bash
Copy
Edit
docker build -t flask-app:latest .
3. Tag Docker Image
bash
Copy
Edit
docker tag flask-app:latest <aws_account_id>.dkr.ecr.<aws-region>.amazonaws.com/flask-app:latest
4. Push Image to ECR
bash
Copy
Edit
docker push <aws_account_id>.dkr.ecr.<aws-region>.amazonaws.com/flask-app:latest
This image is referenced in the ECS Task Definition created by Terraform.

API Usage
Add Data to DynamoDB
bash
Copy
Edit
curl -X POST http://<ALB-DNS-NAME>/data \
  -H "Content-Type: application/json" \
  -d '{"value": "test123"}'
Example response:

json
Copy
Edit
{
  "id": "e007d4fd-4838-488f-9507-8d8ec6cfa6c5",
  "message": "Item added"
}
Retrieve All Items
bash
Copy
Edit
curl http://<ALB-DNS-NAME>/data
Deployment & Testing Notes
Deployed to ECS Fargate using Terraform

DynamoDB table (flask-data) provisioned via Terraform

Logs viewable in CloudWatch Logs under /ecs/flask-app

ECS task IAM role scoped to allow necessary DynamoDB actions (PutItem, Scan, etc.)

Migration Note: EC2 Setup Deprecated
This project was originally hosted on an EC2 instance.
It has been fully migrated to ECS Fargate for scalability, maintainability, and automation benefits.

Troubleshooting
Docker simplifies environment setup and avoids Python installation issues (e.g., PEP 668 on Ubuntu 22.04)

No need for virtual environments or systemd — Docker manages lifecycle

Removed local EC2-specific setup and scripts for clarity

yaml
Copy
Edit

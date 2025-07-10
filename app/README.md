
🐍 Flask App Setup for AWS Fargate with Docker and DynamoDB
This guide explains how to build a Flask application using Docker, push it to Amazon ECR, and deploy it with Terraform to AWS ECS Fargate.
The app integrates with DynamoDB to store and retrieve backend data.

🧠 App Overview
This Flask app exposes a /data endpoint:

POST /data — Stores a new item in DynamoDB with a generated UUID.

GET /data — Retrieves all items from DynamoDB.

🛠️ App Requirements
Python 3.11

Flask

boto3 (for DynamoDB access)

📁 App Structure
Copy
Edit
app/
├── app.py
├── requirements.txt
└── Dockerfile
🔧 Local Docker Build & Test (Optional)
You can test locally before pushing to ECR:

bash
Copy
Edit
docker build -t flask-aws-app .
docker run -d -p 5000:5000 flask-aws-app
Visit in your browser:

bash
Copy
Edit
http://localhost:5000/data
🐳 Dockerfile
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
📦 requirements.txt
nginx
Copy
Edit
flask
boto3
🚀 Build and Push Docker Image to Amazon ECR
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
3. Tag Image for ECR
bash
Copy
Edit
docker tag flask-app:latest <aws_account_id>.dkr.ecr.<aws-region>.amazonaws.com/flask-app:latest
4. Push to ECR
bash
Copy
Edit
docker push <aws_account_id>.dkr.ecr.<aws-region>.amazonaws.com/flask-app:latest
✅ This image is referenced in the ECS Task Definition created by Terraform.

✅ API Usage
Add Data to DynamoDB
bash
Copy
Edit
curl -X POST http://<ALB-DNS-NAME>/data \
  -H "Content-Type: application/json" \
  -d '{"value": "test123"}'
Response:

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
🧪 Deployment & Testing Notes
App deployed via ECS Fargate using Terraform

DynamoDB table (flask-data) created with Terraform

Logs available in CloudWatch under /ecs/flask-app

ECS task IAM role allows necessary DynamoDB actions (PutItem, Scan, etc.)

📌 Previously: EC2-based Setup (Deprecated)
This project originally ran on an EC2 instance with manual Docker setup.
It has now been fully migrated to ECS Fargate for improved automation, scalability, and production readiness.

🛠 Troubleshooting Notes
Resolved initial issues with Flask setup and Python environment by using Docker

Simplified setup by removing local Python dependencies and EC2 configuration

Docker handles all dependencies, networking, and execution logic

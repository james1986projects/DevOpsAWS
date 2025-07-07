**Flask App Setup on EC2 with Docker**

This guide explains how to create and run the Flask application on an Ubuntu EC2 instance, containerized with Docker.

**Launch EC2 Instance**

Go to AWS Console EC2 > Launch Instance

Configure
Name: devops-webapp-instance
AMI: Ubuntu 22.04 LTS
Instance type: t2.micro
Storage: 8 GB gp3

Create a new key pair (.pem file) and download it**

Configure Security Group
Allow SSH (port 22)
Add Custom TCP rule: port 5000, source 0.0.0.0/0 (for Flask app)

Secure the PEM Key Locally
mkdir -p secure-aws-webapp/.ssh
mv /Downloads/your-key.pem > secure-aws-webapp/.ssh/

Give it the required permissions
chmod 400 secure-aws-webapp/.ssh/your-key.pem

**SSH into EC2**

Get your EC2 public IPv4 address from the console.
Connect via terminal
ssh -i .ssh/your-key.pem ubuntu@YOUR_EC2_PUBLIC_IP
Confirm prompt with yes

**Set up Flask and Docker on EC2**

sudo apt update && sudo apt upgrade -y
sudo apt install -y python3-pip docker.io
sudo usermod -aG docker $USER
newgrp docker
docker --version

**Create Flask App**

mkdir flask-docker-app && cd flask-docker-app
nano app.py

Paste in

from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello():
    return "Hello from your secure AWS deployment!"

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000)
    
Save and exit.

**Create requirements.txt**

echo "flask" > requirements.txt

**Create Dockerfile**

nano Dockerfile
Paste in

FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 5000

CMD ["python", "app.py"]

Save and exit

**Build and Run Docker Container**

docker build -t flask-aws-app .
docker run -d -p 5000:5000 flask-aws-app

**Access Flask App**

Open your browser and navigate to:

http://YOUR_EC2_PUBLIC_IP:5000

**Troubleshooting Notes**

Initially had connection refused due to missing Flask installation and Ubuntu 22.04’s PEP 668 enforcement. Using Docker bypasses this.

No need to setup systemd services or virtual environments, Docker manages app lifecycle.

Removed unnecessary start scripts and venv from repo for clarity.

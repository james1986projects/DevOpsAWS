FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Install any needed system dependencies (minimal for boto3/SSL)
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    libpq-dev \
 && rm -rf /var/lib/apt/lists/*

# Install Python dependencies first (cache layer)
COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip \
 && pip install --no-cache-dir -r requirements.txt

# Copy the app
COPY . .

# Expose Flask port
EXPOSE 5000

# Optional: Healthcheck for ECS (comment out if not needed)
# HEALTHCHECK --interval=30s --timeout=5s CMD curl -f http://localhost:5000/ || exit 1

# Default command
CMD ["gunicorn", "-b", "0.0.0.0:5000", "app:app"]



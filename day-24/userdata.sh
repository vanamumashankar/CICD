#!/bin/bash

# Update system packages
apt update -y

# Install Apache web server
apt install -y apache2

# Enable and start Apache
systemctl enable apache2
systemctl start apache2

# Get the instance ID using the instance metadata
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)

# Install AWS CLI (if needed)
apt install -y awscli

# Optional: Download images from S3 (ensure IAM role allows access)
# aws s3 cp s3://myterraformprojectbucket2023/project.webp /var/www/html/project.png --acl public-read

# Create HTML page
cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
  <title>My Portfolio</title>
  <style>
    @keyframes colorChange {
      0% { color: red; }
      50% { color: green; }
      100% { color: blue; }
    }
    h1 {
      animation: colorChange 2s infinite;
    }
  </style>
</head>
<body>
  <h1>Terraform Project Server 1</h1>
  <h2>Instance ID: <span style="color:green">$INSTANCE_ID</span></h2>
  <p>Welcome to Abhishek Veeramalla's Channel</p>
</body>
</html>
EOF

# Ensure Apache is running after creating the page
systemctl restart apache2

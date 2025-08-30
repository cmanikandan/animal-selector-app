#!/bin/bash

# Update system
sudo yum update -y

# Install Python 3 and pip
sudo yum install -y python3 python3-pip git

# Install nginx
sudo yum install -y nginx

# Create app directory
sudo mkdir -p /var/www/flask-app
cd /var/www/flask-app

# Clone or copy the app files (we'll upload them separately)
# For now, create the basic structure

# Install Flask
sudo pip3 install flask

# Create a simple systemd service for the Flask app
sudo tee /etc/systemd/system/flask-app.service > /dev/null <<EOF
[Unit]
Description=Flask App
After=network.target

[Service]
User=ec2-user
WorkingDirectory=/var/www/flask-app
ExecStart=/usr/bin/python3 app.py
Restart=always

[Install]
WantedBy=multi-user.target
EOF

# Configure nginx to proxy to Flask app
sudo tee /etc/nginx/conf.d/flask-app.conf > /dev/null <<EOF
server {
    listen 80;
    server_name _;

    location / {
        proxy_pass http://127.0.0.1:5000;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }
}
EOF

# Remove default nginx config
sudo rm -f /etc/nginx/conf.d/default.conf

# Start and enable services
sudo systemctl enable nginx
sudo systemctl start nginx
sudo systemctl enable flask-app

echo "Deployment script completed. Upload your Flask app files to /var/www/flask-app and start the flask-app service."

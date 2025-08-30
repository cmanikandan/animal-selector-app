# Animal Selector & File Upload App

Flask web application with animal selection and file upload functionality.

## Features
- Select animals (cat, dog, elephant) to display images
- Upload files to get name, size, and type information

## Local Setup
```bash
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
python app.py
```

Visit http://127.0.0.1:5000

## AWS EC2 Deployment

### Deployment Script
Use `deploy.sh` to set up the application on a fresh Amazon Linux 2 instance:

```bash
chmod +x deploy.sh
./deploy.sh
```

The script installs:
- Python 3, pip, and git
- Flask
- Nginx (reverse proxy)
- Systemd service for the Flask app

### SSH Access
```bash
ssh -i /path/to/your-key.pem ec2-user@<your-ec2-ip>
```

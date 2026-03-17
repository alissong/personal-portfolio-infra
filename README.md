# Personal Portfolio Infrastructure

Infrastructure as Code for deploying my personal portfolio on AWS using **Terraform**, **Docker**, and **Caddy** with automatic HTTPS.

The infrastructure provisions a complete environment where the application is automatically deployed from **Amazon ECR** and exposed securely via **HTTPS**.

---

# Architecture

The infrastructure provisions the following components:

- **EC2 (t3.micro)** – hosts the application containers
- **Elastic IP** – static public IP for the server
- **Route53** – DNS management
- **ECR (Elastic Container Registry)** – stores the portfolio Docker image
- **IAM Role** – allows the EC2 instance to:
  - connect via SSM
  - pull images from ECR
- **Security Groups**
  - allow HTTP (80)
  - allow HTTPS (443)

Inside the EC2 instance:

- **Docker**
- **Docker Compose**
- **Caddy Web Server**
- Automatic HTTPS via **Let's Encrypt**

---

# Infrastructure Diagram

```
Internet
   │
   ▼
Route53
   │
   ▼
Elastic IP
   │
   ▼
EC2 (Docker Host)
   │
   ├── Caddy (Reverse Proxy + HTTPS)
   │
   └── Portfolio Container (NGINX + React build)
```

---

# Deployment Flow

```
GitHub (portfolio repo)
      │
      ▼
Docker Build
      │
      ▼
Push Image
      │
      ▼
Amazon ECR
      │
      ▼
EC2 Instance
      │
      ▼
Docker Compose pulls image
      │
      ▼
Caddy exposes the application via HTTPS
```

---

# Bootstrap Process

The EC2 instance is fully bootstrapped via **Terraform `user_data`**.

During the first boot the instance automatically:

1. Installs Docker
2. Installs Docker Compose
3. Creates application directory

```
/opt/personal-portfolio
```

4. Generates configuration files:

- `.env`
- `docker-compose.yml`
- `Caddyfile`

5. Authenticates with Amazon ECR
6. Pulls the latest container image
7. Starts the application stack

---

# HTTPS

HTTPS is automatically configured using **Caddy**.

Certificates are automatically issued and renewed by **Let's Encrypt**.

Supported domains:

```
paladindevs.com
www.paladindevs.com
```

---

# Project Structure

```
terraform-portfolio-infra
│
├── environments
│   └── dev
│       ├── main.tf
│       ├── variables.tf
│       ├── terraform.tfvars
│       └── outputs.tf
│
├── modules
│   ├── ec2
│   ├── ecr
│   ├── iam-ssm-role
│   ├── route53-record
│   └── security-group
│
├── templates
│   └── user_data.sh.tftpl
│
└── README.md
```

---

# Requirements

Before running Terraform you need:

- Terraform >= 1.5
- AWS CLI
- AWS credentials configured

Example AWS profile:

```bash
aws configure --profile personal
```

---

# Usage

Initialize Terraform:

```bash
terraform init
```

Validate configuration:

```bash
terraform validate
```

Preview infrastructure changes:

```bash
terraform plan
```

Apply infrastructure:

```bash
terraform apply
```

Destroy infrastructure:

```bash
terraform destroy
```

---

# Outputs

After deployment Terraform provides:

```
fqdn
www_fqdn
public_ip
instance_id
ecr_repository_url
```

---

# Accessing the Server

The EC2 instance is accessed using **AWS Systems Manager Session Manager**, so no SSH keys are required.

Example:

```bash
aws ssm start-session \
--target <instance-id> \
--region us-east-1 \
--profile personal
```

---

# Application Stack

The EC2 host runs a **Docker Compose stack**:

```
services:
site → portfolio container (NGINX)
caddy → reverse proxy with HTTPS
```

Caddy handles:

- TLS certificates
- HTTPS redirection
- Reverse proxy to the application container

---

# Security

The infrastructure follows several security best practices:

- No SSH access exposed
- Access via **AWS SSM**
- Least privilege IAM roles
- Docker containers isolated in a private network
- Automatic HTTPS

---

# Future Improvements

Planned improvements for this project:

- CI/CD pipeline using **GitHub Actions**
- Automatic container deployment via SSM
- Monitoring with **CloudWatch**
- Infrastructure promotion (dev → prod)
- Container health checks
- Optional **ALB + ACM architecture**

---

# Author

**Alisson Gomes**

DevOps / Infrastructure Engineer

Portfolio  
https://paladindevs.com

GitHub  
https://github.com/alissong
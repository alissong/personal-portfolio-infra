aws_region    = "us-east-1"
project_name  = "personal-portfolio"
environment   = "dev"
instance_type = "t3.micro"

domain_name = "paladindevs.com"
record_name = "www"
zone_id     = "ZXXXXXXXXXXXXXXX" # REPLACE with your Route53 Hosted Zone ID

# Amazon Linux 2023 in us-east-1 - replace if you want another AMI
ami_id = "ami-REPLACE_ME" # REPLACE with a real AMI id (e.g. ami-0123456789abcdef0)

# Replace the following ECR placeholders with your real ECR registry and image
ecr_registry = "ACCOUNT_ID.dkr.ecr.REGION.amazonaws.com" # REPLACE (e.g. 123456789012.dkr.ecr.us-east-1.amazonaws.com)

ecr_image = "ACCOUNT_ID.dkr.ecr.REGION.amazonaws.com/personal-portfolio:latest" # REPLACE with your repository/image:tag
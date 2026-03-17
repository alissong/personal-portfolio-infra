aws_region    = "us-east-1"
project_name  = "personal-portfolio"
environment   = "dev"
instance_type = "t3.micro"

domain_name = "paladindevs.com"
record_name = "www"
zone_id     = "Z03811502H6WRWQBWCZCJ"

# Amazon Linux 2023 em us-east-1 - substitua se quiser outra AMI
ami_id = "ami-0f88e80871fd81e91"

ecr_registry = "338846672827.dkr.ecr.us-east-1.amazonaws.com"

ecr_image = "338846672827.dkr.ecr.us-east-1.amazonaws.com/personal-portfolio:latest"
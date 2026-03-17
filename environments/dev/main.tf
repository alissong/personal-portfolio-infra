module "security_group" {
  source = "../../modules/security-group"

  name_prefix = "${var.project_name}-${var.environment}"
}

module "iam_ssm_role" {
  source = "../../modules/iam-ssm-role"

  name_prefix = "${var.project_name}-${var.environment}"
}

module "ec2" {
  source = "../../modules/ec2"

  name_prefix           = "${var.project_name}-${var.environment}"
  ami_id                = var.ami_id
  instance_type         = var.instance_type
  security_group_ids    = [module.security_group.security_group_id]
  instance_profile_name = module.iam_ssm_role.instance_profile_name

  domain_name  = var.domain_name
  aws_region   = var.aws_region
  ecr_registry = var.ecr_registry
  ecr_image    = var.ecr_image


  user_data = templatefile("${path.module}/../../templates/user_data.sh.tftpl", {
    domain_name  = var.domain_name
    ecr_image    = var.ecr_image
    aws_region   = var.aws_region
    ecr_registry = var.ecr_registry
  })
}

module "elastic_ip" {
  source = "../../modules/elastic-ip"

  instance_id = module.ec2.instance_id
  name        = "${var.project_name}-${var.environment}-eip"
}

module "route53_record" {
  source = "../../modules/route53-record"

  zone_id     = var.zone_id
  domain_name = var.domain_name
  record_name = var.record_name
  ip_address  = module.elastic_ip.public_ip
}

module "route53_record_www" {
  source = "../../modules/route53-record"

  zone_id     = var.zone_id
  domain_name = var.domain_name
  record_name = "www"
  ip_address  = module.elastic_ip.public_ip
}

module "ecr" {
  source = "../../modules/ecr"

  name = "personal-portfolio"
}
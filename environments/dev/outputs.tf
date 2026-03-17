output "instance_id" {
  value = module.ec2.instance_id
}

output "public_ip" {
  value = module.elastic_ip.public_ip
}

output "fqdn" {
  value = module.route53_record.fqdn
}

output "ecr_repository_url" {
  value = module.ecr.repository_url
}

output "www_fqdn" {
  value = module.route53_record_www.fqdn
}
locals {
  fqdn = var.record_name == "@" ? var.domain_name : "${var.record_name}.${var.domain_name}"
}

resource "aws_route53_record" "this" {
  zone_id = var.zone_id
  name    = local.fqdn
  type    = "A"
  ttl     = 300
  records = [var.ip_address]
}
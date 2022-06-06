locals {
  alternative_names = []
}

resource "aws_acm_certificate" "this" {
  domain_name               = local.subdomain_name
  validation_method         = "DNS"
  subject_alternative_names = local.alternative_names
  tags                      = local.tags
}

locals {
  dvos = [for dvo in aws_acm_certificate.this.domain_validation_options : {
    name   = dvo.resource_record_name
    record = dvo.resource_record_value
    type   = dvo.resource_record_type
  }]
}

resource "aws_route53_record" "cert_validation" {
  count = length(local.alternative_names) + 1

  allow_overwrite = true
  name            = local.dvos[count.index].name
  records         = [local.dvos[count.index].record]
  type            = local.dvos[count.index].type
  ttl             = 60
  zone_id         = local.subdomain_zone_id
}

resource "aws_acm_certificate_validation" "this" {
  certificate_arn         = aws_acm_certificate.this.arn
  validation_record_fqdns = [for cv in aws_route53_record.cert_validation : cv.fqdn]

  timeouts {
    create = "5m"
  }
}


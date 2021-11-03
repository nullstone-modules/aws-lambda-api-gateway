locals {
  vanity_subdomain = trimsuffix(aws_route53_record.vanity.fqdn, ".")
  vanity_url       = "https://${local.vanity_subdomain}:443"
}

output "public_urls" {
  value = [
    {
      url = local.vanity_url
    }
  ]
}

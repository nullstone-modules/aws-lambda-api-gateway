module "cert" {
  source  = "nullstone-modules/sslcert/aws"
  version = "~> 0.3.0"
  enabled = true

  domain = {
    name    = local.subdomain_name
    zone_id = local.subdomain_zone_id
  }

  tags = data.ns_workspace.this.tags
}

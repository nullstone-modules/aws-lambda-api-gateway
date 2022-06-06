data "ns_connection" "subdomain" {
  name = "subdomain"
  type = "subdomain/aws"
}

locals {
  subdomain_name    = trimsuffix(data.ns_connection.subdomain.outputs.fqdn, ".")
  subdomain_zone_id = data.ns_connection.subdomain.outputs.zone_id
}

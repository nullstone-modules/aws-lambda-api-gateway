terraform {
  required_providers {
    ns = {
      source = "nullstone-io/ns"
    }
  }
}

variable "app_metadata" {
  description = <<EOF
App Metadata is injected from the app on-the-fly.
This contains information about resources created in the app module that are needed by the capability.
EOF

  type    = map(string)
  default = {}
}

data "ns_workspace" "this" {}

data "ns_connection" "subdomain" {
  name = "subdomain"
  type = "subdomain/aws"
}

locals {
  subdomain_name    = trimsuffix(try(data.ns_connection.subdomain.outputs.fqdn, ""), ".")
  subdomain_zone_id = try(data.ns_connection.subdomain.outputs.zone_id, "")
}

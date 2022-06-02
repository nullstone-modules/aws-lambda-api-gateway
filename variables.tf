variable "app_metadata" {
  description = <<EOF
Nullstone automatically injects metadata from the app module into this module through this variable.
This variable is a reserved variable for capabilities.
EOF

  type    = map(string)
  default = {}
}

locals {
  function_arn  = var.app_metadata["function_arn"]
  function_name = var.app_metadata["function_name"]
}

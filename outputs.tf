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

output "permissions" {
  value = [
    {
      sid_prefix = "AllowGatewayAccess"
      action     = "lambda:InvokeFunction"
      principal  = "apigateway.amazonaws.com"
      source_arn = "${aws_apigatewayv2_api.this.execution_arn}/*/${aws_apigatewayv2_api_mapping.this.stage}"
    }
  ]
}

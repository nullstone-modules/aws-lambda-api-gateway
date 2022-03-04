resource "aws_apigatewayv2_api" "this" {
  name                         = local.resource_name
  protocol_type                = "HTTP"
  disable_execute_api_endpoint = true
  target                       = var.app_metadata["function_arn"]
  tags                         = local.tags
}

resource "aws_apigatewayv2_domain_name" "this" {
  domain_name = trimsuffix(local.subdomain_name, ".")
  tags        = local.tags

  domain_name_configuration {
    certificate_arn = aws_acm_certificate.this.arn
    endpoint_type   = "REGIONAL"
    security_policy = "TLS_1_2"
  }

  depends_on = [aws_acm_certificate_validation.this]
}

resource "aws_apigatewayv2_api_mapping" "this" {
  api_id      = aws_apigatewayv2_api.this.id
  domain_name = aws_apigatewayv2_domain_name.this.domain_name
  stage       = "$default"
}

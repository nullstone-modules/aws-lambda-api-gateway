resource "aws_lambda_permission" "gateway" {
  statement_id_prefix = "AllowGatewayAccess"
  action              = "lambda:InvokeFunction"
  function_name       = local.function_name
  principal           = "apigateway.amazonaws.com"
  source_arn          = "${aws_apigatewayv2_api.this.execution_arn}/*/${aws_apigatewayv2_api_mapping.this.stage}"
}

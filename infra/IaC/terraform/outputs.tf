output "api_gateway_invoke_url" {
  value = "${aws_api_gateway_rest_api.MyDemoAPI.execution_arn}/myresource"
}
resource "aws_api_gateway_rest_api" "MyDemoAPI" {
  name        = "MyDemoAPI"
  description = "This is my API for demonstration purposes"
}

resource "aws_api_gateway_resource" "MyDemoResource" {
  rest_api_id = aws_api_gateway_rest_api.MyDemoAPI.id
  parent_id   = aws_api_gateway_rest_api.MyDemoAPI.root_resource_id
  path_part   = "myresource"
}

resource "aws_api_gateway_method" "MyDemoMethod" {
  rest_api_id   = aws_api_gateway_rest_api.MyDemoAPI.id
  resource_id   = aws_api_gateway_resource.MyDemoResource.id
  http_method   = "GET"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.lambda_authorizer.id
}

resource "aws_api_gateway_integration" "MyDemoIntegration" {
  rest_api_id             = aws_api_gateway_rest_api.MyDemoAPI.id
  resource_id             = aws_api_gateway_resource.MyDemoResource.id
  http_method             = aws_api_gateway_method.MyDemoMethod.http_method
  type                    = "HTTP"
  uri                     = "http://httpbin.org/ip"
  integration_http_method = "POST"
}

 resource "aws_api_gateway_authorizer" "lambda_authorizer" {
  name                   = "lambda_authorizer"
  rest_api_id            = aws_api_gateway_rest_api.MyDemoAPI.id
  authorizer_uri         = aws_lambda_function.lambda_authorizer.invoke_arn
  authorizer_credentials = aws_iam_role.lambda_authorizer_role.arn
  identity_source        = "method.request.header.Authorization"
  type                   = "TOKEN"
}

// Create a domain name
resource "aws_api_gateway_domain_name" "example" {
  domain_name = "local.example.com"
}

// Create a base path mapping
resource "aws_api_gateway_base_path_mapping" "example" {
  api_id      = aws_api_gateway_rest_api.MyDemoAPI.id
  stage_name  = "dev"
  domain_name = aws_api_gateway_domain_name.example.domain_name
}
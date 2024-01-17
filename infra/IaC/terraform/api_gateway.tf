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
  authorizer_id = aws_api_gateway_authorizer.MyDemoAuthorizer.id
}

resource "aws_api_gateway_integration" "MyDemoIntegration" {
  rest_api_id = aws_api_gateway_rest_api.MyDemoAPI.id
  resource_id = aws_api_gateway_resource.MyDemoResource.id
  http_method = aws_api_gateway_method.MyDemoMethod.http_method
  type        = "HTTP"
  uri         = "http://httpbin.org/ip" # Example URI, replace with your backend endpoint
}

resource "aws_api_gateway_authorizer" "MyDemoAuthorizer" {
  name                   = "MyDemoAuthorizer"
  rest_api_id            = aws_api_gateway_rest_api.MyDemoAPI.id
  authorizer_uri         = aws_lambda_function.MyDemoAuthFunction.invoke_arn
  authorizer_credentials = aws_iam_role.MyDemoRole.arn
  identity_source        = "method.request.header.Authorization"
  type                   = "TOKEN"
}

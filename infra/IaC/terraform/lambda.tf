resource "aws_lambda_function" "MyDemoAuthFunction" {
  function_name = "MyDemoAuthFunction"
  role          = aws_iam_role.MyDemoRole.arn
  handler       = "index.handler"  # Update this to your handler
  runtime       = "nodejs12.x"     # Update this to your runtime

  # The filename of the lambda function. Upload a ZIP file containing your Lambda code to this path.
  filename         = "lambda.zip" 
  source_code_hash = filebase64sha256("lambda.zip")
}

resource "aws_iam_role" "MyDemoRole" {
  name = "MyDemoRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
      },
    ],
  })
}

# IAM policy to allow the Lambda function to log to CloudWatch
resource "aws_iam_role_policy" "MyDemoLambdaPolicy" {
  name = "MyDemoLambdaPolicy"
  role = aws_iam_role.MyDemoRole.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
        ],
        Effect = "Allow",
        Resource = "arn:aws:logs:*:*:*",
      },
    ],
  })
}

resource "aws_lambda_function" "lambda_authorizer" {
  function_name = "lambda_authorizer"
  role          = aws_iam_role.lambda_authorizer_role.arn
  handler       = "index.handler"
  runtime       = "nodejs12.x"

  # The filename of the lambda function. Upload a ZIP file containing your Lambda code to this path.
  filename         = "lambda.zip" 
  source_code_hash = filebase64sha256("lambda.zip")
}

resource "aws_iam_role" "lambda_authorizer_role" {
  name = "lambda_authorizer_role"

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
resource "aws_iam_role_policy" "lambda_authorizer_policy" {
  name = "lambda_authorizer_policy"
  role = aws_iam_role.lambda_authorizer_role.id

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

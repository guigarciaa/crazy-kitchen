// Create DynamoDB tables
resource "aws_dynamodb_table" "tb_menu" {
  name           = "tb_menu"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"
  }
}

resource "aws_dynamodb_table" "tb_orders" {
  name           = "tb_orders"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"
  }
}

// Create SQS queue and SNS topic
resource "aws_sqs_queue" "request_queue" {
  name = "request_queue"
}
resource "aws_sns_topic" "request_notification" {
  name = "request_notification"
}

// Create Route53 zone and record
resource "aws_route53_zone" "my_zone" {
  name = "example.com"
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.my_zone.zone_id
  name    = "www.example.com"
  type    = "A"
  ttl     = "300"
  records = ["192.0.2.1"]
}
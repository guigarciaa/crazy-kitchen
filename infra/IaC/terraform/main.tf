provider "aws" {
  region                      = "us-east-1"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    apigateway = "http://localhost:4566"
    lambda     = "http://localhost:4566"
    sqs        = "http://localhost:4566"
    sns        = "http://localhost:4566"
    dynamodb   = "http://localhost:4566"
  }
}

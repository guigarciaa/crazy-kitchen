provider "aws" {
  # access_key                  = "mock_access_key"
  # secret_key                  = "mock_secret_key"
  region                      = "us-east-1"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  
  endpoints {
    apigateway = "http://localhost:4566"
    lambda     = "http://localhost:4566"
  }
}

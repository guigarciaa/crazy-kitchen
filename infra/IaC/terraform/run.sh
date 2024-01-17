export AWS_ACCESS_KEY_ID="dummy-access-key"
export AWS_SECRET_ACCESS_KEY="dummy-secret-key"
export AWS_DEFAULT_REGION="us-east-1"  # Change this if needed
export AWS_S3_ENDPOINT="http://localhost:4566"


tflocal init
tflocal apply
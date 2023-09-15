#!/bin/bash

# Allow list of parameters
allowlist=(
  AWS_ACCESS_KEY_ID
  AWS_SECRET_ACCESS_KEY
  VPC_AWS_REGION
  VPC_LAMBDA_FUNCTION_NAME
)

for key in "${allowlist[@]}"; do
  echo "$key=$(aws ssm get-parameter --name "/amplify/$AWS_APP_ID/$APP_ENV/nextAPI/$key" --with-decryption | jq '.Parameter.Value')" >> .env
done
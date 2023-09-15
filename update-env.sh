#!/bin/bash

# Allow list of parameters
allowlist=(
  AWS_ACCESS_KEY_ID
  AWS_SECRET_ACCESS_KEY
  VPC_AWS_REGION
  VPC_LAMBDA_FUNCTION_NAME
)

# Get the app environment from amplify/.config/local-env-info.json
APP_ENV=$(jq -r '.envName' amplify/.config/local-env-info.json)

for key in "${allowlist[@]}"; do
  echo "$key=$(aws ssm get-parameter --name "/amplify/$AWS_APP_ID/$APP_ENV/nextAPI/$key" --with-decryption | jq '.Parameter.Value')" >> .env
done
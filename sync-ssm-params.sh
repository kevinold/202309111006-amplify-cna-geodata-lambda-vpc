#!/bin/bash

# Allow list of parameters
allowlist=(
  AWS_ACCESS_KEY_ID
  AWS_SECRET_ACCESS_KEY
  VPC_AWS_REGION
  VPC_LAMBDA_FUNCTION_NAME
)


# Get the name of the current branch
APP_BRANCH=$(git rev-parse --abbrev-ref HEAD)

# Load .env into environment
export $(cat .env.local | grep -v '^#' | xargs) 

# Get AWS access keys from AWS CLI profile
AWS_ACCESS_KEY_ID=$(aws configure get aws_access_key_id --profile $AWS_PROFILE)
AWS_SECRET_ACCESS_KEY=$(aws configure get aws_secret_access_key --profile $AWS_PROFILE)

for key in "${allowlist[@]}"; do
  aws ssm put-parameter --name "/amplify/$AWS_APP_ID/$APP_BRANCH/$key" --value "${!key}" --type SecureString --overwrite
done
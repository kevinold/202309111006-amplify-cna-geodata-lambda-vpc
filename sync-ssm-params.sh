#!/bin/bash

# Allow list of parameters
allowlist=(
  AWS_ACCESS_KEY_ID
  AWS_SECRET_ACCESS_KEY
  VPC_AWS_REGION
  VPC_LAMBDA_FUNCTION_NAME
)

# Check if AMPLIFY_APP_ID already exists and if so, exit because we are running in CI/CD
if [ ! -z "$AMPLIFY_APP_ID" ]; then
  echo "AMPLIFY_APP_ID already set, exiting in case this is running in CI/CD..." 
  exit 1
fi

# Get the app environment from amplify/.config/local-env-info.json
APP_ENV=$(jq -r '.envName' amplify/.config/local-env-info.json)

# If we are not running in CI/CD, get AmplifyAppId from amplify/team-provider-info.json
AMPLIFY_APP_ID=$(jq -r ".$APP_ENV.awscloudformation.AmplifyAppId" amplify/team-provider-info.json)

function setParams() {
  # Load .env into environment
  export $(cat .env.local | grep -v '^#' | xargs) 

  # Get AWS access keys from AWS CLI profile
  AWS_ACCESS_KEY_ID=$(aws configure get aws_access_key_id --profile $AWS_PROFILE)
  AWS_SECRET_ACCESS_KEY=$(aws configure get aws_secret_access_key --profile $AWS_PROFILE)

  for key in "${allowlist[@]}"; do
    aws ssm put-parameter --name "/amplify/$AMPLIFY_APP_ID/$APP_ENV/nextAPI/$key" --value "${!key}" --type SecureString --overwrite
  done
}

function updateEnv() {
  for key in "${allowlist[@]}"; do
    echo "$key=$(aws ssm get-parameter --name "/amplify/$AWS_APP_ID/$APP_ENV/nextAPI/$key" --with-decryption | jq '.Parameter.Value')" >> .env
  done
}
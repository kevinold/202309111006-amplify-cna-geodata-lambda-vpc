#!/bin/bash

echo $secrets | jq -r 'to_entries|map("\(.key)=\(.value)")|.[]' >> .env

# Allow list of parameters
# allowlist=(
#   AWS_ACCESS_KEY_ID
#   AWS_SECRET_ACCESS_KEY
#   VPC_AWS_REGION
#   VPC_LAMBDA_FUNCTION_NAME
# )

# TEST_PARAM=$(aws ssm get-parameter --name "/amplify/d36g0ambyeydeu/main/test" --with-decryption | jq '.Parameter.Value')
# echo $TEST_PARAM

# Get the name of the current branch
# APP_BRANCH=$(git rev-parse --abbrev-ref HEAD)
# echo $APP_BRANCH

# for key in "${allowlist[@]}"; do
#   echo "$key=$(aws ssm get-parameter --name "/amplify/$AWS_APP_ID/$APP_BRANCH/$key" --with-decryption | jq '.Parameter.Value')" >> .env
# done
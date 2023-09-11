#!/bin/bash

echo "AWS_ACCESS_KEY_ID=$(aws ssm get-parameter --name "/amplify/$AWS_APP_ID/dev/nextAPI/AWS_ACCESS_KEY_ID" --with-decryption | jq '.Parameter.Value')" >> .env
echo "AWS_SECRET_ACCESS_KEY=$(aws ssm get-parameter --name "/amplify/$AWS_APP_ID/dev/nextAPI/AWS_SECRET_ACCESS_KEY" --with-decryption | jq '.Parameter.Value')" >> .env

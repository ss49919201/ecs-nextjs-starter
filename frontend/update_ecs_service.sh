#!/bin/bash

set -e

AWS_PROFILE=$1
AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query "Account" --output text)

cd $(dirname $0)

aws ecr get-login-password --region ap-northeast-1 \
| docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.ap-northeast-1.amazonaws.com
docker build --platform linux/amd64 -t frontend .
docker tag frontend:latest $AWS_ACCOUNT_ID.dkr.ecr.ap-northeast-1.amazonaws.com/frontend:latest
docker push $AWS_ACCOUNT_ID.dkr.ecr.ap-northeast-1.amazonaws.com/frontend:latest

# --output text でないと正常に処理できない
aws ecs update-service \
--cluster $(aws ecs describe-clusters --cluster frontend --region ap-northeast-1 --query 'clusters[0].clusterArn' --output text) \
--service frontend \
--force-new-deployment \
--region ap-northeast-1

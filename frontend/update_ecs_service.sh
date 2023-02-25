#!/bin/bash

set -e

aws ecr get-login-password --region ap-northeast-1 --profile developer \
| docker login --username AWS --password-stdin 504784160859.dkr.ecr.ap-northeast-1.amazonaws.com
docker build --platform linux/amd64 -t frontend .
docker tag frontend:latest 504784160859.dkr.ecr.ap-northeast-1.amazonaws.com/frontend:latest
docker push 504784160859.dkr.ecr.ap-northeast-1.amazonaws.com/frontend:latest

# --output text でないと正常に処理できない
aws ecs update-service \
--cluster $(aws ecs describe-clusters --cluster frontend --profile developer --region ap-northeast-1 --query 'clusters[0].clusterArn' --output text) \
--service frontend \
--force-new-deployment \
--region ap-northeast-1 \
--profile developer

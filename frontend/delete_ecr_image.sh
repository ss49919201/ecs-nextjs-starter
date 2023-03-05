#!/bin/bash
#TODO 複数ページ対応

set -e

OUTPUT_JSON=$(aws ecr list-images --region ap-northeast-1 --profile developer --repository-name frontend | jq)

IMAGE_IDS=""

for row in $(echo $OUTPUT_JSON | jq '.imageIds[].imageDigest')
do
	IMAGE_IDS+="imageDigest=$row "
done

IMAGE_IDS=$(echo $IMAGE_IDS | sed -e 's/ $//g')

aws ecr batch-delete-image \
	--repository-name frontend \
	--image-ids $IMAGE_IDS \
	--profile developer \
	--region ap-northeast-1

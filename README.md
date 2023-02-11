```sh
cd infra && \
terraform apply

cd frontend && \
aws ecr get-login-password --region ap-northeast-1 | docker login --username AWS --password-stdin 504784160859.dkr.ecr.ap-northeast-1.amazonaws.com && \
docker build --platform linux/x86-64 . -t frontend && \
docker tag frontend:latest 504784160859.dkr.ecr.ap-northeast-1.amazonaws.com/frontend:latest && \
docker push 504784160859.dkr.ecr.ap-northeast-1.amazonaws.com/frontend:latest
```

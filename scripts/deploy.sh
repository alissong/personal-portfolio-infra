#!/usr/bin/env bash
set -euo pipefail

APP_DIR="/opt/personal-portfolio"

cd "$APP_DIR"

aws ecr get-login-password --region ${AWS_REGION:-us-east-1} \
  | docker login --username AWS --password-stdin ${ECR_REGISTRY:-ACCOUNT_ID.dkr.ecr.REGION.amazonaws.com}

docker compose pull
docker compose up -d

docker image prune -af || true
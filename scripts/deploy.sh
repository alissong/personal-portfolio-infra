#!/usr/bin/env bash
set -euo pipefail

APP_DIR="/opt/personal-portfolio"

cd "$APP_DIR"

aws ecr get-login-password --region us-east-1 \
  | docker login --username AWS --password-stdin 338846672827.dkr.ecr.us-east-1.amazonaws.com

docker compose pull
docker compose up -d

docker image prune -af || true
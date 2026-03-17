#!/usr/bin/env bash
set -euo pipefail

INSTANCE_ID="${1:?Usage: $0 <instance-id>}"
REGION="${AWS_REGION:-us-east-1}"

APP_DIR="/opt/personal-portfolio"

CADDYFILE_CONTENT="$(cat templates/Caddyfile)"
COMPOSE_CONTENT="$(cat templates/docker-compose.yml)"
ENV_CONTENT="$(cat templates/.env)"

aws ssm send-command \
  --region "$REGION" \
  --instance-ids "$INSTANCE_ID" \
  --document-name "AWS-RunShellScript" \
  --parameters commands="[
    'mkdir -p ${APP_DIR}',
    'cat > ${APP_DIR}/Caddyfile <<''\"'\"'EOF''\"'\"'\n${CADDYFILE_CONTENT}\nEOF',
    'cat > ${APP_DIR}/docker-compose.yml <<''\"'\"'EOF''\"'\"'\n${COMPOSE_CONTENT}\nEOF',
    'cat > ${APP_DIR}/.env <<''\"'\"'EOF''\"'\"'\n${ENV_CONTENT}\nEOF',
    'cd ${APP_DIR}',
    'aws ecr get-login-password --region ${REGION} | docker login --username AWS --password-stdin 338846672827.dkr.ecr.us-east-1.amazonaws.com',
    'docker compose up -d'
  ]"
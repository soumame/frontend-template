#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
ENV_FILE="${ROOT_DIR}/.env"

if [[ -f "$ENV_FILE" ]]; then
  set -a
  # shellcheck disable=SC1090
  . "$ENV_FILE"
  set +a
fi

if [[ -z "${CONTEXT7_API_KEY:-}" ]]; then
  echo "CONTEXT7_API_KEY が未設定です。.env に設定してください。" >&2
  exit 1
fi

exec npx -y @upstash/context7-mcp --api-key "$CONTEXT7_API_KEY"

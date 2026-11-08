#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

if [[ ! -f .env ]]; then
  if [[ -f .env.template ]]; then
    cp .env.template .env
    echo "Created .env from .env.template — fill in secrets if needed."
  else
    echo "Missing .env (and no .env.template). Aborting." >&2
    exit 1
  fi
fi

if [[ ! -d vendor ]] && [[ ! -f go.sum ]]; then
  echo "Downloading Go modules..."
  go mod download
fi

echo "Starting KWoC Backend on :${BACKEND_PORT:-8080}..."
exec go run cmd/backend.go "$@"

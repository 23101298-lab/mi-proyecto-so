#!/usr/bin/env bash
set -e
DIR="$(cd "$(dirname "$0")" && pwd)"

echo "[start] creando red si hace falta..."
docker network inspect webui_net >/dev/null 2>&1 || docker network create webui_net

echo "[start] levantando stack con docker-compose..."
docker compose up -d

echo "[start] esperando healthchecks (10s)..."
sleep 10

docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
echo "Open WebUI: http://localhost:3000"
echo "Ollama API (host): http://localhost:11434"
echo "Ollama API (desde contenedores): http://ollama:11434"

#!/usr/bin/env bash
set -e
OUTDIR="${PWD}/backups"
mkdir -p "$OUTDIR"
TS=$(date +%F_%H%M%S)

echo "Backup ollama_data -> $OUTDIR/ollama_data-${TS}.tar.gz"
docker run --rm -v ollama_data:/data -v "$OUTDIR":/backup alpine \
  sh -c "cd /data && tar czf /backup/ollama_data-${TS}.tar.gz ."

echo "Backup openwebui_data -> $OUTDIR/openwebui_data-${TS}.tar.gz"
docker run --rm -v openwebui_data:/data -v "$OUTDIR":/backup alpine \
  sh -c "cd /data && tar czf /backup/openwebui_data-${TS}.tar.gz ."

echo "Backups completados en $OUTDIR"

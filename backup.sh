#!/bin/bash
mkdir -p backup
docker run --rm \
  -v chatgpt-final_ollama-data:/data:ro \
  -v $(pwd)/backup:/backup \
  alpine tar czvf /backup/models-backup.tar.gz /data

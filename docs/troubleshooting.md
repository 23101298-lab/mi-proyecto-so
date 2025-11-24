##  Troubleshooting
Problema 1: Puerto ocupado (3000 o 11434)

Síntoma:
El contenedor no iniciaba y mostraba:
bind: address already in use

Causa:
Un proceso zombie (docker-proxy) seguía ocupando el puerto.

Solución:
````
sudo lsof -i :3000
sudo pkill -f docker-proxy
docker compose up -d
````

-----
Problema 2: Contenedor OLLAMA en estado "unhealthy"


Síntoma:
El compose mostraba:
dependency failed to start: ollama is unhealthy

Causa:
Faltaban recursos en WSL2 o no cargaba el modelo correctamente.

Solución:
````

wsl --shutdown
docker compose up -d --build
````

(Además de aumentar memoria/CPU en .wslconfig.)

----
Problema 3: Los modelos o datos no persistían

Síntoma:
Se perdían los modelos al reiniciar contenedores.

Causa:
El volumen no estaba correctamente montado.

Solución (docker-compose):
````

volumes:
  - ollama-data:/root/.ollama
  ````


Confirmación:
````

docker volume inspect ollama-data
````
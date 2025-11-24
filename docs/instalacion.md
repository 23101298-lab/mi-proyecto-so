##  Instrucciones de instalación (paso a paso)

  1.Ejecutamos en el cmd o PowerShell **wsl -d Ubuntu-22.04**

  2.Dirigirnos a /mnt/c/Users/yuber
con **cd /mnt/c/Users/yuber**

 3.Creamos el proyecto con nombre "chatgpt-final" con **mkdir chatgpt-final** 
 4.Nos dirigimos a la carpeta creada con **cd chatgpt-final**

 5.Creamos el archivo .yml con **nano docker-compose.yml**
 
 6.Colocamos dentro el siguiente código:


 ``` bash
 services:

  ollama:
    image: ollama/ollama:latest
    container_name: ollama
    restart: always
    ports:
      - "11434:11434"
    runtime: nvidia
    environment:
      - NVIDIA_VISIBLE_DEVICES=all
      - NVIDIA_DRIVER_CAPABILITIES=compute,utility
      - OLLAMA_FLASH_ATTENTION=false
    volumes:
      - ollama-data:/root/.ollama
    networks:
      - chatnet

  webui:
    image: ghcr.io/open-webui/open-webui:latest
    container_name: webui
    restart: always
    depends_on:
      - ollama
    ports:
      - "3000:8080"
    environment:
      - OLLAMA_API_BASE_URL=http://ollama:11434
    volumes:
      - webui-data:/app/backend/data
    networks:
      - chatnet

volumes:
  ollama-data:
  webui-data:

networks:
  chatnet:
    driver: bridge


```


7. Levantamos el stack con **docker compose up -d**


  8.Revisamos con **docker ps**

  Debe salir: 
  ```
   ollama → Up

   webui → Up
  ```
  Si responde → GPU funcionando.

  9 .Instalamos un modelo en este caso un modelo lijero **PHI-3**

Ejecutamos:
```
docker exec -it ollama bash
ollama pull phi3
ollama run phi3
```

  10 .Abrir WEB-UI


En tu navegador:
 http://localhost:3000
 

 ---

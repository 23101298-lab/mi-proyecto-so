# Mi Propio ChatGPT Local
----
##DEEPESAN


**Autores:** Yubert Diaz Leon  , salva christ , gabriela paco


**Curso:** Sistemas Operativos (Ciclo 2025-2)  
**Institución:** ESAN Universidad  
**Fecha:** 24-11-2025  


---
##  Descripción del Proyecto

Este proyecto implementa una versión **local y gratuita de ChatGPT**, utilizando contenedores Docker y aceleración GPU NVIDIA.  
Permite ejecutar modelos de lenguaje (LLM) sin conexión a internet, garantizando privacidad total de los datos.  

El entorno incluye dos servicios principales:
-  **Ollama:** servidor que ejecuta el modelo Phi3 Mini (3.8B).  
-  **Open-WebUI:** interfaz web tipo ChatGPT para conversar con el modelo.  

---
##  Problema que Resuelve

Modelos como ChatGPT suelen depender de servidores externos y tienen costos por uso.  
Este proyecto resuelve esa limitación al crear un entorno **completamente local y privado**, ideal para:

- Estudiantes o investigadores que desean experimentar con IA sin conexión.  
- Docentes que buscan mostrar conceptos de procesos, redes y orquestación.  
- Usuarios que necesitan un entorno de IA sin enviar datos a la nube.  

Además, permite aplicar **conceptos reales de sistemas operativos**: procesos, namespaces, cgroups, memoria y GPU computing.

---
##  Requisitos Previos

| Software / Sistema | Versión recomendada | Función |
|--------------------|---------------------|----------|
| **Windows 10/11 + WSL2** | Última versión | Entorno base para ejecutar Linux dentro de Windows |
| **Ubuntu (WSL o nativo)** | **22.04 LTS** (ó 24.04 LTS) | Distribución Linux base donde se ejecuta Docker |
| **Docker Desktop** (Windows) / **Docker Engine** (Linux) | ≥ 4.30 (Desktop) / ≥ 24.x (Engine) | Manejo de contenedores y redes internas |
| **NVIDIA GPU Drivers** | ≥ 535.xx | Controladores necesarios para habilitar CUDA |
| **NVIDIA Container Toolkit** | Compatible con CUDA 12+ | Permite usar la GPU dentro de contenedores |
| **curl** | Última versión | Comprobación y pruebas HTTP hacia la API local |

---





##  Instrucciones de instalación (paso a paso)

  1.Ejecutamos en el cmd o PowerShell **wsl -d Ubuntu-22.04**

  2.Dirigirnos a /mnt/c/Users/yuber
con **cd /mnt/c/Users/yuber**

 3.Creamos el proyecto con nombre "chatgpt-final" con **mkdir chatgpt-final** 



 4.Nos dirigimos a la carpeta creada con **cd chatgpt-final**

 5.Creamos el archivo .yml con **nano docker-compose.yml**
 
 6.Colocamos dentro el siguiente código:


 ``` bash
version: "3.9"

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

    deploy:
      resources:
        limits:
          cpus: "2.0"    # máximo ~2 cores lógicos
          memory: "6G"   # máximo 6 GB de RAM
        reservations:
          cpus: "1.0"    # reserva mínima de 1 core
          memory: "4G"   # reserva mínima de 4 GB

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


## Instrucciones de uso

1.Ejecutamos en el cmd o PowerShell **wsl -d Ubuntu-22.04**


2. Nos movemos donde se encuentra nuestro proyecto, en mi caso **cd /mnt/c/Users/yuber/chatgpt-final**


 

3.Luego escribimos para levantar el proeycto **./scripts/start.sh** 
esto 

 arranca Ollama

 arranca WebUI

 arranca todo el proyecto
 con un solo comando



4 .Abrir WEB-UI


En tu navegador:
 http://localhost:3000


 ## Como hacer el reseteo en limpio   
 PASO 1 — LIMPIAR TODO DOCKER

En WSL ejecuta:
````
./scripts/stop.sh 
````
 o 
 ````
 docker compose down -v
````
pero esto elimina nuestra persistencia (Volume chatgpt-final_webui-data)


PASO 2 Verificar que todo murio 
````
docker ps -a
````
PASO 3 — Limpiar cache del navegador (súper importante)
````
CTRL + SHIFT + R   (refrescar sin cache)
````
PASO 4 — Arrancar desde cero
````
./scripts/start.sh  
````
PASO 5 Ver si tu modelo sigue instalado

Ejecuta:
````
docker exec -it ollama ollama list
````
Si sale vacío:
````
NAME   ID   SIZE   MODIFIED
````
Paso 6 Descargamos nuestro modelo favorito 
````
docker exec -it ollama ollama pull phi3
````
crt + D pasa salir

Paso 7 Probar modelo en el terminal 
````
docker exec -it ollama ollama run phi3
````
PASO 8 — Probar Open-WebUI
````
http://localhost:3000/
````



## Screenshots o GIFs del proyecto funcionando

![alt text](https://raw.githubusercontent.com/23101298-lab/mi-proyecto-so/refs/heads/main/demo/Captura%20de%20pantalla%202025-11-23%20230456.png)


![alt text](https://raw.githubusercontent.com/23101298-lab/mi-proyecto-so/refs/heads/main/demo/Captura%20de%20pantalla%202025-11-23%20230738.png)


![alt text](https://raw.githubusercontent.com/23101298-lab/mi-proyecto-so/refs/heads/main/demo/Captura%20de%20pantalla%202025-11-23%20230854.png)


![alt text](https://raw.githubusercontent.com/23101298-lab/mi-proyecto-so/refs/heads/main/demo/Captura%20de%20pantalla%202025-11-23%20230901.png)


![alt text](https://raw.githubusercontent.com/23101298-lab/mi-proyecto-so/refs/heads/main/demo/Captura%20de%20pantalla%202025-11-23%20230926.png)


## Créditos y recursos utilizados

 Recurso | Descripción | Enlace |
 -----------|---------------------|----------|
**Ollama** | Motor de inferencia local con GPU | https://ollama.ai |
**Open-WebUI** | Interfaz visual para Ollama | https://github.com/open-webui/open-webui |
**Phi-3 Mini (Microsoft)** | Modelo de lenguaje liviano (3.8B) | https://huggingface.co/microsoft/phi-3-mini |
**Docker + NVIDIA Toolkit** | Contenedores con GPU | https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/ |
**Visual Studio Code** | Editor de código con vista previa Markdown | https://code.visualstudio.com |

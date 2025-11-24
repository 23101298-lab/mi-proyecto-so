````sql
[ HOST (WSL2) ]
- Kernel Linux
- Docker Engine
        |
        |  (bridge network)
        v
+-----------------------+
|  docker-compose.yml   |
+----------+------------+
           |
           +------------------------------------+
           |                                    |
           v                                    v
   +-------------------+               +-------------------+
   |      OLLAMA       | <-----------> |    WEBUI / UI     |
   | puerto 11434      |    HTTP       | puerto 3000       |
   | Volumen: ollama   |               | Interfaz LLM      |
   +-------------------+               +-------------------+
                     |
                     v
            Usuario vía navegador  
            http://localhost:3000

## Explicación de la Arquitectura

La arquitectura del proyecto se basa en un entorno Docker montado dentro de WSL2. El host (Windows + WSL2) proporciona el kernel Linux y el motor de Docker, que son los encargados de ejecutar los contenedores. Todo el sistema se orquesta mediante un archivo docker-compose.yml, el cual define los servicios, sus redes y volúmenes.

El primer servicio es OLLAMA, que funciona como el servidor del modelo de lenguaje. Este contenedor expone el puerto 11434 y utiliza un volumen persistente para almacenar los modelos descargados, evitando que se pierdan al reiniciar. El segundo servicio es Open WebUI (WEBUI/UI), que actúa como la interfaz gráfica. Este contenedor corre en el puerto 3000 y se comunica con OLLAMA mediante una red interna creada por Docker. Ambos servicios interactúan a través de peticiones HTTP.

El usuario accede desde el navegador a http://localhost:3000. La interfaz envía solicitudes al contenedor de OLLAMA, el cual procesa el texto con el modelo LLM y devuelve la respuesta. La red bridge creada por Docker permite que los contenedores se comuniquen entre sí sin exponer información innecesaria hacia el host.

Opcionalmente, la arquitectura puede incluir un contenedor de base de datos, también gestionado por el docker-compose.yml, con un volumen para persistencia. Sin embargo, no es requerido para la ejecución básica del proyecto.


En conjunto, la arquitectura muestra cómo varios servicios aislados, cada uno en su propio contenedor, pueden trabajar coordinadamente mediante redes y volúmenes definidos por Docker.

````

```mermaid
flowchart LR
    User["Usuario / Navegador\nhttp://localhost:3000"] 
        --> WebUI["Contenedor `webui`\nOpen-WebUI\nPuerto 3000:8080\nRed: chatnet"]

    WebUI -->|HTTP :11434| Ollama["Contenedor `ollama`\nServidor de modelos LLM\nPuerto 11434:11434\nGPU: NVIDIA (runtime)"]

    Ollama --> VolOllama["Volumen\nollama-data"]
    WebUI --> VolWebui["Volumen\nwebui-data"]
    Ollama --> GPU["GPU NVIDIA\nVRAM"]




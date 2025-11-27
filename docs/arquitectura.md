flowchart LR
    User[Usuario / Navegador<br/>http://localhost:3000] --> WebUI[Contenedor `webui`<br/>Open-WebUI<br/>Puerto 3000:8080<br/>Red: chatnet]

    WebUI -->|HTTP :11434| Ollama[Contenedor `ollama`<br/>Servidor de modelos LLM<br/>Puerto 11434:11434<br/>GPU: NVIDIA (runtime)]

    Ollama --> VolOllama[(Volumen<br/>ollama-data)]
    WebUI --> VolWebui[(Volumen<br/>webui-data)]
    Ollama --> GPU[(GPU NVIDIA<br/>VRAM)]

    %% Estilos opcionales
    classDef cont fill:#1f6feb,stroke:#0d1117,color:#ffffff;
    classDef vol fill:#f0f6ff,stroke:#1f6feb,color:#000;
    classDef hw fill:#fef2c0,stroke:#9e6b00,color:#000;

    class User,WebUI,Ollama cont;
    class VolOllama,VolWebui vol;
    class GPU hw;



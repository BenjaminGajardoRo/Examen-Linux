#!/bin/bash

# ==========================================
# Módulo 1: Aprovisionamiento de Infraestructura
# Autor: FLOWSITO
# ==========================================

echo ">>> Iniciando actualización del sistema >>>"
# Actualizar repositorios 
sudo apt-get update -y

echo ">>> Instalando herramientas fundamentales >>>"
# Instalación de git, curl, ufw, docker y docker-compose 
sudo apt-get install -y git curl ufw docker.io docker-compose

echo ">>> Configurando estructura de directorios >>>"
# Crear ruta de forma idempotente (sin error si ya existe) 
sudo mkdir -p /opt/webapp/html

echo ">>> Descargando docker-compose.yml >>>"
# Descargar el archivo a la ruta de trabajo
# Para efectos del examen, simulamos la descarga a la carpeta actual o /opt/webapp
sudo curl -o /opt/webapp/docker-compose.yml https://gist.githubusercontent.com/DarkestAbed/0clcee748bb9e3b22f89efe1933bf125/raw/5801164c0a6e4df7d8ced00122c76895997127a2/docker-compose.yml || echo "Advertencia: Usando archivo local si la descarga falla"

echo ">>> Generando sitio web >>>"
# Crear index.html con el texto requerido
echo "<h1>Servidor Seguro Propiedad de [Benjamin Gajardo Alias FLOWSITO - Acceso Restringido]</h1>" | sudo tee /opt/webapp/html/index.html

echo ">>> Gestión de usuarios >>>"
# Crear usuario sysadmin con shell bash
# El '|| true' evita que el script falle si el usuario ya existe
sudo useradd -m -s /bin/bash sysadmin || true

# Agregar usuario al grupo docker
sudo usermod -aG docker sysadmin

echo ">>> Aprovisionamiento completado."
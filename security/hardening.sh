#!/bin/bash

# ==========================================
# Módulo 2: Endurecimiento del Sistema (Hardening)
# Alumno: FLOWSITO
# ==========================================

echo ">>> Iniciando configuración de seguridad >>>"

# 1. Configuración del Firewall (UFW)
sudo ufw default deny incoming

# Abrimos solo los puertos necesarios:
# Puerto 22 para poder administrar por SSH
sudo ufw allow 22/tcp
# Puerto 8080 para que se vea la web
sudo ufw allow 8080/tcp

# Habilitamos el firewall (la 'y' es para confirmar automáticamente)
echo "y" | sudo ufw enable
echo ">>> Firewall configurado."

# 2. Seguridad SSH
# Editamos el archivo sshd_config para quitar el acceso root
SSH_FILE="/etc/ssh/sshd_config"

if [ -f "$SSH_FILE" ]; then
    echo ">>> Asegurando SSH >>>"
    
    # Buscamos si existe la linea PermitRootLogin.
    # Si existe, la forzamos a 'no'
    if grep -q "PermitRootLogin" "$SSH_FILE"; then
        sudo sed -i 's/^.*PermitRootLogin.*/PermitRootLogin no/' "$SSH_FILE"
    else
        # Si no existe, la agregamos al final del archivo
        echo "PermitRootLogin no" | sudo tee -a "$SSH_FILE"
    fi
    
    # Reiniciamos el servicio para aplicar cambios
    # Probamos con 'ssh', si falla probamos con 'sshd' (por compatibilidad)
    sudo systemctl restart ssh || sudo systemctl restart sshd
else
    echo "AVISO: No se encontró el archivo de configuración SSH ($SSH_FILE)"
fi

# 3. Permisos de Archivos (Principio de Menor Privilegio)
echo ">>> Ajustando permisos de archivos críticos..."

# Los scripts solo deben ser ejecutables por el dueño (700)
# El docker-compose solo lectura por el dueño (600)

# Usamos rutas relativas asumiendo que estamos en la carpeta /security
chmod 700 ../deploy/setup.sh 2>/dev/null
chmod 700 ../maintenance/backup.sh 2>/dev/null
chmod 600 ../deploy/docker-compose.yml 2>/dev/null

echo ">>> Hardening completado exitosamente."
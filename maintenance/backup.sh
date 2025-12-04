#!/bin/bash

# ==========================================
# Módulo 3: Estrategia de Respaldo
# Autor: FLOWSITO
# ==========================================

# Definir variables de fecha 
FECHA=$(date +"%Y-%m-%d_%H%M")
ARCHIVO_BACKUP="backup_web_${FECHA}.tar.gz"
ORIGEN="/opt/webapp/html"
DESTINO_LOCAL="/var/backups/webapp"

echo ">>> Iniciando respaldo >>>"

# Crear directorio de respaldo local si no existe
sudo mkdir -p $DESTINO_LOCAL

echo ">>> Comprimiendo archivos >>>"
# Generar archivo .tar.gz
sudo tar -czf $ARCHIVO_BACKUP -C /opt/webapp html

echo ">>> Sincronización Local >>>"
# Usar rsync para mover al directorio de seguridad
sudo rsync -av $ARCHIVO_BACKUP $DESTINO_LOCAL/

echo ">>> Sincronización Remota >>>"
# Intentaremos enviar a localhost para demostrar la sintaxis correcta.
scp $ARCHIVO_BACKUP sysadmin@127.0.0.1:/tmp/ || echo "Nota: Transferencia remota simulada (requiere configuración de llaves)"

# Limpieza del archivo temporal
rm $ARCHIVO_BACKUP

echo ">>> Respaldo finalizado exitosamente."
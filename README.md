Examen Final Transversal: Infraestructura TechSolutions

Este repositorio contiene la solución técnica para el Examen Final de Programación y Administración Linux. El proyecto simula el despliegue de una infraestructura segura para la empresa "TechSolutions", utilizando scripts de automatización en Bash y contenedores Docker.

1. Guía de Despliegue

Para replicar este entorno, siga estrictamente el siguiente orden de ejecución. Se asume que se utiliza una distribución basada en Debian/Ubuntu.

Paso 1: Clonar el Repositorio

Descargue el código fuente a su máquina local:

git clone [https://github.com/BenjaminGajardoRo/Examen-Linux.git](https://github.com/BenjaminGajardoRo/Examen-Linux.git)
cd Examen-Linux


Paso 2: Aprovisionamiento (Setup)

Este módulo instala las dependencias (Docker, Git, Curl) y levanta el contenedor web.

cd deploy
# Dar permisos de ejecución
chmod +x setup.sh
# Ejecutar script
sudo ./setup.sh

# Levantar el servicio web
cd /opt/webapp
sudo docker-compose up -d


Paso 3: Endurecimiento (Hardening)

Este módulo aplica las reglas de firewall y asegura el servicio SSH.

# Volver a la raíz del repositorio y entrar a security
cd ../../security
chmod +x hardening.sh
sudo ./hardening.sh


Paso 4: Respaldo (Backup)

Este módulo genera una copia comprimida del sitio web y simula su transferencia.

cd ../maintenance
chmod +x backup.sh
sudo ./backup.sh


2. Justificación de Seguridad

En el desarrollo de este proyecto, se han aplicado principios fundamentales de ciberseguridad defensiva para proteger el servidor de TechSolutions.

En primer lugar, deshabilitar el acceso directo del usuario root a través de SSH es una medida crítica. El usuario root es un objetivo estándar conocido por todos los ciberdelincuentes; permitir su acceso directo facilita enormemente los ataques de fuerza bruta, ya que el atacante solo necesita adivinar la contraseña. Al obligar el uso de un usuario estándar (sysadmin), añadimos una capa de oscuridad y permitimos una mejor auditoría de quién ingresa al sistema (trazabilidad).

En segundo lugar, la implementación del Firewall (UFW) con una política por defecto de "Denegar Todo" (Default Deny) reduce drásticamente la superficie de ataque. Al cerrar todas las puertas y abrir exclusivamente el puerto 22 (gestión) y el 8080 (servicio web), nos aseguramos de que, si algún otro servicio vulnerable se ejecutara accidentalmente en el servidor, este no sería accesible desde el exterior, garantizando así la confidencialidad y la integridad de la infraestructura ante escaneos de red maliciosos.

3. Registro de Evidencia

A continuación se adjuntan las capturas de pantalla que validan el correcto funcionamiento de los scripts.

3.1 Estado del Firewall (UFW Status)

Se evidencia la política por defecto 'deny' y las excepciones para SSH y Web.

3.2 Configuración SSH Modificada

Validación de que PermitRootLogin está configurado en no.

3.3 Acceso Web Exitoso

Prueba de funcionamiento del contenedor Nginx mostrando el index.html personalizado.

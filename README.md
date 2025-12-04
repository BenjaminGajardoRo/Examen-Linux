# Examen Final Transversal: Infraestructura TechSolutions

Este repositorio contiene la solución técnica desarrollada para el **Examen Final de Programación y Administración Linux**, cuyo objetivo es simular el despliegue de una infraestructura segura para la empresa ficticia **TechSolutions**.  
El proyecto incluye aprovisionamiento automático, endurecimiento del sistema y un módulo de respaldo, utilizando **scripts Bash**, **Docker** y **Docker Compose**.

---

## 1. Guía de Despliegue

> **Requisito:** se asume una distribución basada en **Debian/Ubuntu**.  
> Ejecute los pasos en el **orden exacto**.

### Paso 1: Clonar el Repositorio

```bash
git clone https://github.com/BenjaminGajardoRo/Examen-Linux.git
cd Examen-Linux
```

### Paso 2: Aprovisionamiento (Setup)

Instala dependencias esenciales (Docker, Git, Curl) y despliega el servicio web.

```bash
cd deploy
chmod +x setup.sh
sudo ./setup.sh
```

Levantar el contenedor web:

```bash
cd /opt/webapp
sudo docker-compose up -d
```

### Paso 3: Endurecimiento del Sistema (Hardening)

Configura el firewall y asegura el servicio SSH.

```bash
cd ../../security
chmod +x hardening.sh
sudo ./hardening.sh
```

### Paso 4: Respaldo del Sitio (Backup)

Genera una copia comprimida del sitio web y simula su transferencia externa.

```bash
cd ../maintenance
chmod +x backup.sh
sudo ./backup.sh
```

---

## 2. Justificación de Seguridad

Las medidas aplicadas siguen principios fundamentales de **ciberseguridad defensiva** para proteger la infraestructura.

### Deshabilitar acceso root por SSH
El usuario `root` es un blanco común en ataques de fuerza bruta. Deshabilitar su acceso:

- evita intentos de intrusión directa,
- obliga a usar usuarios estándar (mejor trazabilidad),
- reduce la superficie de ataque del servidor.

### Firewall con política “Default Deny”
El firewall UFW se configura para:

- bloquear todo el tráfico entrante por defecto,
- permitir solo los puertos:
  - `22/tcp` → administración por SSH  
  - `8080/tcp` → servicio web  

Esto evita exposición accidental de otros servicios y mitiga escaneos maliciosos.

---

## 3. Registro de Evidencia

El repositorio incorpora capturas que validan el funcionamiento de cada módulo.

### 3.1 Estado del Firewall (UFW)
- Política por defecto `deny`
- Reglas activas para SSH y Web

### 3.2 Configuración SSH
- `PermitRootLogin no` debidamente aplicado

### 3.3 Acceso Web Exitoso
- Contenedor Nginx funcionando con `index.html` personalizado

---

## Estructura del Proyecto

```
Examen-Linux/
│
├── deploy/            # Aprovisionamiento del sistema
│   └── setup.sh
│
├── security/          # Hardening del servidor
│   └── hardening.sh
│
├── maintenance/       # Respaldo del sitio
│   └── backup.sh
│
└── README.md
```



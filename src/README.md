# Docker Environment para BBDD1

Este directorio contiene la configuración de Docker para ejecutar un entorno local con MySQL y phpMyAdmin para el curso de Base de Datos 1.

## Estructura del proyecto

```
src/
├── docker-compose.yml      # Configuración principal de Docker Compose
├── Dockerfile             # Dockerfile personalizado para MySQL
├── .env                   # Variables de entorno (configuración local)
├── .env.example          # Ejemplo de variables de entorno
├── my.cnf                # Configuración personalizada de MySQL
├── sql-scripts/          # Scripts de inicialización de la base de datos
│   └── init.sql
└── README.md
```

## Servicios incluidos

- **MySQL 8.0**: Base de datos principal con configuración personalizada
- **phpMyAdmin**: Interface web para administrar la base de datos

## Configuración inicial

### 1. Configurar variables de entorno
Copia el archivo de ejemplo y personaliza las variables:
```bash
cp .env.example .env
```

Edita el archivo `.env` con tus credenciales preferidas.

### 2. Variables de entorno disponibles

| Variable | Descripción | Valor por defecto |
|----------|-------------|-------------------|
| `MYSQL_ROOT_PASSWORD` | Contraseña del usuario root | `rootpassword` |
| `MYSQL_DATABASE` | Nombre de la base de datos | `bbdd1_db` |
| `MYSQL_USER` | Usuario de aplicación | `bbdd1_user` |
| `MYSQL_PASSWORD` | Contraseña del usuario | `bbdd1_pass` |
| `MYSQL_PORT` | Puerto de MySQL | `3306` |
| `PHPMYADMIN_PORT` | Puerto de phpMyAdmin | `8080` |

## Instrucciones de uso

### 1. Construir e iniciar el entorno
```bash
cd src
docker-compose up --build -d
```

### 2. Acceder a phpMyAdmin
Abrir en el navegador: `http://localhost:8080` (o el puerto configurado en `PHPMYADMIN_PORT`)
- Usuario: `root`
- Contraseña: El valor de `MYSQL_ROOT_PASSWORD`

### 3. Conectar desde aplicaciones
- **Host**: `localhost`
- **Puerto**: El valor de `MYSQL_PORT` (por defecto `3306`)
- **Base de datos**: El valor de `MYSQL_DATABASE`
- **Usuario**: `MYSQL_USER` (para aplicaciones) o `root` (para administración)
- **Contraseña**: `MYSQL_PASSWORD` o `MYSQL_ROOT_PASSWORD` respectivamente

### 4. Ver logs de los contenedores
```bash
# Logs de MySQL
docker-compose logs mysql

# Logs de phpMyAdmin
docker-compose logs phpmyadmin

# Logs en tiempo real
docker-compose logs -f
```

### 5. Detener el entorno
```bash
docker-compose down
```

### 6. Detener y eliminar datos
```bash
docker-compose down -v
```

### 7. Reconstruir desde cero
```bash
docker-compose down -v
docker-compose build --no-cache
docker-compose up -d
```

## Características avanzadas

### Dockerfile personalizado
- Basado en MySQL 8.0 oficial
- Configuración personalizada mediante `my.cnf`
- Scripts de inicialización automática
- Configuración optimizada para desarrollo

### Configuración de MySQL (my.cnf)
- Charset UTF-8 por defecto
- Logs habilitados
- Configuración de rendimiento optimizada
- Acceso desde cualquier IP (desarrollo local)

### Health checks
- Verificación automática del estado de MySQL
- phpMyAdmin espera a que MySQL esté completamente listo

## Archivos de inicialización

Los archivos SQL en la carpeta `sql-scripts/` se ejecutarán automáticamente cuando se cree el contenedor por primera vez. Actualmente incluye:

- `init.sql`: Crea una tabla de ejemplo con datos de prueba

## Volúmenes persistentes

- `mysql_data`: Datos de la base de datos
- `mysql_logs`: Logs de MySQL

## Seguridad

- Las contraseñas se configuran mediante variables de entorno
- El archivo `.env` debe ser excluido del control de versiones en producción
- Configuración de MySQL con modo estricto habilitado

## Troubleshooting

### Problema de permisos
```bash
sudo chown -R $USER:$USER .
```

### Reinicializar completamente
```bash
docker-compose down -v
docker system prune -f
docker-compose up --build -d
```

### Ver estado de los contenedores
```bash
docker-compose ps
```
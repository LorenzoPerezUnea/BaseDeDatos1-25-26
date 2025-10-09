# Taller Guiado — Lenguaje DDL en SQL

### Objetivo

Aprender de forma práctica las instrucciones de definición de datos (DDL):
**CREATE**, **ALTER**, **DROP** y **TRUNCATE**.

Este taller se realiza sobre la base de datos `tienda`, ya creada por el contenedor Docker.

## Crear Bases de Datos

Eliminar y Crear una Base de Datos.

```sql
--  Eliminar la base de datos si ya existe
DROP DATABASE IF EXISTS tienda;

--  Crear nuevamente la base de datos con configuración UTF-8
CREATE DATABASE tienda
CHARACTER SET utf8mb4
COLLATE utf8mb4_general_ci;

--  Seleccionar la base de datos recién creada
USE tienda;

--  Confirmar que está vacía (opcional)
SHOW TABLES;
```

## Crear tablas base

Crear las tablas iniciales `categoria`, `producto` y `cliente`.
Objetivo: Crear la estructura inicial con claves primarias, foráneas y restricciones.

```sql
CREATE TABLE categoria (
  id_categoria INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  descripcion TEXT
);

CREATE TABLE producto (
  id_producto INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  precio DECIMAL(10,2) NOT NULL CHECK (precio > 0),
  stock INT DEFAULT 0,
  id_categoria INT,
  FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria)
);

CREATE TABLE cliente (
  id_cliente INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  email VARCHAR(100) UNIQUE,
  fecha_registro TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
```

## Modificar la estructura con ALTER TABLE

Agregar nuevos campos a las tablas existentes.
Objetivo: Practicar cómo añadir o modificar columnas sin eliminar la tabla.

```sql
-- Agregar columna telefono a cliente
ALTER TABLE cliente
ADD COLUMN telefono VARCHAR(20);

-- Cambiar tipo de dato del campo stock
ALTER TABLE producto
MODIFY COLUMN stock INT UNSIGNED DEFAULT 0;

-- Añadir columna activa con valor por defecto
ALTER TABLE categoria
ADD COLUMN activa BOOLEAN DEFAULT TRUE;
```

## Crear una tabla nueva con relaciones

Crear una tabla pedido y una tabla detalle_pedido que referencien otras tablas.
Objetivo: Comprender la importancia de las claves foráneas y las dependencias entre tablas.

```sql
CREATE TABLE pedido (
  id_pedido INT AUTO_INCREMENT PRIMARY KEY,
  id_cliente INT NOT NULL,
  fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  total DECIMAL(10,2) DEFAULT 0,
  FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

CREATE TABLE detalle_pedido (
id_detalle INT AUTO_INCREMENT PRIMARY KEY,
id_pedido INT,
id_producto INT,
cantidad INT DEFAULT 1,
subtotal DECIMAL(10,2),
FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);
```

## Modificaciones avanzadas

Cambiar nombres, crear restricciones y agregar claves.
Objetivo: Introducir buenas prácticas de nomenclatura y validación.

```sql
-- Renombrar una tabla
ALTER TABLE cliente RENAME TO clientes;

-- Agregar restricción CHECK
ALTER TABLE producto
ADD CONSTRAINT chk_precio CHECK (precio > 0);

-- Agregar una clave foránea con nombre explícito
ALTER TABLE detalle_pedido
ADD CONSTRAINT fk_detalle_pedido_pedido
FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido)
ON DELETE CASCADE;
```

## Crear índices

Objetivo: Mejorar la velocidad de búsqueda y las consultas filtradas.

```sql
-- Índice simple
CREATE INDEX idx_nombre_producto ON producto(nombre);

-- Índice compuesto
CREATE INDEX idx_pedido_cliente_fecha ON pedido(id_cliente, fecha);
```

## Probar TRUNCATE y DROP

```sql
-- Vaciar la tabla detalle_pedido (mantiene estructura)
TRUNCATE TABLE detalle_pedido;

-- Borrar completamente la tabla detalle_pedido
DROP TABLE detalle_pedido;

-- Eliminar toda la base de datos (solo demostrativo) 
DROP DATABASE tienda;
```


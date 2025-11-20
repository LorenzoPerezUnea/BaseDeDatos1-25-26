## Caso base: datos sin normalizar

Comenzamos con una tabla que contiene información redundante y anidada.
Ejemplo: una tienda almacena todos los datos en una sola tabla.

```sql
CREATE DATABASE tienda_no_normalizada;
USE tienda_no_normalizada;

CREATE TABLE venta (
  id_venta INT PRIMARY KEY,
  cliente_nombre VARCHAR(100),
  cliente_ciudad VARCHAR(100),
  productos VARCHAR(255),
  total DECIMAL(10,2)
);

INSERT INTO venta VALUES
(1, 'Ana Pérez', 'Quito', 'Televisor, Cafetera', 1020.00),
(2, 'Bruno Díaz', 'Guayaquil', 'Laptop', 950.00),
(3, 'Carla Mena', 'Quito', 'Almohada, Cafetera', 120.00);
```

## Migración hacia la **Primera Forma Normal (1FN)**

**Objetivo:** eliminar los grupos repetidos (listas dentro de una celda) → cada producto en una fila separada.

### 1. Crear nuevas tablas normalizadas

```sql
CREATE TABLE cliente (
  id_cliente INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100),
  ciudad VARCHAR(100)
);

CREATE TABLE producto (
  id_producto INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100)
);

CREATE TABLE venta_detalle (
  id_detalle INT AUTO_INCREMENT PRIMARY KEY,
  id_venta INT,
  id_cliente INT,
  id_producto INT,
  total DECIMAL(10,2)
);
```

### 2. Insertar datos en las nuevas tablas

Migramos los ​**clientes únicos**​:

```sql
INSERT INTO cliente (nombre, ciudad)
SELECT DISTINCT cliente_nombre, cliente_ciudad FROM venta;
```

Insertamos **productos** manualmente, según los datos existentes:

```sql
INSERT INTO producto (nombre)
VALUES ('Televisor'), ('Cafetera'), ('Laptop'), ('Almohada');
```

Insertamos los **detalles de venta** (ahora normalizados por producto):

```sql
INSERT INTO venta_detalle (id_venta, id_cliente, id_producto, total)
VALUES
(1, 1, 1, 950.00),
(1, 1, 2, 70.00),
(2, 2, 3, 950.00),
(3, 3, 4, 70.00),
(3, 3, 2, 50.00);
```

### 3. Crear relaciones de integridad

```sql
ALTER TABLE venta_detalle
ADD FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
ADD FOREIGN KEY (id_producto) REFERENCES producto(id_producto);
```

### 4. Limpiar tabla antigua

```sql
DROP TABLE venta;
```

### 5. Consulta de verificación

```sql
SELECT v.id_venta, c.nombre AS cliente, p.nombre AS producto, v.total
FROM venta_detalle v
JOIN cliente c ON v.id_cliente = c.id_cliente
JOIN producto p ON v.id_producto = p.id_producto
ORDER BY v.id_venta;

```

Ahora los datos cumplen ​**Primera Forma Normal (1FN)**​.


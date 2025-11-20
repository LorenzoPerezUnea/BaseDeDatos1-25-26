# Taller Integrado de Normalización (2FN → 5FN)

## Objetivo del Taller

El propósito de este taller es que los estudiantes apliquen **todas las etapas de normalización (desde 2FN hasta 5FN)** sobre un conjunto de tablas **parcialmente desnormalizadas**, resolviendo paso a paso:

- Identificación de problemas de diseño.
- Creación de nuevas tablas normalizadas.
- Migración de datos con `INSERT ... SELECT DISTINCT`.
- Establecimiento de claves foráneas con `REFERENCES`.
- Eliminación de atributos redundantes.

## Escenario Inicial (Base No Normalizada)

Una empresa de **distribución de suministros industriales** lleva su información en tres tablas que **violan distintas formas normales**:

```sql
CREATE DATABASE taller_normalizacion;
USE taller_normalizacion;

CREATE TABLE cliente_pedido (
  id_cliente INT AUTO_INCREMENT PRIMARY KEY,
  nombre_cliente VARCHAR(100),
  direccion VARCHAR(150),
  id_pedido INT,
  fecha_pedido DATE,
  producto VARCHAR(100),
  cantidad INT,
  precio_unitario DECIMAL(10,2),
  region VARCHAR(100)
);

CREATE TABLE proveedor_producto_region (
  id_proveedor INT AUTO_INCREMENT PRIMARY KEY,
  nombre_proveedor VARCHAR(100),
  producto VARCHAR(100),
  region VARCHAR(100),
  precio DECIMAL(10,2)
);

CREATE TABLE producto_categoria (
  id_producto INT AUTO_INCREMENT PRIMARY KEY,
  nombre_producto VARCHAR(100),
  categoria VARCHAR(100),
  subcategoria VARCHAR(100)
);
```

```sql
INSERT INTO cliente_pedido (nombre_cliente, direccion, id_pedido, fecha_pedido, producto, cantidad, precio_unitario, region)
VALUES
('Ana Torres', 'Av. Central 101', 1, '2024-05-10', 'Tornillos', 100, 0.25, 'Norte'),
('Ana Torres', 'Av. Central 101', 1, '2024-05-10', 'Tuercas', 100, 0.30, 'Norte'),
('Carlos Ruiz', 'Calle 12 #45', 2, '2024-05-12', 'Arandelas', 50, 0.15, 'Centro'),
('Carlos Ruiz', 'Calle 12 #45', 3, '2024-06-02', 'Tornillos', 200, 0.22, 'Centro'),
('Laura Díaz', 'Av. Sur 303', 4, '2024-06-15', 'Tuercas', 150, 0.28, 'Sur');

INSERT INTO proveedor_producto_region (nombre_proveedor, producto, region, precio)
VALUES
('Industrias Norte', 'Tornillos', 'Norte', 0.10),
('Industrias Norte', 'Tuercas', 'Norte', 0.12),
('Acero Andino', 'Arandelas', 'Centro', 0.08),
('MetalSur', 'Tuercas', 'Sur', 0.11),
('MetalSur', 'Tornillos', 'Sur', 0.09);

INSERT INTO producto_categoria (nombre_producto, categoria, subcategoria)
VALUES
('Tornillos', 'Fijaciones', 'Metálicos'),
('Tuercas', 'Fijaciones', 'Metálicos'),
('Arandelas', 'Fijaciones', 'Metálicos'),
('Cable eléctrico', 'Conectividad', 'Cobre'),
('Conector', 'Conectividad', 'Plástico');
```

## Formulación del Ejercicio

Los estudiantes deben:

1. **Analizar las tablas anteriores** e identificar qué formas normales se violan:
   * Dependencias parciales (2FN).
   * Dependencias transitivas (3FN).
   * Dependencias multivaluadas (4FN).
   * Dependencias de unión (5FN).
2. **Crear nuevas tablas** que cumplan las formas normales correspondientes.
3. **Migrar los datos existentes** usando consultas `INSERT ... SELECT DISTINCT`.
4. **Establecer claves foráneas** con `REFERENCES`.
5. **Eliminar los atributos y las tablas** que ya no sean necesarios.


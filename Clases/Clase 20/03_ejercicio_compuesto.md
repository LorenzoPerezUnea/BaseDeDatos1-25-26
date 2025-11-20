# Ejercicio Integral de Normalización (2FN → 5FN)

**Contexto:**
La empresa **TecnoAbastece** gestiona compras de **productos industriales** a ​**proveedores**​, que se agrupan por ​**categoría**​.
Cada proveedor puede ofrecer productos de varias categorías, y los pedidos se realizan a proveedores específicos.

La base de datos original no está normalizada: contiene redundancias y dependencias parciales y transitivas.
A lo largo del ejercicio se normalizará desde la ​**Segunda hasta la Quinta Forma Normal**​.

## Fase 0 — Creación de la base de datos y estructura inicial (no normalizada)

```sql
CREATE DATABASE tecnoabastece;
USE tecnoabastece;

CREATE TABLE pedido_detalle_raw (
  id_pedido INT,
  id_proveedor INT,
  nombre_proveedor VARCHAR(100),
  categoria_producto VARCHAR(50),
  producto VARCHAR(100),
  precio DECIMAL(10,2),
  cantidad INT,
  total DECIMAL(10,2)
);

INSERT INTO pedido_detalle_raw VALUES
(1, 10, 'InduPartes', 'Lubricantes', 'Aceite 5W30', 20.00, 10, 200.00),
(1, 10, 'InduPartes', 'Lubricantes', 'Grasa Industrial', 15.00, 5, 75.00),
(2, 11, 'TecnoFer', 'Herramientas', 'Taladro', 80.00, 2, 160.00),
(2, 11, 'TecnoFer', 'Herramientas', 'Brocas', 10.00, 10, 100.00),
(3, 12, 'InsumosPro', 'Lubricantes', 'Aceite 5W30', 18.00, 20, 360.00),
(3, 12, 'InsumosPro', 'Limpieza', 'Desengrasante', 12.00, 15, 180.00);
```

🔍 **Problemas detectados:**

* Redundancia de nombres de proveedor y categoría.
* Dependencias parciales (la categoría depende del producto, no del pedido).
* Dependencias transitivas (el total depende de precio × cantidad).

## Fase 1 — Segunda Forma Normal (2FN)

**Objetivo:** Eliminar dependencias parciales.
Cada campo no clave debe depender de ​**toda la clave primaria**​, no solo de una parte.

1. Dividimos la información en tres entidades:
   
   * `pedido`
   * `proveedor`
   * `detalle_pedido`

```sql
CREATE TABLE proveedor (
  id_proveedor INT PRIMARY KEY,
  nombre_proveedor VARCHAR(100)
);

CREATE TABLE pedido (
  id_pedido INT PRIMARY KEY,
  id_proveedor INT,
  FOREIGN KEY (id_proveedor) REFERENCES proveedor(id_proveedor)
);

CREATE TABLE detalle_pedido (
  id_detalle INT AUTO_INCREMENT PRIMARY KEY,
  id_pedido INT,
  producto VARCHAR(100),
  categoria_producto VARCHAR(50),
  precio DECIMAL(10,2),
  cantidad INT,
  total DECIMAL(10,2),
  FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido)
);
```

Cargamos los datos automáticamente con `SELECT DISTINCT`:

```sql
INSERT INTO proveedor
SELECT DISTINCT id_proveedor, nombre_proveedor FROM pedido_detalle_raw;

INSERT INTO pedido
SELECT DISTINCT id_pedido, id_proveedor FROM pedido_detalle_raw;

INSERT INTO detalle_pedido (id_pedido, producto, categoria_producto, precio, cantidad, total)
SELECT id_pedido, producto, categoria_producto, precio, cantidad, total FROM pedido_detalle_raw;
```

Dependencias parciales eliminadas.
Cada detalle depende completamente del pedido.

## Fase 2 — Tercera Forma Normal (3FN)

**Objetivo:** Eliminar dependencias transitivas.
Los atributos no clave no deben depender de otros no clave.

1. El atributo `categoria_producto` depende de `producto`, no del `id_pedido`.
2. Creamos una tabla de `producto` independiente con su categoría.

```sql
CREATE TABLE producto (
  id_producto INT AUTO_INCREMENT PRIMARY KEY,
  nombre_producto VARCHAR(100),
  categoria_producto VARCHAR(50)
);

INSERT INTO producto (nombre_producto, categoria_producto)
SELECT DISTINCT producto, categoria_producto FROM detalle_pedido;
```

Actualizamos `detalle_pedido`:

```sql
ALTER TABLE detalle_pedido ADD COLUMN id_producto INT;

UPDATE detalle_pedido dp
JOIN producto p ON dp.producto = p.nombre_producto
SET dp.id_producto = p.id_producto;

ALTER TABLE detalle_pedido
DROP COLUMN producto,
DROP COLUMN categoria_producto;

ALTER TABLE detalle_pedido
ADD FOREIGN KEY (id_producto) REFERENCES producto(id_producto);
```

Ahora no hay dependencias transitivas.
Cada detalle referencia un producto único con su categoría.

## Fase 3 — Cuarta Forma Normal (4FN)

**Objetivo:** Eliminar dependencias multivaluadas.

Ahora, cada **proveedor** puede ofrecer múltiples **productos** y trabajar con múltiples ​**categorías**​.
Estas dos dimensiones son ​**independientes**​, por lo que las separamos.

```sql
CREATE TABLE proveedor_categoria (
  id_proveedor INT,
  categoria_producto VARCHAR(50),
  FOREIGN KEY (id_proveedor) REFERENCES proveedor(id_proveedor)
);

CREATE TABLE proveedor_producto (
  id_proveedor INT,
  id_producto INT,
  FOREIGN KEY (id_proveedor) REFERENCES proveedor(id_proveedor),
  FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);

INSERT INTO proveedor_categoria
SELECT DISTINCT p.id_proveedor, pr.categoria_producto
FROM pedido_detalle_raw pr
JOIN proveedor p ON pr.id_proveedor = p.id_proveedor;

INSERT INTO proveedor_producto
SELECT DISTINCT pr.id_proveedor, pd.id_producto
FROM detalle_pedido pd
JOIN pedido p ON pd.id_pedido = p.id_pedido
JOIN proveedor pr ON p.id_proveedor = pr.id_proveedor;
```

Dependencias multivaluadas separadas.
Un proveedor puede tener múltiples categorías y productos sin redundancia.

## Fase 4 — Quinta Forma Normal (5FN)

**Objetivo:** Eliminar dependencias de unión.
Queremos representar correctamente relaciones entre ​**proveedor**​, **producto** y **región** de distribución.

1. Añadimos una tabla `region_distribucion` (los proveedores venden productos a regiones específicas).
2. Las dependencias de unión se normalizan creando tres relaciones base.

```sql
CREATE TABLE region_distribucion (
  id_region INT AUTO_INCREMENT PRIMARY KEY,
  nombre_region VARCHAR(100)
);

INSERT INTO region_distribucion (nombre_region) VALUES
('Europa'), ('América'), ('Asia');

CREATE TABLE proveedor_region (
  id_proveedor INT,
  id_region INT,
  FOREIGN KEY (id_proveedor) REFERENCES proveedor(id_proveedor),
  FOREIGN KEY (id_region) REFERENCES region_distribucion(id_region)
);

INSERT INTO proveedor_region (id_proveedor, id_region)
VALUES (10, 1), (10, 2), (11, 2), (12, 3);
```

Ahora se puede reconstruir la relación ternaria **Proveedor–Producto–Región** sin redundancia:

```sql
SELECT DISTINCT pr.nombre_proveedor, p.nombre_producto, r.nombre_region
FROM proveedor pr
JOIN proveedor_producto pp ON pr.id_proveedor = pp.id_proveedor
JOIN producto p ON pp.id_producto = p.id_producto
JOIN proveedor_region prr ON pr.id_proveedor = prr.id_proveedor
JOIN region_distribucion r ON prr.id_region = r.id_region;
```

Cumple 5FN: cada combinación se deriva de tres dependencias binarias sin pérdida ni redundancia.

## Resumen del Proceso

| Fase | Forma Normal   | Acción principal                   | Resultado                          |
| ------ | ---------------- | ------------------------------------- | ------------------------------------ |
| 0    | Sin normalizar | Todo mezclado                       | Redundancia total                  |
| 1    | 2FN            | Eliminar dependencias parciales     | Separación de pedido y proveedor  |
| 2    | 3FN            | Eliminar dependencias transitivas   | Separación de producto            |
| 3    | 4FN            | Eliminar dependencias multivaluadas | Separación proveedor–categoría  |
| 4    | 5FN            | Eliminar dependencias de unión     | Relación ternaria sin redundancia |


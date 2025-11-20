## **Quinta Forma Normal (5FN)**

### **Concepto**

Una tabla está en **Quinta Forma Normal (5FN)** —también conocida como ​**Forma Normal de Proyección-Unión (PJ/NF)**​— si:

1. Está en ​**Cuarta Forma Normal**​, y
2. No puede descomponerse más sin **perder información** (es decir, no hay ​**dependencias de unión no triviales**​).

La 5FN se aplica cuando la información puede reconstruirse a partir de varias tablas ​**sin pérdida**​, pero mantener todo junto genera redundancia.

### **Ejemplo teórico (no normalizado)**

Supongamos una empresa donde cada **proveedor** puede **suministrar** ciertos **productos** a ciertas ​**tiendas**​.

No todos los proveedores venden a todas las tiendas, ni todos los productos están disponibles en todas las tiendas.

**Tabla PROVEEDOR_PRODUCTO_TIENDA**

| proveedor | producto | tienda  |
| ----------- | ---------- | --------- |
| A         | Tornillo | Madrid  |
| A         | Tornillo | Sevilla |
| A         | Tuerca   | Madrid  |
| B         | Tuerca   | Madrid  |

Aquí hay redundancia:
La relación entre proveedor y tienda, y entre producto y tienda, es ​**independiente**​, pero al combinar las tres, se repiten combinaciones.

### **Normalización a 5FN**

Dividimos en tres relaciones más simples:

1. Qué proveedor ofrece qué productos.
2. Qué productos se venden en qué tiendas.
3. Qué proveedor distribuye a qué tiendas.

**PROVEEDOR_PRODUCTO**

| proveedor | producto |
| ----------- | ---------- |
| A         | Tornillo |
| A         | Tuerca   |
| B         | Tuerca   |

**PRODUCTO_TIENDA**

| producto | tienda  |
| ---------- | --------- |
| Tornillo | Madrid  |
| Tornillo | Sevilla |
| Tuerca   | Madrid  |

**PROVEEDOR_TIENDA**

| proveedor | tienda  |
| ----------- | --------- |
| A         | Madrid  |
| A         | Sevilla |
| B         | Madrid  |

Con estas tres tablas podemos reconstruir la relación original mediante una unión de tres tablas, sin pérdida de información y sin redundancia.

### **Ejemplo SQL — 5ª Forma Normal**

```sql
-- Tabla no normalizada
CREATE TABLE proveedor_producto_tienda (
  proveedor VARCHAR(50),
  producto VARCHAR(50),
  tienda VARCHAR(50)
);

INSERT INTO proveedor_producto_tienda VALUES
('A', 'Tornillo', 'Madrid'),
('A', 'Tornillo', 'Sevilla'),
('A', 'Tuerca', 'Madrid'),
('B', 'Tuerca', 'Madrid');

-- Normalización en tres tablas
CREATE TABLE proveedor_producto (
  proveedor VARCHAR(50),
  producto VARCHAR(50)
);

CREATE TABLE producto_tienda (
  producto VARCHAR(50),
  tienda VARCHAR(50)
);

CREATE TABLE proveedor_tienda (
  proveedor VARCHAR(50),
  tienda VARCHAR(50)
);

-- Insertamos datos normalizados
INSERT INTO proveedor_producto (proveedor, producto)
SELECT DISTINCT proveedor, producto
FROM proveedor_producto_tienda;

INSERT INTO producto_tienda (producto, tienda)
SELECT DISTINCT producto, tienda
FROM proveedor_producto_tienda;

INSERT INTO proveedor_tienda (proveedor, tienda)
SELECT DISTINCT proveedor, tienda
FROM proveedor_producto_tienda;
```

### **Reconstrucción de la relación original (JOIN múltiple)**

```sql
SELECT DISTINCT
  p.proveedor,
  pr.producto,
  t.tienda
FROM proveedor_producto p
JOIN producto_tienda pr ON p.producto = pr.producto
JOIN proveedor_tienda t ON p.proveedor = t.proveedor;
```

Este SELECT devuelve la misma información que la tabla no normalizada, pero ​**sin redundancia ni anomalías**​.


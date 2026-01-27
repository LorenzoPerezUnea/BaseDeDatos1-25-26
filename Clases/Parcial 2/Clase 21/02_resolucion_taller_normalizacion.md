## Resolución

### Paso 1. Normalización de `cliente_pedido` (2FN → 3FN)

**Problema:**

* Dependencias parciales: los datos del cliente se repiten en cada pedido.
* Dependencias transitivas: el precio y la región dependen del producto.

**Solución:**

#### a) Crear nuevas tablas:

```sql
CREATE TABLE cliente (
  id_cliente INT AUTO_INCREMENT PRIMARY KEY,
  nombre_cliente VARCHAR(100),
  direccion VARCHAR(150)
);

CREATE TABLE pedido (
  id_pedido INT PRIMARY KEY,
  id_cliente INT,
  fecha_pedido DATE,
  FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

CREATE TABLE detalle_pedido (
  id_detalle INT AUTO_INCREMENT PRIMARY KEY,
  id_pedido INT,
  producto VARCHAR(100),
  cantidad INT,
  precio_unitario DECIMAL(10,2),
  region VARCHAR(100),
  FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido)
);
```

#### b) Migrar datos con `INSERT ... SELECT DISTINCT`

```sql
INSERT INTO cliente (nombre_cliente, direccion)
SELECT DISTINCT nombre_cliente, direccion
FROM cliente_pedido;

INSERT INTO pedido (id_pedido, id_cliente, fecha_pedido)
SELECT DISTINCT cp.id_pedido, c.id_cliente, cp.fecha_pedido
FROM cliente_pedido cp
JOIN cliente c ON cp.nombre_cliente = c.nombre_cliente;

INSERT INTO detalle_pedido (id_pedido, producto, cantidad, precio_unitario, region)
SELECT id_pedido, producto, cantidad, precio_unitario, region
FROM cliente_pedido;
```

#### c) Eliminar columnas redundantes

```sql
ALTER TABLE cliente_pedido DROP COLUMN nombre_cliente, DROP COLUMN direccion;
```

### Paso 2. Normalización de `proveedor_producto_region` (4FN → 5FN)

**Problema:**

* Un proveedor puede ofrecer varios productos y distribuirlos en varias regiones.
* La tabla mezcla **tres entidades independientes** (violación de 4FN y 5FN).

**Solución:**

#### a) Crear nuevas tablas

```sql
CREATE TABLE proveedor (
  id_proveedor INT AUTO_INCREMENT PRIMARY KEY,
  nombre_proveedor VARCHAR(100)
);

CREATE TABLE producto (
  id_producto INT AUTO_INCREMENT PRIMARY KEY,
  nombre_producto VARCHAR(100)
);

CREATE TABLE region_distribucion (
  id_region INT AUTO_INCREMENT PRIMARY KEY,
  nombre_region VARCHAR(100)
);
```

#### b) Poblar las tablas normalizadas con `INSERT SELECT DISTINCT`

```sql
INSERT INTO proveedor (nombre_proveedor)
SELECT DISTINCT nombre_proveedor FROM proveedor_producto_region;

INSERT INTO producto (nombre_producto)
SELECT DISTINCT producto FROM proveedor_producto_region;

INSERT INTO region_distribucion (nombre_region)
SELECT DISTINCT region FROM proveedor_producto_region;
```


### Paso 3. Normalización de `producto_categoria` (3FN)

**Problema:**

* La ​**subcategoría depende de la categoría**​, no del producto directamente.

**Solución:**

#### a) Crear nuevas tablas

```sql
CREATE TABLE categoria (
  id_categoria INT AUTO_INCREMENT PRIMARY KEY,
  nombre_categoria VARCHAR(100)
);

CREATE TABLE subcategoria (
  id_subcategoria INT AUTO_INCREMENT PRIMARY KEY,
  nombre_subcategoria VARCHAR(100),
  id_categoria INT,
  FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria)
);

CREATE TABLE producto_categoria_final (
  id_producto INT,
  id_subcategoria INT,
  FOREIGN KEY (id_producto) REFERENCES producto(id_producto),
  FOREIGN KEY (id_subcategoria) REFERENCES subcategoria(id_subcategoria)
);
```

#### b) Migrar datos con `SELECT DISTINCT`

```sql
INSERT INTO categoria (nombre_categoria)
SELECT DISTINCT categoria FROM producto_categoria;

INSERT INTO subcategoria (nombre_subcategoria, id_categoria)
SELECT DISTINCT pc.subcategoria, c.id_categoria
FROM producto_categoria pc
JOIN categoria c ON pc.categoria = c.nombre_categoria;

INSERT INTO producto_categoria_final (id_producto, id_subcategoria)
SELECT p.id_producto, s.id_subcategoria
FROM producto_categoria pc
JOIN producto p ON pc.nombre_producto = p.nombre_producto
JOIN subcategoria s ON pc.subcategoria = s.nombre_subcategoria;
```

#### c) Crear tablas pivote (5F)

```sql
CREATE TABLE proveedor_producto (
  id_proveedor INT,
  id_producto INT,
  PRIMARY KEY (id_proveedor, id_producto)
);

CREATE TABLE proveedor_region (
  id_proveedor INT,
  id_region INT,
  PRIMARY KEY (id_proveedor, id_region)
);

CREATE TABLE producto_region (
  id_producto INT,
  id_region INT,
  PRIMARY KEY (id_producto, id_region)
);
```

#### d) Poblar tablas pivote

```sql
INSERT INTO proveedor_producto (id_proveedor, id_producto)
SELECT DISTINCT p.id_proveedor, pr.id_producto
FROM proveedor_producto_region ppr
JOIN proveedor p
  ON ppr.nombre_proveedor = p.nombre_proveedor
JOIN producto pr
  ON ppr.producto = pr.nombre_producto;

INSERT INTO proveedor_region (id_proveedor, id_region)
SELECT DISTINCT p.id_proveedor, r.id_region
FROM proveedor_producto_region ppr
JOIN proveedor p
  ON ppr.nombre_proveedor = p.nombre_proveedor
JOIN region_distribucion r
  ON ppr.region = r.nombre_region;

INSERT INTO producto_region (id_producto, id_region)
SELECT DISTINCT pr.id_producto, r.id_region
FROM proveedor_producto_region ppr
JOIN producto pr
  ON ppr.producto = pr.nombre_producto
JOIN region_distribucion r
  ON ppr.region = r.nombre_region;
```

#### e) Agregar claves foráneas

```sql
ALTER TABLE proveedor_producto
  ADD FOREIGN KEY (id_proveedor) REFERENCES proveedor(id_proveedor),
  ADD FOREIGN KEY (id_producto)  REFERENCES producto(id_producto);

ALTER TABLE proveedor_region
  ADD FOREIGN KEY (id_proveedor) REFERENCES proveedor(id_proveedor),
  ADD FOREIGN KEY (id_region)    REFERENCES region_distribucion(id_region);

ALTER TABLE producto_region
  ADD FOREIGN KEY (id_producto) REFERENCES producto(id_producto),
  ADD FOREIGN KEY (id_region)   REFERENCES region_distribucion(id_region);

```

#### f) Eliminar las tablas no normalizadas originales

```sql
DROP TABLE producto_categoria;
```

#### g) Renombrar producto_categoria_final a producto_categoria y limpieza final

```sql
ALTER TABLE producto_categoria_final
RENAME TO producto_categoria;

DROP TABLE proveedor_producto_region;
```


# Segunda Forma Normal (2FN)

### Concepto

Una tabla está en **Segunda Forma Normal (2FN)** si:

1. ​**Cumple la Primera Forma Normal (1FN)**​.
2. **Todos los atributos no clave dependen completamente de la clave primaria.**

Esto significa que ​**no puede haber dependencias parciales**​:
→ Ningún atributo debe depender solo de una **parte** de la clave primaria compuesta.

### Ejemplo no normalizado (violando 2FN)

DETALLE_PEDIDO

| id_pedido | id_producto | nombre_cliente | nombre_producto | precio | cantidad |
|------------|--------------|----------------|------------------|---------|-----------|
| 1          | 10           | Ana Pérez      | Televisor        | 800     | 1         |
| 1          | 11           | Ana Pérez      | Cafetera         | 100     | 2         |
| 2          | 12           | Bruno Díaz     | Laptop           | 900     | 1         |

**Clave primaria compuesta:** (id\_pedido, id\_producto)

**Problema:**

* `nombre_cliente` depende solo de `id_pedido` (no del producto).
* `nombre_producto` y `precio` dependen solo de `id_producto`.

Estas son **dependencias parciales** → viola la 2FN.

### Solución: dividir en tres tablas

PEDIDO

| id_pedido | nombre_cliente |
|------------|----------------|
| 1          | Ana Pérez      |
| 2          | Bruno Díaz     |

PRODUCTO

| id_producto | nombre_producto | precio |
|--------------|------------------|---------|
| 10           | Televisor        | 800     |
| 11           | Cafetera         | 100     |
| 12           | Laptop           | 900     |

DETALLE_PEDIDO

| id_pedido | id_producto | cantidad |
|------------|--------------|-----------|
| 1          | 10           | 1         |
| 1          | 11           | 2         |
| 2          | 12           | 1         |

Ahora:

* `PEDIDO` almacena solo datos del pedido.
* `PRODUCTO` almacena datos de productos.
* `DETALLE_PEDIDO` relaciona ambos (sin redundancias).

### Implementación SQL

```sql
CREATE TABLE pedido (
  id_pedido INT PRIMARY KEY,
  nombre_cliente VARCHAR(100)
);

CREATE TABLE producto (
  id_producto INT PRIMARY KEY,
  nombre_producto VARCHAR(100),
  precio DECIMAL(10,2)
);

CREATE TABLE detalle_pedido (
  id_pedido INT,
  id_producto INT,
  cantidad INT,
  PRIMARY KEY (id_pedido, id_producto),
  FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
  FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);
```

### Ejercicio 2 (para alumnos)

Dada la tabla:

| id_venta | id_producto | nombre_cliente | nombre_producto | precio | cantidad |
| ----------- | -------------- | ----------------- | ------------------ | -------- | ---------- |
| 100       | 1            | Ana             | Mouse            | 15     | 2        |
| 100       | 2            | Ana             | Teclado          | 30     | 1        |
| 101       | 1            | Bruno           | Mouse            | 15     | 1        |

**Tarea:** Llevar la tabla a Segunda Forma Normal (2FN).
Identificar las dependencias parciales y proponer las tres tablas resultantes.

### Solución esperada

**VENTA**

| id_venta | nombre_cliente |
| ----------- | ----------------- |
| 100       | Ana             |
| 101       | Bruno           |

**PRODUCTO**

| id_producto | nombre_producto | precio |
| -------------- | ------------------ | -------- |
| 1            | Mouse            | 15     |
| 2            | Teclado          | 30     |

**DETALLE_VENTA**

| id_venta | id_producto | cantidad |
| ----------- | -------------- | ---------- |
| 100       | 1            | 2        |
| 100       | 2            | 1        |
| 101       | 1            | 1        |


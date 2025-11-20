## INNER JOIN (básico)

Obtener los nombres de clientes y los productos que compraron.

```sql
SELECT c.nombre AS cliente, p.nombre AS producto, d.cantidad
FROM cliente c
JOIN pedido pe ON c.id_cliente = pe.id_cliente
JOIN detalle_pedido d ON pe.id_pedido = d.id_pedido
JOIN producto p ON d.id_producto = p.id_producto;
```

## LEFT JOIN (clientes sin pedidos)

Listar todos los clientes, incluso los que no han hecho pedidos.

```sql
SELECT c.nombre, pe.id_pedido, pe.estado
FROM cliente c
LEFT JOIN pedido pe ON c.id_cliente = pe.id_cliente;
```

## RIGHT JOIN (productos con o sin pedido)

Listar todos los productos y mostrar el pedido si existen ventas.

```sql
SELECT p.nombre AS producto, d.id_pedido
FROM detalle_pedido d
RIGHT JOIN producto p ON d.id_producto = p.id_producto;
```

## FULL OUTER JOIN (simulado con UNION)

Listar clientes y productos, mostrando todos aunque no coincidan.

```sql
SELECT c.nombre AS cliente, pe.id_pedido
FROM cliente c
LEFT JOIN pedido pe ON c.id_cliente = pe.id_cliente
UNION
SELECT c.nombre AS cliente, pe.id_pedido
FROM cliente c
RIGHT JOIN pedido pe ON c.id_cliente = pe.id_cliente;
```

## SELF JOIN

Mostrar pares de clientes distintos de la misma ciudad.

```sql
SELECT a.nombre AS cliente1, b.nombre AS cliente2, a.ciudad
FROM cliente a
JOIN cliente b ON a.ciudad = b.ciudad AND a.id_cliente < b.id_cliente;
```

## GROUP BY con COUNT

Contar cuántos pedidos tiene cada cliente.

```sql
SELECT c.nombre, COUNT(pe.id_pedido) AS total_pedidos
FROM cliente c
LEFT JOIN pedido pe ON c.id_cliente = pe.id_cliente
GROUP BY c.id_cliente;
```

## GROUP BY con SUM y HAVING

Mostrar clientes cuyo total de pagos supera los 500.

```sql
SELECT c.nombre, SUM(pa.monto) AS total_pagado
FROM cliente c
JOIN pedido pe ON c.id_cliente = pe.id_cliente
JOIN pago pa ON pe.id_pedido = pa.id_pedido
GROUP BY c.nombre
HAVING total_pagado > 500;
```

## Subconsulta en SELECT

Mostrar productos y el precio promedio de su categoría.

```sql
SELECT p.nombre,
       p.precio,
       (SELECT AVG(p2.precio)
        FROM producto p2
        WHERE p2.id_categoria = p.id_categoria) AS promedio_categoria
FROM producto p;
```

## Subconsulta en WHERE

Mostrar productos cuyo precio es mayor que el precio promedio general.

```sql
SELECT nombre, precio
FROM producto
WHERE precio > (SELECT AVG(precio) FROM producto);
```

## JOIN triple con GROUP BY y HAVING

Mostrar los productos más vendidos (por cantidad total).

```sql
SELECT p.nombre AS producto,
       SUM(d.cantidad) AS total_vendido
FROM producto p
JOIN detalle_pedido d ON p.id_producto = d.id_producto
JOIN pedido pe ON pe.id_pedido = d.id_pedido
WHERE pe.estado = 'Pagado'
GROUP BY p.id_producto, p.nombre
HAVING total_vendido > 1
ORDER BY total_vendido DESC;
```

## JOIN + SUBCONSULTA + AGRUPACIÓN

Obtener los nombres de los clientes cuyo monto total de pedidos sea ​**mayor que el promedio de todos los montos pagados**​.

```sql
SELECT c.nombre, SUM(pa.monto) AS total_cliente
FROM cliente c
JOIN pedido pe ON c.id_cliente = pe.id_cliente
JOIN pago pa ON pe.id_pedido = pa.id_pedido
GROUP BY c.nombre
HAVING total_cliente > (SELECT AVG(monto) FROM pago);
```


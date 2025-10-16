# Solución de Ejercicios DML

## INSERT

```sql
--1.
INSERT INTO cliente (nombre, email, telefono)
VALUES ('Jorge Morales', 'jorge@correo.com', '611222333');

--2.
INSERT INTO producto (nombre, precio, stock)
VALUES ('Gorra Deportiva', 18.00, 20);

--3.
INSERT INTO pedido (id_cliente, total)
VALUES (5, 18.00);

INSERT INTO detalle_pedido (id_pedido, id_producto, cantidad)
VALUES (9, 7, 1);

--4.
INSERT INTO producto (nombre, precio, stock, id_categoria)
VALUES 
('Altavoz Bluetooth', 55.00, 8, 1),
('Toalla Microfibra', 12.00, 25, 3),
('Libro de Bases de Datos', 50.00, 10, 4);
```

## UPDATE

```sql
--1.
UPDATE cliente
SET telefono = '600999999'
WHERE nombre = 'Ana López';

--2.
UPDATE producto p
JOIN categoria c ON p.id_categoria = c.id_categoria
SET p.precio = p.precio * 1.10
WHERE c.nombre = 'Electrónica';

--3.
UPDATE producto
SET id_categoria = (SELECT id_categoria FROM categoria WHERE nombre = 'Hogar')
WHERE nombre = 'Puzzle 1000 piezas';

--4.
UPDATE producto p
JOIN detalle_pedido d ON p.id_producto = d.id_producto
SET p.stock = p.stock - d.cantidad
WHERE d.id_pedido = 1;
```

## DELETE

```sql
--1.
DELETE FROM pedido WHERE id_pedido = 9;

(Los detalles se eliminan por ON DELETE CASCADE);

--2.
DELETE FROM categoria
WHERE nombre = 'Juguetes'
AND id_categoria NOT IN (SELECT DISTINCT id_categoria FROM producto);

--3.
DELETE FROM cliente
WHERE id_cliente NOT IN (SELECT DISTINCT id_cliente FROM pedido);
```

## SELECT

```sql
--1.
SELECT p.nombre AS Producto, c.nombre AS Categoria
FROM producto p
LEFT JOIN categoria c ON p.id_categoria = c.id_categoria;

--2.
SELECT cl.nombre AS Cliente, pr.nombre AS Producto
FROM cliente cl
JOIN pedido pe ON cl.id_cliente = pe.id_cliente
JOIN detalle_pedido dp ON pe.id_pedido = dp.id_pedido
JOIN producto pr ON dp.id_producto = pr.id_producto
WHERE pe.id_pedido = 1;

--3.
SELECT c.nombre, COUNT(p.id_pedido) AS pedidos, SUM(p.total) AS gasto_total
FROM cliente c
JOIN pedido p ON c.id_cliente = p.id_cliente
GROUP BY c.nombre
ORDER BY gasto_total DESC;

--4.
SELECT nombre FROM producto WHERE stock = 0;

--5.
SELECT DISTINCT cl.nombre
FROM cliente cl
JOIN pedido pe ON cl.id_cliente = pe.id_cliente
JOIN detalle_pedido dp ON pe.id_pedido = dp.id_pedido
JOIN producto pr ON dp.id_producto = pr.id_producto
JOIN categoria ca ON pr.id_categoria = ca.id_categoria
WHERE ca.nombre = 'Electrónica';

--6.
SELECT c.nombre AS Categoria, p.nombre AS Producto, p.precio
FROM producto p
JOIN categoria c ON p.id_categoria = c.id_categoria
WHERE p.precio = (
SELECT MAX(precio) FROM producto WHERE id_categoria = c.id_categoria
);

--7.
SELECT c.nombre AS Categoria, AVG(p.precio) AS Promedio
FROM producto p
JOIN categoria c ON p.id_categoria = c.id_categoria
GROUP BY c.nombre;

--8.
SELECT c.nombre, COUNT(p.id_pedido) AS cantidad_pedidos
FROM cliente c
JOIN pedido p ON c.id_cliente = p.id_cliente
GROUP BY c.nombre
ORDER BY cantidad_pedidos DESC
LIMIT 3;
```


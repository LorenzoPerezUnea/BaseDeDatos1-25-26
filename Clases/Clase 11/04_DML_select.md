## SELECT — Consulta de datos

`SELECT` es la sentencia más potente del lenguaje SQL.
Permite recuperar, filtrar, ordenar y combinar datos de una o más tablas.

```sql
SELECT c.nombre, p.id_pedido, p.total
FROM cliente c
JOIN pedido p ON c.id_cliente = p.id_cliente
WHERE p.total > 100
ORDER BY p.total DESC;
```

Muestra el nombre del cliente y el total de los pedidos superiores a 100 €, ordenados de mayor a menor.
Aquí se usa un **JOIN interno** entre dos tablas relacionadas.

```sql
SELECT c.nombre,
COUNT(p.id_pedido) AS total_pedidos,
SUM(p.total) AS suma_total
FROM cliente c
JOIN pedido p ON c.id_cliente = p.id_cliente
WHERE c.id_cliente IN (
SELECT id_cliente
FROM pedido
WHERE fecha >= '2024-01-01'
GROUP BY id_cliente
HAVING SUM(total) > 500
)
GROUP BY c.nombre
ORDER BY suma_total DESC;
```

1. La subconsulta selecciona los clientes cuyos pedidos desde 2024 suman más de 500 €.
2. La consulta principal muestra esos clientes con su número de pedidos y total acumulado.
3. Se agrupan los resultados y se ordenan en orden descendente de gasto total.
   


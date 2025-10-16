# Consultas SQL: SELECT, GROUP BY, ORDER BY, DISTINCT, LIMIT y HAVING

El comando **SELECT** en SQL se utiliza para consultar datos de una o varias tablas.
A partir de esta instrucción se pueden aplicar filtros, ordenamientos, agrupamientos y restricciones sobre los resultados.

## SELECT

La estructura básica de una consulta SELECT es:

```sql
SELECT columnas
FROM tabla
WHERE condiciones;
```

SELECT: indica qué columnas mostrar.

FROM: especifica la tabla origen de los datos.

WHERE: establece condiciones para filtrar filas.

```sql
SELECT nombre, precio
FROM producto
WHERE precio > 50;
```

Devuelve el nombre y precio de los productos cuyo precio sea mayor que 50.

## DISTINCT

La palabra clave DISTINCT elimina duplicados de los resultados, mostrando solo valores únicos en las columnas seleccionadas.

```sql
SELECT DISTINCT categoria
FROM producto;
```

Devuelve todas las categorías de productos sin repetir ninguna.

DISTINCT se aplica a toda la fila seleccionada, no solo a una columna. Si seleccionas varias columnas, una combinación repetida también será eliminada.

## ORDER BY

La cláusula ORDER BY se usa para ordenar los resultados de una consulta, ya sea ascendente (ASC, por defecto) o descendente (DESC).

```sql
SELECT nombre, precio
FROM producto
ORDER BY precio DESC;
Muestra los productos ordenados por su precio de mayor a menor.
```

Varias columnas:

```sql
SELECT nombre, categoria, precio
FROM producto
ORDER BY categoria ASC, precio DESC;
Ordena primero por categoría (ascendente) y, dentro de cada categoría, por precio descendente.
```

## LIMIT

La cláusula LIMIT restringe el número de filas devueltas por la consulta.
Es muy útil para pruebas o paginación de resultados.

```sql
SELECT *
FROM producto
LIMIT 5;
```

Devuelve solo las primeras 5 filas de la tabla.

Con desplazamiento (offset):

```sql
SELECT *
FROM producto
LIMIT 5 OFFSET 10;
Salta las 10 primeras filas y devuelve las siguientes 5.
Equivalente a “página 3” si se muestran 5 filas por página.
```

## GROUP BY

La cláusula GROUP BY agrupa las filas que tienen valores idénticos en las columnas indicadas.
Se utiliza junto con funciones de agregación como COUNT(), SUM(), AVG(), MIN() o MAX().

```sql
SELECT categoria, COUNT(*) AS total_productos
FROM producto
GROUP BY categoria;
```

Agrupa los productos por categoría y cuenta cuántos hay en cada una.

```sql
SELECT id_cliente, SUM(total) AS total_compras
FROM pedido
GROUP BY id_cliente;
```

Muestra el monto total comprado por cada cliente.

## HAVING

HAVING funciona como un filtro posterior al agrupamiento.
A diferencia de WHERE, que filtra filas antes del agrupamiento, HAVING filtra grupos después de aplicar GROUP BY.

```sql
SELECT id_cliente, SUM(total) AS total_compras
FROM pedido
GROUP BY id_cliente
HAVING SUM(total) > 500;
```

Muestra solo los clientes cuyo monto total de compras supera los 500.

Diferencia clave:

WHERE → filtra filas antes del GROUP BY.

HAVING → filtra grupos después del GROUP BY.

Combinando varias cláusulas

```sql
SELECT id_cliente, SUM(total) AS total_compras
FROM pedido
WHERE estado = 'Pagado'
GROUP BY id_cliente
HAVING SUM(total) > 200
ORDER BY total_compras DESC
LIMIT 5;
```

Explicación paso a paso:

* WHERE filtra solo pedidos pagados.
* GROUP BY agrupa los pedidos por cliente.
* SUM(total) calcula el total de compras por cliente.
* HAVING deja solo a los clientes con más de 200 en compras.
* ORDER BY ordena de mayor a menor total.
* LIMIT muestra solo los 5 primeros resultados.

Resumen conceptual

| Cláusula | Función principal                  | Orden de ejecución | Ejemplo simple             |
| ----------- | ------------------------------------- | --------------------- | ---------------------------- |
| SELECT    | Define columnas a mostrar           | 4°                 | `SELECT nombre`        |
| FROM      | Especifica tablas                   | 1°                 | `FROM producto`        |
| WHERE     | Filtra filas antes del agrupamiento | 2°                 | `WHERE precio > 50`    |
| GROUP BY  | Agrupa registros                    | 3°                 | `GROUP BY categoria`   |
| HAVING    | Filtra grupos                       | 5°                 | `HAVING COUNT(*) > 2`  |
| ORDER BY  | Ordena resultados                   | 6°                 | `ORDER BY precio DESC` |
| LIMIT     | Limita cantidad de filas            | 7°                 | `LIMIT 10`             |



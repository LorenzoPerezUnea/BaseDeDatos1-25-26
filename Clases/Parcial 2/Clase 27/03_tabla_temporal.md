# Tabla temporal

### Base de datos didáctica

users

- user_id (PK)
- country
- status

orders

- order_id (PK)
- user_id
- order_date

order_items

- order_id
- product_id
- qty
- price

Volumen razonable para el ejemplo:

* users: 50k
* orders: 2M
* order\_items: 8M

### Query original problemático

```sql
SELECT
u.country,
COUNT(DISTINCT o.order_id) AS total_orders,
SUM(oi.qty * oi.price) AS revenue
FROM users u
JOIN orders o ON o.user_id = u.user_id
JOIN order_items oi ON oi.order_id = o.order_id
WHERE o.order_date BETWEEN '2024-01-01' AND '2024-12-31'
GROUP BY u.country
HAVING revenue > 100000
ORDER BY revenue DESC
LIMIT 5;
```

### EXPLAIN esperado

* escaneo masivo
* agregación tardía
* ordenamiento sobre columna calculada
* Using temporary
* Using filesort
  
  ### Por qué aparecen:
* `SUM(qty * price)` no existe físicamente
* `GROUP BY country` requiere materializar
* `ORDER BY revenue` no puede usar índices
* `HAVING` filtra después de agrupar

Conclusión:

este query **no es indexable por definición**

### EXPLAIN esperado

Intento típico (incorrecto):

* añadir más índices
* índice compuesto gigante
* índices en todas las FK

Resultado:

* EXPLAIN no cambia
* CPU sigue alta
* disco sigue trabajando

No se puede indexar un cálculo que no existe como dato

### Cambio de enfoque: diseño orientado a consulta

¿Este cálculo se hace **una vez al año** o ​**muchas veces al día**​?

Si la respuesta es:

* ranking
* analítica

Entonces:

**no pertenece a una query en caliente**

### Creación de tabla temporal

Creamos una ​**tabla resumen materializada**​.

```sql
CREATE TABLE country_sales_daily (
  sales_date DATE,
  country CHAR(2),
  total_orders INT,
  revenue DECIMAL(14,2),
  PRIMARY KEY (sales_date, country),
  INDEX idx_country_revenue (country, revenue)
);
```

Qué contiene:

* datos ya agregados
* sin JOINs
* sin cálculos

### Poblado de la tabla

Creamos una ​**tabla resumen materializada**​.

```sql
INSERT INTO country_sales_daily (sales_date, country, total_orders, revenue)
SELECT
  DATE(o.order_date),
  u.country,
  COUNT(DISTINCT o.order_id),
  SUM(oi.qty * oi.price)
FROM users u
JOIN orders o ON o.user_id = u.user_id
JOIN order_items oi ON oi.order_id = o.order_id
GROUP BY DATE(o.order_date), u.country;
```

Este query **puede ser lento** pero se ejecuta:

* una vez al día
* fuera de horas pico

### Nuevo query optimizado

```sql
SELECT
  country,
  SUM(total_orders) AS total_orders,
  SUM(revenue) AS revenue
FROM country_sales_daily
WHERE sales_date BETWEEN '2024-01-01' AND '2024-12-31'
GROUP BY country
HAVING revenue > 100000
ORDER BY revenue DESC
LIMIT 5;
```

### EXPLAIN esperado

Cambios clave:

* dataset muy pequeño
* sin JOINs
* índices utilizables

Resultado típico:

Using index

Desaparecen:

* Using temporary (o queda trivial)
* Using filesort (si el índice ayuda al ORDER)

Incluso si aparece `temporary`, es sobre ​**decenas de filas**​, no millones.



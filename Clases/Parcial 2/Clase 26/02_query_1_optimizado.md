# Query optimizado #1 — ventas por categoría con filtros tempranos

```sql
SELECT c.category_id, c.name,
       COUNT(o.order_id) AS orders_cnt,
       SUM(oi.qty * oi.price) AS revenue
FROM orders o
JOIN users u 
    ON u.user_id = o.user_id
JOIN order_items oi 
    ON oi.order_id = o.order_id
JOIN products p 
    ON p.product_id = oi.product_id
JOIN categories c 
    ON c.category_id = p.category_id
WHERE u.country = 'ES'
  AND o.order_date >= '2024-01-01'
  AND o.order_date < '2025-01-01'
  AND p.price > 20
GROUP BY c.category_id, c.name
HAVING revenue > 1000
ORDER BY revenue DESC;
```

### Índice 1: users(country, user\_id)

```sql
CREATE INDEX idx_users_country_user
ON users (country, user_id);
```

Por qué se elige:

* `country` es el primer filtro aplicado.
* `user_id` se usa inmediatamente para el JOIN con orders.

Beneficio:

* El optimizador puede empezar el plan desde users.
* Se descartan usuarios no españoles antes de tocar orders.
* Reduce de forma significativa el número de órdenes a procesar.

### Índice 2: orders(user\_id, order\_date, order\_id)

```sql
CREATE INDEX idx_orders_user_date
ON orders (user_id, order_date, order_id);
```

Por qué se elige:

* `user_id` llega desde users ya filtrados.
* `order_date` es un rango temporal.
* `order_id` conecta con order\_items.

Beneficio:

* JOIN users → orders con índice compuesto.
* Solo se recorren órdenes del rango correcto.
* Se reduce la cantidad de filas que pasan a order\_items.

### Índice 3: products(category\_id, price, product\_id)

```sql
CREATE INDEX idx_products_price_category
ON products (price, category_id, product_id);
```

Por qué se elige:

* `price` es un filtro directo.
* `category_id` se usa en el GROUP BY.
* `product_id` conecta con order\_items.

Beneficio:

* Productos baratos se descartan antes del JOIN.
* Menos combinaciones en order\_items.
* Agregaciones más baratas.

### Índice 4: order\_items(product\_id, order\_id, qty, price)

```sql
CREATE INDEX idx_order_items_order
ON order_items (order_id, product_id, qty, price);
```

Por qué se elige:

* `order_id` es la clave principal del JOIN.
* `product_id` conecta con products.
* `qty` y `price` se usan en el cálculo del SUM.

Beneficio:

* JOIN order\_items mucho más rápido.
* Menos accesos a la tabla base.
* SUM se ejecuta sobre menos filas reales.

## Conclusión didáctica de la clase

* Los índices funcionan **mucho mejor** cuando el query ya fue rediseñado.
* Cada índice responde a:
  * un filtro
  * un JOIN
  * una agregación
* El orden de columnas es tan importante como el índice en sí.
* ORDER BY y HAVING agregados siguen siendo el límite natural.


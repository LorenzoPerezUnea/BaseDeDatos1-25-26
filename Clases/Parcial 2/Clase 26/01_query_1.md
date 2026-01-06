# Query monstruo #1 — ventas por categoría (joins + fechas + HAVING)

```sql
SELECT c.category_id, c.name,
COUNT(DISTINCT o.order_id) AS orders_cnt,
SUM(oi.qty * oi.price) AS revenue
FROM categories c
JOIN products p ON p.category_id = c.category_id
JOIN order_items oi ON oi.product_id = p.product_id
JOIN orders o ON o.order_id = oi.order_id
JOIN users u ON u.user_id = o.user_id
WHERE u.country = 'ES'
AND o.order_date BETWEEN '2024-01-01' AND '2024-12-31'
AND p.price > 20
GROUP BY c.category_id, c.name
HAVING revenue > 1000
ORDER BY revenue DESC;
```

### Problemas que los índices pueden atacar

* Filtros en WHERE sobre varias tablas
* JOINs en cascada
* ORDER BY sobre agregado (esto **no** lo arregla un índice)

### Qué NO resuelven los índices

* HAVING sobre SUM
* ORDER BY revenue
* Creación de tablas temporales

### Índice 1: users(country, user\_id)

```sql
CREATE INDEX idx_users_country_user
ON users (country, user_id);
```

Por qué se crea:

* `country` es un filtro fuerte en WHERE.
* `user_id` se usa inmediatamente para el JOIN con orders.

Beneficio:

* El optimizador puede localizar solo usuarios de ES.
* Reduce drásticamente el número de órdenes a evaluar.
* Evita full scan sobre users.

### Índice 2: orders(user\_id, order\_date, order\_id)

```sql
CREATE INDEX idx_orders_user_date
ON orders (user_id, order_date, order_id);
```

Por qué se crea:

* orders se filtra por user\_id (JOIN) y por rango de fechas.
* order\_id se usa después para el JOIN con order\_items.

Beneficio:

* Permite usar índice compuesto para JOIN + rango.
* Reduce órdenes fuera del periodo.
* Evita recorrer órdenes de otros usuarios.

### Índice 3: products(category\_id, price, product\_id)

```sql
CREATE INDEX idx_products_category_price
ON products (category_id, price, product_id);
```

Por qué se crea:

* category\_id viene del JOIN con categories.
* price se filtra en WHERE.
* product\_id se usa en el JOIN con order\_items.

Beneficio:

* Filtra productos caros antes del JOIN.
* Reduce cardinalidad en order\_items.
* Evita JOIN sobre productos irrelevantes.

### Índice 4: order\_items(product\_id, order\_id, qty, price)

```sql
CREATE INDEX idx_order_items_product_order
ON order_items (product_id, order_id, qty, price);
```

Por qué se crea:

* product\_id es clave del JOIN.
* order\_id se usa para unir con orders.
* qty y price se usan en el cálculo del SUM.

Beneficio:

* JOIN más barato entre products y order\_items.
* Menos acceso a tabla base.
* Mejora agregaciones.


# Query optimizado #3 — agregación previa y JOIN final reducido

```sql
SELECT o.order_id, o.order_date, u.user_id, u.username, a.city,
       oi_tot.order_total,
       oi_tot.items_list
FROM orders o
JOIN users u 
    ON u.user_id = o.user_id
LEFT JOIN addresses a 
    ON a.user_id = u.user_id
JOIN (
    SELECT oi.order_id,
           SUM(oi.qty*oi.price) AS order_total,
           GROUP_CONCAT(p.name ORDER BY p.name SEPARATOR ', ') AS items_list
    FROM order_items oi
    JOIN products p 
        ON p.product_id = oi.product_id
    WHERE p.weight_grams > 500
    GROUP BY oi.order_id
) oi_tot
    ON oi_tot.order_id = o.order_id
WHERE o.order_date > DATE_SUB(NOW(), INTERVAL 180 DAY)
  AND (a.city LIKE 'Madrid%' OR u.country = 'ES')
ORDER BY oi_tot.order_total DESC
LIMIT 200;
```

### Índice 1: products(weight\_grams, product\_id)

```sql
CREATE INDEX idx_products_weight
ON products (weight_grams, product_id);
```

Por qué se elige:

* `weight_grams` es el filtro más restrictivo.
* `product_id` conecta con order\_items.

Beneficio:

* Solo productos pesados entran en la subconsulta.
* Reduce drásticamente filas antes de agrupar.
* GROUP\_CONCAT se ejecuta sobre dataset reducido.

### Índice 2: order\_items(product\_id, order\_id, qty, price)

```sql
CREATE INDEX idx_order_items_product_order
ON order_items (product_id, order_id, qty, price);
```

Por qué se elige:

* `product_id` viene ya filtrado.
* `order_id` se usa para agrupar.
* `qty` y `price` se usan en SUM.

Beneficio:

* Subconsulta se ejecuta de forma eficiente.
* Menos I/O y menos memoria.
* Agregación más rápida.

### Índice 3: orders(order\_date, order\_id, user\_id)

```sql
CREATE INDEX idx_orders_date
ON orders (order_date, order_id, user_id);
```

Por qué se elige:

* `order_date` es el filtro principal.
* `order_id` conecta con la subconsulta.
* `user_id` conecta con users.

Beneficio:

* Solo órdenes recientes entran al JOIN final.
* Reduce filas antes del ORDER BY.
* LIMIT 200 se aplica sobre menos resultados.

### Índice 4: addresses(city, user\_id)

```sql
CREATE INDEX idx_addresses_city
ON addresses (city, user_id);
```

Por qué se elige:

* `city LIKE 'Madrid%'` permite uso de índice.
* `user_id` conecta con users.

Beneficio:

* Filtro parcial dentro del OR.
* Reduce coste del LEFT JOIN.
* Mejora selectividad cuando city coincide.


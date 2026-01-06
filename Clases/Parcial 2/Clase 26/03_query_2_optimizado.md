# Query optimizado #2 — usuarios sospechosos con agregación simplificada

```sql
SELECT u.user_id, u.username,
       COUNT(o.order_id) AS total_orders,
       COUNT(p.payment_id) AS successful_payments,
       COUNT(o.order_id) - COUNT(p.payment_id) AS missing_payments
FROM users u
JOIN orders o 
    ON o.user_id = u.user_id
    AND o.order_date >= '2023-01-01'
LEFT JOIN payments p 
    ON p.order_id = o.order_id
WHERE u.signup_date > '2023-01-01'
GROUP BY u.user_id, u.username
HAVING total_orders > 10
   AND missing_payments >= 3
ORDER BY missing_payments DESC, total_orders DESC;
```

### Índice 1: users(signup\_date, user\_id)

```sql
CREATE INDEX idx_users_signup
ON users (signup_date, user_id);
```

Por qué se elige:

* `signup_date` es el primer filtro lógico.
* `user_id` se usa para el JOIN con orders.

Beneficio:

* Elimina usuarios antiguos al inicio del plan.
* Reduce el volumen de orders a recorrer.
* Acelera todo el pipeline posterior.

### Índice 2: orders(user\_id, order\_date, order\_id)

```sql
CREATE INDEX idx_orders_user_date
ON orders (user_id, order_date, order_id);
```

Por qué se elige:

* `user_id` viene de users filtrados.
* `order_date` se filtra en el JOIN.
* `order_id` conecta con payments.

Beneficio:

* JOIN users → orders altamente selectivo.
* Se descartan órdenes antiguas antes de agrupar.
* COUNT(o.order\_id) se ejecuta sobre menos filas.

### Índice 3: payments(order\_id, payment\_id)

```sql
CREATE INDEX idx_products_price_category
ON products (price, category_id, product_id);
```

Por qué se elige:

* JOIN directo por `order_id`.
* `payment_id` se usa para COUNT.

Beneficio:

* LEFT JOIN más barato.
* Menos uso de join buffer.
* Diferencia entre pagos existentes y faltantes más rápida.


# Queries “Monstruo”

A continuación tienes un set de consultas enormes y deliberadamente ineficientes.
La idea es usarlas en clase para:

- detectar problemas con `EXPLAIN`
- reescribirlas
- eliminar scans, subconsultas inútiles, filtros tardíos
- comparar planes antes/después

## Query monstruo #1

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

Problemas intencionales:

### ** JOINs demasiado temprano antes de filtrar**

El flujo actual es:

```sql
categories → products → order_items → orders → users → (filtros)
```

Error:
Los filtros más selectivos (`u.country`, `o.order_date`, `p.price`) aparecen ​**tarde**​, así que las tablas grandes ya están unidas antes de recortar el dataset.

### ** `COUNT(DISTINCT)` + `SUM` en un JOIN ancho**

Esto genera:

* Agrupación pesada
* Posible uso de `temporary table`
* Posible `filesort`
* Requiere leer casi todo el árbol de joins

### ** Filtro de fecha no optimizable**

`BETWEEN '2024-01-01' AND '2024-12-31'`

es optimizable ​*si tienes índice en order\_date*​, pero en el orden actual del JOIN, MySQL podría no usarlo óptimamente porque llega tarde.

### ** El `HAVING revenue > 1000` fuerza a agrupar TODO antes de filtrar**

Esto es un clásico en las clases de performance:
Es *mucho más caro* hacer HAVING después del GROUP BY que filtrar antes.

Aquí se usa HAVING porque revenue depende de la agregación… pero hay formas de mejorar.

### ** El ORDER BY revenue DESC también fuerza sorting costoso**

Porque revenue no existe hasta después de agrupar → se vuelve un sort pesado.

### ** No se limita el dataset de manera temprana**

Si orders y order\_items tienen millones de registros, el query hace un “tsunami join” antes de filtrar.

# EXPLAIN — Simulación realista

Este EXPLAIN no es literal, pero representa lo que verás con miles o millones de filas.

id | table       | type   | rows     | Extra
--- |------------- |--------- |---------- |----------------------------------------
1  | u           | ref     | 500000   | Using where
1  | o           | ref     | 2000000  | Using where
1  | oi          | ref     | 8000000  |
1  | p           | eq_ref  | 300000   | Using where
1  | c           | eq_ref  | 200      |
|             |         |          | Using temporary; Using filesort

### Explicación corta y directa

* `rows` enormes → mal orden de joins.
* `Using temporary; Using filesort` → confirmación del “query monstruo”.
* Si `country` o `order_date` no tienen índices → MySQL devora la base entera.

# Reescritura optimizada

Objetivos:

1. **Filtrar usuarios y órdenes primero.**
2. Mover filtros al JOIN cuando posible.
3. Bajar el coste del GROUP BY.
4. Reducir el alcance del JOIN a productos y categorías.
5. Mantener la misma semántica exacta.

```sql
SELECT 
    c.category_id, 
    c.name,
    COUNT(DISTINCT o.order_id) AS orders_cnt,
    SUM(oi.qty * oi.price) AS revenue
FROM orders o
JOIN users u 
    ON u.user_id = o.user_id
    AND u.country = 'ES'
JOIN order_items oi 
    ON oi.order_id = o.order_id
JOIN products p 
    ON p.product_id = oi.product_id
    AND p.price > 20
JOIN categories c 
    ON c.category_id = p.category_id
WHERE o.order_date >= '2024-01-01'
  AND o.order_date < '2025-01-01'
GROUP BY c.category_id, c.name
HAVING revenue > 1000
ORDER BY revenue DESC;
```

## Mejoras

### **Los filtros más selectivos se aplican ANTES del JOIN ancho**

Ahora MySQL empieza por:

```sql
orders → users (filtrados)
↓
order_items reducido
↓
products reducidos por price
↓
categorías ya son pocas
```

### **Evitamos leer millones de order_items innecesarios**

Antes:
El motor llegaba a `order_items` sin filtrar casi nada.

Ahora:
Solo lee order\_items de órdenes válidas → caída masiva del coste.

### **Fechas en formato optimizable**

`order_date >= '2024-01-01' AND < '2025-01-01'`
→ índice “range friendly”.

### **`JOIN … AND p.price > 20` permite pruning temprano**

Mucho más barato que hacer el filtro al final.

### **GROUP BY más pequeño**

En vez de agrupar sobre millones de filas, agrupamos sobre la fracción filtrada.

### **Sigue necesitando temporary table, pero con mucho menos volumen**

Lo cual es correcto en un análisis por categoría.


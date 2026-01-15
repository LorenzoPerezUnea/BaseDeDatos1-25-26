# Indices compuestos

En un índice compuesto, MySQL lo recorre **de izquierda a derecha** y:

1. Usa columnas con `=` hasta que pueda
2. Luego **una sola columna** con rango (`> < BETWEEN LIKE 'x%'`)
3. Después de un rango, **no puede usar columnas posteriores para filtrar ni ordenar**

Esto no es opinión, es cómo funciona el B-Tree.

## Índice de 3 campos — caso ideal

```sql
SELECT *
FROM orders
WHERE user_country = 'ES'
  AND user_type = 'premium'
  AND order_date >= '2024-01-01'
ORDER BY order_date DESC
LIMIT 100;
```

```sql
INDEX idx_orders (user_country, user_type, order_date)
```

### Qué ocurre internamente

* `user_country =` → búsqueda exacta
* `user_type =` → búsqueda exacta
* `order_date >=` → rango
* ORDER BY → se usa el índice en reversa

Resultado:

* no filesort
* no temporary
* índice recorrido secuencial

Este es el ​**caso perfecto**​.

## Mismo índice, distinto query (fallo típico)

```sql
WHERE user_type = 'premium'
  AND order_date >= '2024-01-01'
```

```sql
(user_country, user_type, order_date)
```

### Qué pasa

* MySQL **no puede saltarse `user_country`**
* El índice **no se usa**
* Resultado: full scan o índice distinto

> Si no usas el primer campo, el índice es invisible.

## Rango rompe el índice (caso crítico)

```sql
WHERE user_country = 'ES'
  AND order_date BETWEEN '2024-01-01' AND '2024-06-30'
  AND user_type = 'premium'
```

```sql
(user_country, order_date, user_type)
```

### Qué ocurre internamente

** `user_country =` → ok

* `order_date BETWEEN` → rango
* `user_type` → **NO SE USA**

Aunque esté en el índice, queda inutilizable.

> Todo lo que va después de un rango queda excluido.

## Índice de 4 campos — caso avanzado

```sql
SELECT order_id, total
FROM orders
WHERE user_country = 'ES'
  AND user_type = 'premium'
  AND order_status = 'paid'
  AND order_date >= '2024-01-01'
ORDER BY order_date DESC
LIMIT 50;
```

### Orden correcto

```sql
INDEX idx_orders (
  user_country,
  user_type,
  order_status,
  order_date
)
```

### Qué ocurre internamente

Orden justificado:

1. `=` country
2. `=` type
3. `=` status
4. rango + order (`order_date`)

Resultado:

* filtros en índice
* orden sin filesort
* acceso secuencial

### Orden correcto

```sql
INDEX idx_orders (
  order_date,
  user_country,
  user_type,
  order_status
)
```

Consecuencia:

* índice se usa solo por fecha
* país, tipo y estado se filtran después
* cardinalidad alta
* ORDER BY puede requerir filesort

> Un índice que empieza por rango es casi siempre un error.

## ORDER BY con múltiples columnas

```sql
ORDER BY user_country, order_date DESC
```

```sql
(user_country, order_date)
```

### Funciona si:

* `user_country` está fijo o primero
* el orden coincide

### No funciona si

```sql
ORDER BY order_date DESC, user_country
```

```sql
(user_country, order_date)
```

Porque el orden no coincide.

## ORDER BY + WHERE + LIMIT

### Query ideal para índice

```sql
WHERE status = 'active'
ORDER BY created_at DESC
LIMIT 20;
```

```sql
(status, created_at)
```

## Índices y LIKE

### LIKE que usa índice

```sql
WHERE category_name LIKE 'Elect%'
```

```sql
(category_name)
```

### LIKE que rompe índice

```sql
WHERE category_name LIKE '%Elect%'
```

Wildcard al inicio = índice excluido.

## Índices más rápido

```sql
SELECT order_date, total
FROM orders
WHERE user_country = 'ES'
  AND user_type = 'premium'
ORDER BY order_date DESC
LIMIT 50;
```

```sql
(user_country, user_type, order_date, total)
```

Ventaja:

* no accede a la tabla
* todo sale del índice


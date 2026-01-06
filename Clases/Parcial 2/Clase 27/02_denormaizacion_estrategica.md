# Denormalización Estratégica

### Evitar JOIN entre tablas masivas mediante denormalización selectiva

Objetivo:

* partir de dos tablas con **millones de registros**
* observar un JOIN inevitablemente caro
* copiar columnas estratégicas
* eliminar el JOIN en consultas críticas
* verificar la desaparición del coste (y del JOIN)

### Escenario realista

Sistema de ecommerce con histórico largo.

Volúmenes:

* users: 300.000
* orders: 25.000.000

Consultas frecuentes:

* listados de pedidos
* filtros por país, tipo de usuario o estado

### Modelo normalizado original

```sql
CREATE TABLE users (
  user_id BIGINT PRIMARY KEY,
  country CHAR(2),
  user_type ENUM('free','premium','enterprise'),
  status ENUM('active','blocked')
);

CREATE TABLE orders (
  order_id BIGINT PRIMARY KEY,
  user_id BIGINT,
  order_date DATETIME,
  total DECIMAL(10,2),
  INDEX idx_orders_user (user_id),
  INDEX idx_orders_date (order_date)
);

```

### Query crítico con JOIN masivo

```sql
SELECT
  o.order_id,
  o.order_date,
  o.total,
  u.country,
  u.user_type
FROM orders o
JOIN users u ON u.user_id = o.user_id
WHERE o.order_date >= '2024-01-01'
AND u.country = 'ES'
AND u.user_type = 'premium'
ORDER BY o.order_date DESC
LIMIT 100;
```

### Por qué este JOIN es lento aunque esté indexado

Aunque haya índices:

* orders → millones de filas
* filtro real depende de users
* el optimizador:
  * recorre orders
  * salta a users millones de veces
* la cardinalidad es gigantesca

Señales típicas en EXPLAIN:

* `rows` muy altos
* `Using where`
* alto coste acumulado
* CPU alta aunque haya índices

El JOIN no es lento por estar mal indexado
es lento porque ocurre demasiadas veces

### Identificación de columnas candidatas a copiar

Copiar columnas que:

* son **estables** (cambian poco)
* se usan **mucho en filtros**
* se muestran en **listados**
* vienen siempre del mismo JOIN

En este caso:

* `country`
* `user_type`

### Alterar tabla `orders`

```sql
ALTER TABLE orders
ADD COLUMN user_country CHAR(2),
ADD COLUMN user_type ENUM('free','premium','enterprise'),
ADD INDEX idx_orders_country_type_date (user_country, user_type, order_date);
```

### Llenado inicial (una sola vez)

```sql
UPDATE orders o
JOIN users u ON u.user_id = o.user_id
SET
  o.user_country = u.country,
  o.user_type = u.user_type;
```

Este UPDATE puede tardar horas
pero se ejecuta **una vez**

### Mantenimiento de consistencia

```sql
CREATE TRIGGER trg_users_update_orders
AFTER UPDATE ON users
FOR EACH ROW
UPDATE orders
SET
  user_country = NEW.country,
  user_type = NEW.user_type
WHERE user_id = NEW.user_id;
```

### Query reescrito SIN JOIN

```sql
SELECT
  order_id,
  order_date,
  total,
  user_country,
  user_type
FROM orders
WHERE order_date >= '2024-01-01'
AND user_country = 'ES'
AND user_type = 'premium'
ORDER BY order_date DESC
LIMIT 100;
```

### EXPLAIN

Antes:

* JOIN
* millones de accesos cruzados
* latencia variable

Después:

* una sola tabla
* índice compuesto usable
* acceso secuencial
* latencia estable

### Costes aceptados:

* duplicación de datos
* lógica de sincronización
* UPDATE más caro en users

### Cuando aplicar:

* tiene millones de filas
* participa en listados críticos
* se une siempre por la misma FK
* aporta siempre las mismas columnas


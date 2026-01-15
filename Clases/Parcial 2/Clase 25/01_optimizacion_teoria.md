# Clase 1 — Optimización de Consultas SQL por Rediseño

### 1. Introducción

### Objetivos

- Entender las métricas claves del plan de ejecución.
- Detectar patrones frecuentes que generan lentitud.
- Reescribir consultas para que el optimizador trabaje menos.

### Columnas principales de `EXPLAIN`

### `id`

- Identifica cada bloque de la consulta.
- Un número mayor significa una subconsulta más interna.
- **No es un indicador de costo**, solo de jerarquía.

### `select_type`

Tipo de SELECT ejecutado:

- `SIMPLE`: sin subconsultas ni UNION. **Rápido en general**.
- `PRIMARY`: SELECT principal.
- `SUBQUERY`: subconsulta en WHERE/SELECT. **Puede ser costoso**.
- `DERIVED`: subconsulta en FROM (tabla derivada). **Puede ser pesada**, depende del tamaño.
- `UNION` / `UNION RESULT`: parte de un UNION.

Las subconsultas correlacionadas son las más peligrosas → pueden ejecutarse miles de veces.

### `table`

- Tabla a la que aplica esta fila del plan.

### `type` (muy importante)

Este indica **cómo accede MySQL a la tabla**. De mejor a peor:

| type | Qué significa | Velocidad |
|------|---------------|-----------|
| `system` | 1 fila, tabla estática |  Muy rápido |
| `const` | Máx 1 fila encontrada por índice PK/UNIQUE | rápido |
| `eq_ref` | JOIN 1:1 usando PRIMARY/UNIQUE | regular |
| `ref` | JOIN muchos-a-1 con índice no único | regular  |
| `range` | Rango por índice (`BETWEEN`, `<`, `>=`) | regular |
| `index` | Escaneo de índice completo |  Puede ser costoso |
| `ALL` | Full table scan |  Muy costoso |

Regla práctica:
**Si ves `ALL` o `index` en tablas grandes → tienes un problema.**

### `possible_keys`

- Índices que podrían usarse.
- Si es NULL → *no hay índice útil*.

### `key`

- Índice que **sí usa** MySQL.
- Si está vacío → está haciendo scan completo.

### `key_len`

- Longitud del índice utilizado.
- Sirve para saber cuánto del índice está aprovechando MySQL.

### `ref`

- Valor con el que se compara el índice.
- `const`: valor literal
- `func`: valor calculado
- `tablename.column`: join por columna

### `rows`

- **Estimación** del número de filas que MySQL evaluará.
- No es exacto, pero si ves 1M aquí, hay un cuello de botella.

### `filtered`

- % de filas que pasan el filtro.
- `filtered = 10` significa que MySQL descarta 90%.
- Si `rows` es gigante, un `filtered` pequeño no salva la situación.

### `Extra`

Esta columna revela operaciones pesadas:

| Mensaje | Significado | Impacto |
|---------|-------------|---------|
| `Using where` | Está filtrando | normal |
| `Using index` | Index covering → rápido | bueno |
| `Using temporary` | Usa tabla temporal en RAM o disco |  Costoso |
| `Using filesort` | Ordenamiento manual |  Muy costoso |
| `Using join buffer` | Índice ausente en el JOIN |  Puede ser grave |
| `Impossible WHERE` | Siempre devuelve 0 filas | neutro |
| `Using MRR` | Multi-Range Read | bueno |
| `Using index condition` | ICP | bueno |

Los **peores**:

- `Using temporary`
- `Using filesort`
- `Using join buffer`


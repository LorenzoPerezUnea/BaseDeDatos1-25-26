# Normalización

La **normalización** es el proceso de organizar los datos en una base de datos para **reducir la redundancia** y ​**mejorar la integridad**​.

Cada “forma normal” representa un **nivel de organización más riguroso** que el anterior.

## Primera Forma Normal (1FN)

### Concepto

Una tabla está en **Primera Forma Normal (1FN)** si:

1. ​**Todos los atributos son atómicos**​, es decir, no contienen conjuntos, listas o valores repetidos.
2. ​**Cada registro es único**​, identificado por una clave primaria.
3. **No hay grupos repetitivos ni campos multivaluados.**

* **Valores atómicos:** **Cada celda de la tabla debe contener un único valor. No se permiten celdas con múltiples valores, como una lista de números de teléfono en un solo campo.**
* **Sin grupos repetitivos:** **No debe haber grupos de columnas que se repitan para el mismo tipo de información dentro de una misma fila. Si existen, deben separarse en tablas diferentes.**
* **No hay atributos multivaluados:** **Cada columna debe contener un solo tipo de información. Por ejemplo, no se permiten columnas con valores separados por coma o punto y coma.**

### Ejemplo no normalizado

PEDIDO

| id_pedido | cliente  | productos                   | total |
|------------|-----------|-----------------------------|--------|
| 1          | Ana Pérez | TV, Lavadora, Cafetera     | 1200   |
| 2          | Bruno Díaz| Laptop, Mouse              | 900    |

**Problemas:**

* La columna `productos` contiene **varios valores** separados por comas.
* No se puede aplicar integridad referencial ni realizar búsquedas precisas de un solo producto.

### Solución: aplicar 1FN

Dividimos los productos en filas separadas:

DETALLE_PEDIDO

| id_pedido | producto   | subtotal |
|------------|-------------|----------|
| 1          | TV          | 800      |
| 1          | Lavadora    | 300      |
| 1          | Cafetera    | 100      |
| 2          | Laptop      | 850      |
| 2          | Mouse       | 50       |

### Implementación SQL

```sql
CREATE TABLE pedido (
  id_pedido INT PRIMARY KEY,
  cliente VARCHAR(100),
  total DECIMAL(10,2)
);

CREATE TABLE detalle_pedido (
  id_detalle INT AUTO_INCREMENT PRIMARY KEY,
  id_pedido INT,
  producto VARCHAR(100),
  subtotal DECIMAL(10,2),
  FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido)
);
```

Ahora cada producto tiene su propia fila (dato ​**atómico**​) y la relación entre pedido y detalle es ​**1 a N**​.

### Ejercicio 1 (para alumnos)

Una tabla llamada `ALUMNOS_CURSOS` tiene los siguientes datos:

| id_alumno | nombre | cursos      |
| ------------ | -------- | ------------- |
| 1          | Ana    | SQL, Python |
| 2          | Bruno  | HTML, CSS   |
| 3          | Carla  | Python, R   |

**Tarea:** Normalizar a 1FN.

**Respuesta esperada:**

| id_alumno | nombre | curso  |
| ------------ | -------- | -------- |
| 1          | Ana    | SQL    |
| 1          | Ana    | Python |
| 2          | Bruno  | HTML   |
| 2          | Bruno  | CSS    |
| 3          | Carla  | Python |
| 3          | Carla  | R      |


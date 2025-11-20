## Esquema de una Base de Datos

El **esquema** es la descripción formal de la estructura de la base de datos.
Incluye tablas, columnas, tipos de datos, claves y restricciones.

### Tipos de esquemas:

1. **Esquema conceptual:**
   Representa la estructura lógica de toda la base de datos, independiente del hardware o software.
   Ejemplo: un diagrama ER con entidades `Cliente`, `Pedido`, `Producto`.
2. **Esquema lógico:**
   Traduce el modelo conceptual al modelo relacional (tablas, claves primarias, relaciones).
3. **Esquema físico:**
   Indica cómo se almacenan los datos (índices, archivos, particiones).

### Ejemplo práctico:

**Esquema conceptual:**

* Entidades: Cliente, Pedido, Producto
* Relaciones: Cliente realiza Pedido, Pedido contiene Producto.

**Esquema lógico:**

```sql
CREATE TABLE cliente (
id_cliente INT PRIMARY KEY,
nombre VARCHAR(50)
);

CREATE TABLE producto (
id_producto INT PRIMARY KEY,
nombre VARCHAR(50)
);

CREATE TABLE pedido (
id_pedido INT PRIMARY KEY,
id_cliente INT,
fecha DATE,
FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);
```

## Dependencia de Datos

Se refiere a la ​**relación entre la estructura de los datos y su almacenamiento físico o lógico**​.

### Dependencia física

Cuando los programas dependen directamente de cómo están almacenados los datos (por ejemplo, posición en disco o archivos).
Esto era común en sistemas antiguos, dificultando el mantenimiento.

### Independencia física

En bases de datos modernas, los programas acceden a los datos ​**sin importar su ubicación física**​.
El sistema gestor se encarga de manejar los detalles internos.

### Independencia lógica

Los programas pueden seguir funcionando aunque cambie la estructura lógica (por ejemplo, agregar una columna).

**Ejemplo:**
Agregar el campo `telefono` a la tabla `cliente` no debería romper los programas existentes.

## Dependencia Funcional

La **dependencia funcional** es la base teórica de la **normalización** (que se tratará después).
Indica que el valor de un atributo depende de otro.

### Definición formal:

Un atributo B **depende funcionalmente** de A si ​**cada valor de A determina exactamente un valor de B**​.

Se escribe como:
**A → B**

### Ejemplo:

En una tabla de empleados:

| id\_empleado | nombre | departamento |
| -------------- | -------- | -------------- |
| 1            | Ana    | Ventas       |
| 2            | Bruno  | Producción  |

Aquí:

* `id_empleado → nombre, departamento`
* Pero ​**no**​: `departamento → nombre`, porque varios empleados pueden pertenecer al mismo departamento.

### Tipos de dependencias funcionales:

* **Trivial:** cuando B es subconjunto de A (por ejemplo, A → A).
* **No trivial:** cuando B no está incluido en A.
* **Transitiva:** si A → B y B → C, entonces A → C.
* **Parcial:** cuando un atributo depende de parte de una clave compuesta.
* **Completa:** cuando depende de todos los atributos de la clave.

## Conclusión General

El diseño relacional correcto es la base de toda base de datos eficiente.
Antes de normalizar, es esencial comprender:

* Cómo se estructuran los datos (relaciones y dominios).
* Cómo se garantizan la integridad y la independencia.
* Cómo se relacionan las entidades en un modelo lógico coherente.
  


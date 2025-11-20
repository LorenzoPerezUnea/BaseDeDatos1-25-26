# DISEÑO DE BASES DE DATOS RELACIONALES

### Restricciones

Las **restricciones** aseguran la validez de los datos.

Tipos de restricciones:

* ​**NOT NULL**​: el campo no puede quedar vacío.
* ​**UNIQUE**​: no permite valores repetidos.
* ​**CHECK**​: impone una condición (por ejemplo, `edad > 0`).
* ​**DEFAULT**​: define un valor predeterminado si no se especifica ninguno.
* ​**FOREIGN KEY**​: mantiene la ​**integridad referencial**​.

**Ejemplo:**

```sql
CREATE TABLE estudiante (
id_estudiante INT PRIMARY KEY,
nombre VARCHAR(50) NOT NULL,
edad INT CHECK (edad >= 15)
);
```

## Tipos de Relaciones entre Tablas

Las relaciones entre tablas reflejan las **asociaciones reales** entre entidades.

### Relación Uno a Uno (1:1)

Un registro de una tabla se asocia con **exactamente un registro** de otra.

**Ejemplo:**
Cada persona tiene ​**una dirección única**​.

| PERSONA     | DIRECCION     |
| ------------- | --------------- |
| id_persona, nombre, dni | id_direccion, id_persona, texto  |

**Uso típico:** dividir información sensible o separar datos opcionales.

### Relación Uno a Muchos (1:N)

Un registro de una tabla se asocia con **varios** registros en otra.

**Ejemplo:**
Un cliente puede realizar varios pedidos.

| CLIENTE     | PEDIDO                  |
| ------------- | ------------------------- |
| id_cliente, nombre | id_pedido, id_cliente, total |

Aquí, `id_cliente` es **clave foránea** en la tabla `PEDIDO`.

### Relación Muchos a Muchos (N:M)

Un registro en una tabla se relaciona con **varios** en otra y viceversa.
Para representarla, se usa una ​**tabla intermedia**​.

**Ejemplo:**
Los estudiantes pueden inscribirse en varios cursos, y cada curso tiene varios estudiantes.

| ESTUDIANTE     | INSCRIPCION               | CURSO     |
| ---------------- | --------------------------- | ----------- |
| id_estudiante,nombre,dni  | id_estudiante, id_curso | id_curso,nombre |

## Manipulación de la Información

El modelo relacional se apoya en un conjunto de **operaciones matemáticas** (álgebra y cálculo relacional) y su implementación práctica, ​**SQL (Structured Query Language)**​.

### Lenguajes Relacionales

* **Álgebra relacional:** describe *cómo* obtener un resultado (operaciones como selección, proyección, unión, etc.).
* **Cálculo relacional:** indica *qué* se desea obtener (consultas declarativas).

### SQL

SQL combina ambos enfoques, permitiendo crear, modificar y consultar datos.
Ejemplo:

```sql
SELECT nombre, salario
FROM empleado
WHERE salario > 1000
ORDER BY salario DESC;
```

**Operaciones principales:**

* `SELECT`: consulta de datos.
* `INSERT`, `UPDATE`, `DELETE`: manipulación de registros.
* `CREATE`, `ALTER`, `DROP`: definición de estructuras.
* `GRANT`, `REVOKE`: control de privilegios.


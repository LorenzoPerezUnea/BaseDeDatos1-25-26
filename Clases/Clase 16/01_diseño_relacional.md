# DISEÑO DE BASES DE DATOS RELACIONALES

## Introducción

El modelo relacional, formulado por ​**Edgar F. Codd en 1970**​, cambió radicalmente la forma en que se diseñan y gestionan los datos.
Antes, los sistemas eran jerárquicos o en red, y las relaciones entre datos estaban integradas en el propio código del programa.
Codd propuso representar la información como **conjuntos matemáticos** (relaciones) organizados en ​**tablas**​, lo que permitió separar la lógica de los datos de su almacenamiento físico.

El modelo relacional introdujo:

* Una **estructura simple y uniforme** (tablas).
* Un **lenguaje formal** basado en el álgebra y el cálculo relacional.
* Una **independencia de datos** entre los programas y el almacenamiento.

Hoy en día, casi todos los sistemas de gestión (MySQL, PostgreSQL, SQL Server, Oracle) se basan en este modelo.

## Concepto de Base de Datos Relacional

Una **base de datos relacional (BDR)** es un conjunto de tablas interrelacionadas que permiten representar entidades del mundo real y las relaciones entre ellas.
Cada tabla se llama ​**relación**​, y cada fila representa una ​**tupla**​, mientras que las columnas representan ​**atributos**​.

### Ejemplo:

Imaginemos una biblioteca:

| id_libro | titulo                | autor               | id_categoria |
| ----------- | ----------------------- | --------------------- | --------------- |
| 1         | Cien años de soledad | G. García Márquez | 10            |
| 2         | El Quijote            | M. de Cervantes     | 11            |

| id_categoria | nombre   |
| --------------- | ---------- |
| 10            | Novela   |
| 11            | Clásico |

Estas dos tablas están **relacionadas** mediante `id_categoria`.
Así, el modelo relacional no solo guarda datos, sino ​**las conexiones entre ellos**​.

## Elementos de las Bases de Datos Relacionales

### Relaciones

* Son tablas que representan entidades o hechos.
* Cada relación tiene un **nombre único** y un ​**conjunto definido de atributos**​.
* Los datos contenidos son ​**tuplas (filas)**​.

**Ejemplo:**
Una relación *Empleado* puede representarse así:

| id\_empleado | nombre | cargo     | salario |
| -------------- | -------- | ----------- | --------- |
| 1            | Ana    | Ingeniera | 1500    |
| 2            | Bruno  | Técnico  | 900     |

Cada fila es una ​**tupla**​; cada columna, un ​**atributo**​.

### Dominios

Un **dominio** define el conjunto de valores válidos que puede tomar un atributo.

**Ejemplo:**

* El dominio de `salario` podría ser números decimales mayores que 0.
* El dominio de `nombre` podría ser texto de hasta 100 caracteres.

Esto asegura que los datos sean ​**coherentes y válidos**​.

```sql
CREATE TABLE empleado (
id_empleado INT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
salario DECIMAL(10,2) CHECK (salario > 0)
);
```

### Claves

Las claves permiten identificar y relacionar los registros.

* **Clave primaria (PRIMARY KEY):** identifica unívocamente cada registro.
  Ejemplo: `id_empleado`
* **Clave foránea (FOREIGN KEY):** conecta tablas relacionadas.
  Ejemplo: `id_departamento` en la tabla `Empleado` hace referencia a `Departamento`.
* **Clave candidata:** otro campo que podría ser clave primaria, como `dni`.
* **Clave compuesta:** formada por más de un atributo (por ejemplo, `id_curso` + `id_estudiante` en una inscripción).


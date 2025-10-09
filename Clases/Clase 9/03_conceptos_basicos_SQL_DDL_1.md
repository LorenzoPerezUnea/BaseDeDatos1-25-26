# SQL — Conceptos Básicos, DDL - CREATE y ALTER

A continuación se añaden los comandos DDL prácticos que faltaban:

* CREATE DATABASE
* ALTER TABLE
* DROPTRUNCATE

Estos son esenciales para la construcción y mantenimiento de la estructura de una BD.

### CREATE DATABASE

crea un contenedor de datos a nivel motor/instancia. Sintaxis típica (varía por SGBD):

```sql
CREATE DATABASE nombre_bd;
-- Opciones comunes en algunos RDBMS:
CREATE DATABASE nombre_bd
WITH OWNER = usuario
ENCODING = 'UTF8'
LC_COLLATE = 'es_ES.UTF-8'
LC_CTYPE = 'es_ES.UTF-8';
-- En MySQL/MariaDB se suele usar:
CREATE DATABASE nombre_bd
CHARACTER SET utf8mb4
COLLATE utf8mb4_general_ci;
```

Notas prácticas:

IF NOT EXISTS es soportado por muchos motores para evitar error si ya existe la base: CREATE DATABASE IF NOT EXISTS nombre_bd;

Crear la base es generalmente una operación administrativa (necesita privilegios).

Asegurarse de elegir ENCODING/CHARACTER SET y collation adecuados desde el inicio.

### ALTER TABLE

modifica la estructura de una tabla existente: añadir/quitar columnas, modificar tipos, añadir o eliminar constraints, renombrar tabla/columna. Ejemplos comunes:

```sql
-- Añadir columna
ALTER TABLE cliente
ADD COLUMN telefono VARCHAR(15);

-- Añadir columna con valor por defecto y NOT NULL
ALTER TABLE cliente
ADD COLUMN fecha_alta DATE DEFAULT CURRENT_DATE NOT NULL;

-- Eliminar columna (nota: no todas las versiones o motores permiten DROP COLUMN con facilidad)
ALTER TABLE cliente
DROP COLUMN telefono;

-- Modificar tipo de columna (sintaxis varía)
ALTER TABLE producto
ALTER COLUMN precio TYPE DECIMAL(10,2); -- PostgreSQL
-- En MySQL:
ALTER TABLE producto
MODIFY COLUMN precio DECIMAL(10,2);

-- Renombrar columna (sintaxis varía)
ALTER TABLE cliente
RENAME COLUMN nombre TO nombre_completo; -- PostgreSQL / SQL standard (varía)
-- En MySQL:
ALTER TABLE cliente
CHANGE COLUMN nombre nombre_completo VARCHAR(100);

-- Agregar constraint (p. ej. FK)
ALTER TABLE pedido
ADD CONSTRAINT fk_pedido_cliente
FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
ON DELETE SET NULL;

-- Eliminar constraint
ALTER TABLE pedido
DROP CONSTRAINT fk_pedido_cliente; -- sintaxis en PostgreSQL
-- En MySQL: 
ALTER TABLE pedido DROP FOREIGN KEY fk_pedido_cliente;
```

Precauciones con ALTER TABLE:

Operaciones sobre grandes tablas (añadir columna con NOT NULL sin DEFAULT, cambiar tipo, etc.) pueden bloquear o causar operaciones de copia; planear ventanas de mantenimiento.

Antes de cambiar tipos o eliminar columnas revisar dependencias (views, triggers, procedimientos, aplicaciones).

Algunas operaciones son más costosas que otras; usar índices temporales o pasos intermedios cuando sea necesario.


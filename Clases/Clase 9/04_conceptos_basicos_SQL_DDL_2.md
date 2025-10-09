# SQL — Conceptos Básicos, DDL - DROP y TRUNCATE

### DROP

elimina objetos de la base de datos de forma permanente. Sintaxis principal:

```sql
DROP TABLE nombre_tabla;
DROP TABLE IF EXISTS nombre_tabla; -- evita error si no existe
DROP DATABASE nombre_bd;
DROP DATABASE IF EXISTS nombre_bd;
```

Variantes y opciones:

DROP TABLE nombre_tabla CASCADE; en algunos motores elimina también objetos dependientes (views, constraints).

RESTRICT (o por defecto) impide eliminar si existen dependencias.

Precaución: DROP es destructivo: borra estructura y normalmente también los datos; hacer backup antes de operaciones críticas.

### TRUNCATE

elimina todas las filas de una tabla de forma rápida, manteniendo la definición de la tabla (y normalmente restableciendo contadores de identidad si se solicita). Sintaxis típica:

```sql
TRUNCATE TABLE nombre_tabla;
-- Opciones frecuentes:
TRUNCATE TABLE nombre_tabla RESTART IDENTITY; -- reinicia secuencias (Postgres)
TRUNCATE TABLE nombre_tabla CASCADE; -- en Postgres, también trunca tablas que dependen de ésta
```

Diferencias clave entre TRUNCATE y DELETE:

DELETE FROM tabla; elimina fila por fila y normalmente puede ser registrado en el log de transacciones de forma que permite rollback (según motor y transacción). Dispara triggers DELETE.

TRUNCATE TABLE tabla; suele ser más rápido porque no hace borrado fila a fila (comportamiento exacto depende del SGBD). En muchos motores TRUNCATE no dispara triggers DELETE y puede implicar permisos especiales.

En algunos SGBD TRUNCATE es DDL y provoca commit implícito (no se puede rollback);

En otros (por ejemplo PostgreSQL) TRUNCATE es transaccional y puede revertirse dentro de una transacción. Comprobar el comportamiento del motor usado.

TRUNCATE suele requerir más privilegios que DELETE.

### Buenas prácticas y recomendaciones finales:

Hacer siempre backup antes de DROP o cambios estructurales masivos con ALTER.

Probar cambios en entorno de staging antes de ejecutarlos en producción.

Usar IF EXISTS / IF NOT EXISTS para scripts idempotentes (instalación/despliegue).

Documentar cambios (CHANGELOG de esquema).

Revisar índices y constraints tras cambios de tipo o columnas; crear índices adecuados para consultas previsibles.

Al renombrar columnas/ tablas, actualizar código de aplicación, vistas, procedimientos y documentación.


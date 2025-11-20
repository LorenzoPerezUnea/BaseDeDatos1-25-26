# **Conceptos y funcionamiento de las transacciones**

Una **transacción** en SQL es una unidad lógica de trabajo compuesta por una o más instrucciones que se ejecutan como un bloque indivisible.

El objetivo es garantizar que las operaciones sobre una base de datos sean ​atómicas, coherentes, aisladas y duraderas (propiedades ACID)​.

## **Propiedades ACID**

1. **Atomicidad (Atomicity):**
   Todas las operaciones dentro de la transacción se ejecutan por completo o no se ejecutan en absoluto.
   Si ocurre un error, todo el conjunto se revierte.
2. **Consistencia (Consistency):**
   La base de datos pasa de un estado válido a otro. Las reglas de integridad y restricciones (llaves foráneas, unicidad, etc.) se mantienen.
3. **Aislamiento (Isolation):**
   Las transacciones concurrentes no deben interferir entre sí. Cada transacción debe ejecutarse como si fuera la única en el sistema.
4. **Durabilidad (Durability):**
   Una vez confirmada (COMMIT) una transacción, los cambios persisten incluso ante fallos de energía o sistema.

## **Control de transacciones en SQL**

En SQL, las transacciones se controlan mediante los siguientes comandos:

```sql
START TRANSACTION;  -- o BEGIN;
-- operaciones DML (INSERT, UPDATE, DELETE)
COMMIT;             -- confirma los cambios
ROLLBACK;           -- revierte los cambios
SAVEPOINT punto;    -- marca un punto intermedio
ROLLBACK TO punto;  -- revierte hasta un SAVEPOINT
```



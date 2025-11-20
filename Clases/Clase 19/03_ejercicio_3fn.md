## Migración hacia la **Tercera Forma Normal (3FN)**

**Objetivo:** eliminar **dependencias transitivas** entre atributos no clave.

### Tabla que viola 3FN

```sql
CREATE TABLE pedido (
  id_pedido INT PRIMARY KEY,
  id_cliente INT,
  cliente_nombre VARCHAR(100),
  cliente_ciudad VARCHAR(100),
  fecha DATE
);

INSERT INTO pedido VALUES
(1, 101, 'Ana Pérez', 'Quito', '2024-06-01'),
(2, 102, 'Bruno Díaz', 'Guayaquil', '2024-06-02'),
(3, 103, 'Carla Mena', 'Quito', '2024-06-03');
```

Aquí `cliente_nombre` y `cliente_ciudad` dependen de `id_cliente`, no de `id_pedido`.

### 1. Crear la nueva tabla `cliente3`

```sql
CREATE TABLE cliente3 (
  id_cliente INT PRIMARY KEY,
  nombre VARCHAR(100),
  ciudad VARCHAR(100)
);
```

### 2. Migrar datos únicos desde `pedido`

```sql
INSERT INTO cliente3 (id_cliente, nombre, ciudad)
SELECT DISTINCT id_cliente, cliente_nombre, cliente_ciudad FROM pedido;
```

### 3. Crear clave foránea

```sql
ALTER TABLE pedido
ADD FOREIGN KEY (id_cliente) REFERENCES cliente3(id_cliente);
```

### 3. Limpiar redundancias

```sql
ALTER TABLE pedido
DROP COLUMN cliente_nombre,
DROP COLUMN cliente_ciudad;
```

Ahora la tabla `pedido` depende únicamente de su clave primaria y referencia a `cliente3`.
Se ha eliminado la dependencia transitiva → ​**cumple 3FN**​.


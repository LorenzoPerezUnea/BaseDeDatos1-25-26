# Sentencias DML (Data Manipulation Language)

Las sentencias DML permiten manipular los datos almacenados en las tablas de una base de datos ya creada.
Incluyen cuatro operaciones principales: **INSERT**, **DELETE**, **UPDATE** y **SELECT**.
Estas operaciones no modifican la estructura de las tablas, sino su contenido.

## INSERT — Inserción de registros

`INSERT` se usa para agregar nuevos registros (filas) a una tabla existente.
Puede hacerse de dos maneras: especificando los nombres de las columnas o insertando valores en todas ellas según el orden definido en la tabla.

### Ejemplo básico

```sql
INSERT INTO cliente (nombre, email, fecha_registro)
VALUES ('Carlos Pérez', 'carlos.perez@example.com', '2024-05-01');
Este comando inserta un nuevo cliente con los valores especificados en las columnas correspondientes.

INSERT INTO producto (nombre, precio, stock)
VALUES 
  ('Teclado mecánico', 65.00, 10),
  ('Ratón inalámbrico', 25.00, 20),
  ('Monitor 24"', 150.00, 5);
Se insertan tres registros de una sola vez.
Esta sintaxis es más eficiente que ejecutar múltiples sentencias individuales.

INSERT INTO cliente_historial (id_cliente, nombre, email)
SELECT id_cliente, nombre, email
FROM cliente
WHERE fecha_registro < '2024-01-01';
Esta forma copia datos desde otra tabla, seleccionando solo los que cumplan una condición.
```


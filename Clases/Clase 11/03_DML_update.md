## UPDATE — Actualización de registros

`UPDATE` modifica uno o más valores de las filas que cumplen una condición.
Puede actualizar varias columnas a la vez y combinarse con operadores aritméticos y subconsultas.

```sql
UPDATE producto
SET precio = precio * 1.10
WHERE categoria = 'Electrónica';
```

Aumenta un 10% el precio de todos los productos pertenecientes a la categoría “Electrónica”.

```sql
UPDATE cliente
SET email = 'desconocido@dominio.com',
telefono = NULL
WHERE email IS NULL;
```

Asigna un correo genérico y borra el teléfono a los clientes sin email registrado.

```sql
UPDATE producto
SET stock = stock - 1
WHERE id_producto IN (
SELECT id_producto
FROM detalle_pedido
WHERE id_pedido = 1001
);
```

Reduce el stock de los productos incluidos en el pedido 1001.


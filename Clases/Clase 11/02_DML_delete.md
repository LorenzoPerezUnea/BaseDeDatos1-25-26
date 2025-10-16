## DELETE — Eliminación de registros

DELETE elimina filas de una tabla según una condición especificada en la cláusula WHERE.
Si no se usa WHERE, se eliminarán todas las filas de la tabla.

```sql
DELETE FROM producto
WHERE stock = 0;
```

Elimina todos los productos que ya no tienen unidades en stock.

```sql
DELETE FROM pedido
WHERE estado = 'Cancelado' AND fecha < '2024-01-01';
```

Elimina pedidos cancelados anteriores a enero de 2024.
La cláusula AND permite combinar múltiples condiciones de filtrado.

Si se omite WHERE, se borrarán todos los registros de la tabla.
Para eliminar también el espacio en disco ocupado y reiniciar contadores, se usa TRUNCATE TABLE.


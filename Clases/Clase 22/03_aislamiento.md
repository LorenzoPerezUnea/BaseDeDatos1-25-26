## **Modos de aislamiento de transacciones**

El nivel de aislamiento define cuánto puede afectar una transacción a otra concurrente.

| Nivel de aislamiento | Descripción                                   | Riesgos evitados             |
| ---------------------- | ------------------------------------------------ | ------------------------------ |
| READ UNCOMMITTED     | Lee datos no confirmados (sucios).             | Ninguno                      |
| READ COMMITTED       | Solo lee datos confirmados.                    | Dirty reads                  |
| REPEATABLE READ      | Mantiene las filas leídas bloqueadas.         | Dirty + Non-repeatable reads |
| SERIALIZABLE         | Ejecuta las transacciones de forma secuencial. | Todos los riesgos            |

```sql
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
START TRANSACTION;
-- operaciones
COMMIT;
```

## **Ejemplo integral de control de transacciones**

```sql
SET autocommit = 0;

START TRANSACTION;

UPDATE producto SET stock = stock - 5 WHERE id_producto = 3;
INSERT INTO pedido (id_cliente, fecha, total) VALUES (2, NOW(), 500.00);
INSERT INTO detalle_pedido (id_pedido, id_producto, cantidad, subtotal)
VALUES (LAST_INSERT_ID(), 3, 5, 500.00);

IF (SELECT stock FROM producto WHERE id_producto = 3) < 0 THEN
    ROLLBACK;
ELSE
    COMMIT;
END IF;
```




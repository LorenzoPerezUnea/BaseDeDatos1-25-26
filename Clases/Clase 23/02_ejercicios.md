## **3. Ejercicio 1 — Venta con control de stock**

**Objetivo:** realizar una venta solo si hay stock suficiente.

```sql
DELIMITER $$

CREATE PROCEDURE verificar_stock_y_transaccion()
BEGIN
  DECLARE stock_actual INT;

  START TRANSACTION;

  -- Leemos el stock actual del producto 1
  SELECT stock INTO stock_actual 
  FROM producto 
  WHERE id_producto = 1 
  FOR UPDATE;

  -- Verificamos la condición
  IF stock_actual <= 0 THEN
      -- Si no hay stock, revertimos la transacción
      ROLLBACK;
      SELECT ' Stock insuficiente, transacción revertida' AS resultado;
  ELSE
      -- Si hay stock, actualizamos y confirmamos
      UPDATE producto 
      SET stock = stock - 1 
      WHERE id_producto = 1;

      COMMIT;
      SELECT ' Transacción completada correctamente' AS resultado;
  END IF;
END $$

DELIMITER ;
```

## **4. Ejercicio 2 — Simular pago y entrega**

**Objetivo:** registrar el pago y confirmar entrega en la misma transacción.

```sql
START TRANSACTION;
INSERT INTO pago (id_venta, monto, fecha_pago) VALUES (1, 950.00, NOW());
UPDATE venta SET total = total - 950.00 WHERE id_venta = 1;
COMMIT;
```

## **5. Ejercicio 3 — Uso de SAVEPOINT**

**Objetivo:** revertir parcialmente una transacción.

```sql
START TRANSACTION;
UPDATE producto SET stock = stock - 3 WHERE id_producto = 2;
SAVEPOINT paso1;

UPDATE producto SET precio = precio * 1.1 WHERE id_producto = 3;
SAVEPOINT paso2;

ROLLBACK TO paso1;
COMMIT;
```


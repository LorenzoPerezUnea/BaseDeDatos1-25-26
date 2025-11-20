# **Ejercicio 1**

```sql
DELIMITER $$

CREATE PROCEDURE registrar_venta()
BEGIN
  DECLARE idv INT;
  DECLARE subtotal1 DECIMAL(10,2);
  DECLARE subtotal2 DECIMAL(10,2);
  DECLARE stock_min INT;

  START TRANSACTION;

  INSERT INTO venta (id_cliente, fecha, total)
  VALUES (1, NOW(), 0);
  SET idv = LAST_INSERT_ID();

  SET subtotal1 = 950.00;
  SET subtotal2 = 70.00;

  INSERT INTO detalle_venta (id_venta, id_producto, cantidad, subtotal)
  VALUES 
    (idv, 1, 1, subtotal1),
    (idv, 2, 1, subtotal2);

  UPDATE producto 
  SET stock = stock - 1 
  WHERE id_producto IN (1, 2);

  SELECT MIN(stock) INTO stock_min FROM producto WHERE id_producto IN (1, 2);

  IF stock_min < 0 THEN
    ROLLBACK;
    SELECT 'Transacción revertida por falta de stock.' AS resultado;
  ELSE
    INSERT INTO pago (id_venta, monto, fecha_pago)
    VALUES (idv, subtotal1 + subtotal2, NOW());
    COMMIT;
    SELECT 'Transacción completada.' AS resultado;
  END IF;
END$$

DELIMITER ;

CALL registrar_venta();
```

## **Ejercicio 2**

```sql
DELIMITER $$

DROP PROCEDURE IF EXISTS venta_cliente$$

CREATE PROCEDURE venta_cliente(
  IN p_id_cliente INT,
  IN p_monto_pago DECIMAL(10,2)
)
BEGIN
  DECLARE idv INT;
  DECLARE total_venta DECIMAL(10,2);
  DECLARE stock_min INT;

  START TRANSACTION;

  -- 1) Crear la venta
  INSERT INTO venta (id_cliente, fecha) VALUES (p_id_cliente, NOW());
  SET idv = LAST_INSERT_ID();

  -- 2) Insertar detalles (ejemplo fijo; en uso real pasarían parámetros)
  INSERT INTO detalle_venta (id_venta, id_producto, cantidad, subtotal)
  VALUES 
    (idv, 1, 1, 200.00),
    (idv, 2, 2, 100.00);

  -- 3) Actualizar stock usando una agregación de los detalles insertados
  UPDATE producto p
  JOIN (
    SELECT id_producto, SUM(cantidad) AS qty
    FROM detalle_venta
    WHERE id_venta = idv
    GROUP BY id_producto
  ) d ON p.id_producto = d.id_producto
  SET p.stock = p.stock - d.qty;

  -- 4) Calcular total de la venta desde los detalles
  SELECT SUM(subtotal) INTO total_venta FROM detalle_venta WHERE id_venta = idv;

  -- 5) Validar que ningún stock quedó negativo
  SELECT MIN(p.stock) INTO stock_min
  FROM producto p
  JOIN (
    SELECT id_producto, SUM(cantidad) AS qty
    FROM detalle_venta
    WHERE id_venta = idv
    GROUP BY id_producto
  ) d2 ON p.id_producto = d2.id_producto;

  IF stock_min IS NULL THEN
    -- por seguridad: si no hay filas (improbable aquí), revertir
    ROLLBACK;
    SELECT ' Error inesperado: no se determinaron stocks. Transacción revertida.' AS resultado;
  ELSEIF stock_min < 0 THEN
    ROLLBACK;
    SELECT CONCAT('Error: stock insuficiente (mínimo=', stock_min, '). Transacción revertida.') AS resultado;
  ELSE
    -- 6) Insertar pago, actualizar total de la venta y confirmar
    INSERT INTO pago (id_venta, monto, fecha_pago)
      VALUES (idv, total_venta, NOW());

    UPDATE venta SET total = total_venta WHERE id_venta = idv;

    COMMIT;
    SELECT 'Venta y pago registrados correctamente.' AS resultado;
  END IF;
END$$

DELIMITER ;

CALL venta_cliente(1, 400.00);
```

## **Ejercicio 3**

```sql
DELIMITER $$

CREATE PROCEDURE procesar_entrega_y_pago(IN p_id_pedido INT, IN p_monto DECIMAL(10,2))
BEGIN
  DECLARE estado_pedido VARCHAR(20);
  DECLARE pago_exitoso BOOLEAN DEFAULT FALSE;

  START TRANSACTION;

  -- Verificar si el pedido existe
  SELECT estado INTO estado_pedido FROM pedido WHERE id_pedido = p_id_pedido;

  IF estado_pedido IS NULL THEN
    ROLLBACK;
    SELECT 'Error: pedido no existe.' AS resultado;
  ELSE
    -- Insertar entrega
    INSERT INTO entrega (id_pedido, fecha_entrega, estado)
    VALUES (p_id_pedido, NOW(), 'Completada');

    -- Insertar pago
    INSERT INTO pago (id_pedido, monto, estado)
    VALUES (p_id_pedido, p_monto, 'Pagado');

    -- Confirmar consistencia
    IF p_monto > 0 THEN
      UPDATE pedido SET estado = 'Completado' WHERE id_pedido = p_id_pedido;
      COMMIT;
      SELECT 'Pedido entregado y pagado con éxito.' AS resultado;
    ELSE
      ROLLBACK;
      SELECT 'Error: monto inválido, transacción revertida.' AS resultado;
    END IF;
  END IF;
END$$

DELIMITER ;

CALL procesar_entrega_y_pago(1, 500.00);
```


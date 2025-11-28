#Taller Transaciones

## Ejercicio 1

Realizar un procedimiento almacenado que permita realizar una venta.

El procedimiento almacenado debe:

- Recibir como parámetros el id del cliente, el id del producto y la cantidad.
- Validar si hay suficiente stock del producto.
- Si hay suficiente stock, realizar la venta y actualizar el stock del producto.
- Si no hay suficiente stock, mostrar un mensaje de error.
- Si ocurre algún error, revertir la transacción.

```sql
    DELIMITER //

DROP PROCEDURE IF EXISTS realizar_venta //

CREATE PROCEDURE realizar_venta(
    IN p_id_cliente INT,
    IN p_id_producto INT,
    IN p_cantidad INT
)
BEGIN
    DECLARE v_precio DECIMAL(10,2);
    DECLARE v_stock INT;
    DECLARE v_id_venta INT;
    DECLARE v_total DECIMAL(10,2);
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Error: Transacción revertida.' AS mensaje;
    END;
    START TRANSACTION;

    SELECT precio, stock INTO v_precio, v_stock
    FROM producto
    WHERE id_producto = p_id_producto
    FOR UPDATE;
    IF v_stock >= p_cantidad THEN
        SET v_total = v_precio * p_cantidad;
        INSERT INTO venta (id_cliente, fecha, total)
        VALUES (p_id_cliente, NOW(), v_total);

        SET v_id_venta = LAST_INSERT_ID();

        INSERT INTO detalle_venta (id_venta, id_producto, cantidad, subtotal)
        VALUES (v_id_venta, p_id_producto, p_cantidad, v_total);
        UPDATE producto
        SET stock = stock - p_cantidad
        WHERE id_producto = p_id_producto;

        INSERT INTO pago (id_venta, monto, fecha_pago)
        VALUES (v_id_venta, v_total, NOW());

        COMMIT;
        SELECT 'Venta realizada con éxito.' AS mensaje;
    ELSE
        ROLLBACK;
        SELECT 'Error: Stock insuficiente.' AS mensaje;
    END IF;
END //

DELIMITER ;

CALL realizar_venta(1, 1, 1); -- Venta válida
CALL realizar_venta(1, 1, 10); -- Venta inválida por stock

```

## Ejercicio 2

Utilizar otro procedimiento para que valide que el monto de pago sea suficiente para cubrir el total de la venta.

```sql
DELIMITER //

CREATE PROCEDURE realizar_venta_con_pago(
    IN p_id_cliente INT,
    IN p_id_producto INT,
    IN p_cantidad INT,
    IN p_monto_pago DECIMAL(10,2)
)
BEGIN
    DECLARE v_precio DECIMAL(10,2);
    DECLARE v_stock INT;
    DECLARE v_id_venta INT;
    DECLARE v_total DECIMAL(10,2);
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Error: Transacción revertida.' AS mensaje;
    END;
    START TRANSACTION;

    SELECT precio, stock INTO v_precio, v_stock
    FROM producto
    WHERE id_producto = p_id_producto
    FOR UPDATE;

    SET v_total = v_precio * p_cantidad;

    IF v_stock < p_cantidad THEN
        ROLLBACK;
        SELECT 'Error: Stock insuficiente.' AS mensaje;
    ELSEIF p_monto_pago < v_total THEN
        ROLLBACK;
        SELECT 'Error: Pago insuficiente.' AS mensaje;
    ELSE
        INSERT INTO venta (id_cliente, fecha, total)
        VALUES (p_id_cliente, NOW(), v_total);

        SET v_id_venta = LAST_INSERT_ID();

        INSERT INTO detalle_venta (id_venta, id_producto, cantidad, subtotal)
        VALUES (v_id_venta, p_id_producto, p_cantidad, v_total);
        
        UPDATE producto
        SET stock = stock - p_cantidad
        WHERE id_producto = p_id_producto;

        INSERT INTO pago (id_venta, monto, fecha_pago)
        VALUES (v_id_venta, p_monto_pago, NOW());

        COMMIT;
        SELECT 'Venta realizada con éxito.' AS mensaje;
    END IF;
END //

DELIMITER ;
```

## Ejercicio 3

Crear un procedimiento almacenado que maneje una transacción completa: pedido, pago y entrega. Si cualquiera de estos pasos falla, se debe revertir toda la transacción.

-- Procedimiento almacenado
DELIMITER //

DROP PROCEDURE IF EXISTS procesar_pedido_completo //

CREATE PROCEDURE procesar_pedido_completo(
    IN p_id_pedido INT,
    IN p_monto_pago DECIMAL(10,2)
)
BEGIN
    DECLARE v_estado_pedido VARCHAR(20);
    DECLARE v_id_cliente INT;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Error: Transacción revertida.' AS mensaje;
    END;
    
    START TRANSACTION;

    -- Verificar que el pedido existe y obtener su estado
    SELECT estado, id_cliente INTO v_estado_pedido, v_id_cliente
    FROM pedido
    WHERE id_pedido = p_id_pedido
    FOR UPDATE;

    -- Validar que el pedido está en estado Pendiente
    IF v_estado_pedido != 'Pendiente' THEN
        ROLLBACK;
        SELECT 'Error: El pedido no está en estado Pendiente.' AS mensaje;
    -- Validar que el monto de pago sea positivo
    ELSEIF p_monto_pago <= 0 THEN
        ROLLBACK;
        SELECT 'Error: El monto de pago debe ser mayor a 0.' AS mensaje;
    ELSE
        -- Insertar el pago
        INSERT INTO pago (id_pedido, monto, estado)
        VALUES (p_id_pedido, p_monto_pago, 'Completado');

        -- Insertar la entrega
        INSERT INTO entrega (id_pedido, fecha_entrega, estado)
        VALUES (p_id_pedido, NOW(), 'En camino');

        -- Actualizar el estado del pedido
        UPDATE pedido
        SET estado = 'Procesado'
        WHERE id_pedido = p_id_pedido;

        COMMIT;
        SELECT 'Pedido procesado con éxito.' AS mensaje;
    END IF;
END //

DELIMITER ;
```




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

-- Base de datos logistica
-- Este procedimiento maneja una transacción completa: pedido, pago y entrega
-- Si cualquiera de estos pasos falla, se revierte toda la transacción

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

-- Casos de prueba
-- CALL procesar_pedido_completo(1, 100.00); -- Pedido válido
-- CALL procesar_pedido_completo(1, 100.00); -- Error: pedido ya procesado
-- CALL procesar_pedido_completo(2, -50.00); -- Error: monto negativo

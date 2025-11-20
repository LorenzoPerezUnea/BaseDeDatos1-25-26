# Pasos previos

```sql
DROP DATABASE IF EXISTS tienda_transacciones;

CREATE DATABASE tienda_transacciones
CHARACTER SET utf8mb4
COLLATE utf8mb4_general_ci;
USE tienda_transacciones;

CREATE TABLE cliente (
  id_cliente INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  email VARCHAR(100) UNIQUE,
  fecha_registro DATE DEFAULT (CURRENT_DATE)
) ENGINE=InnoDB;

CREATE TABLE producto (
  id_producto INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  precio DECIMAL(10,2) NOT NULL CHECK (precio > 0),
  stock INT DEFAULT 0
) ENGINE=InnoDB;

CREATE TABLE pedido (
  id_pedido INT AUTO_INCREMENT PRIMARY KEY,
  id_cliente INT NOT NULL,
  fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
  estado ENUM('Pendiente','Confirmado','Enviado','Cancelado') DEFAULT 'Pendiente',
  total DECIMAL(10,2) DEFAULT 0,
  FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE detalle_pedido (
  id_detalle INT AUTO_INCREMENT PRIMARY KEY,
  id_pedido INT NOT NULL,
  id_producto INT NOT NULL,
  cantidad INT DEFAULT 1 CHECK (cantidad > 0),
  subtotal DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido)
    ON DELETE CASCADE,
  FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
    ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE pago (
  id_pago INT AUTO_INCREMENT PRIMARY KEY,
  id_pedido INT NOT NULL,
  fecha_pago DATETIME DEFAULT CURRENT_TIMESTAMP,
  monto DECIMAL(10,2) NOT NULL CHECK (monto >= 0),
  metodo ENUM('Tarjeta','Transferencia','Efectivo') DEFAULT 'Efectivo',
  estado ENUM('Pendiente','Completado','Fallido') DEFAULT 'Pendiente',
  FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido)
    ON DELETE CASCADE
) ENGINE=InnoDB;

INSERT INTO cliente (nombre, email)
VALUES
('Ana López', 'ana@example.com'),
('Bruno Díaz', 'bruno@example.com'),
('Carla Gómez', 'carla@example.com'),
('Diego Torres', 'diego@example.com');

INSERT INTO producto (nombre, precio, stock)
VALUES
('Televisor', 950.00, 10),
('Cafetera', 70.00, 25),
('Laptop', 1200.00, 8),
('Almohada', 25.00, 40),
('Silla ergonómica', 180.00, 15);

INSERT INTO pedido (id_cliente, fecha, estado, total)
VALUES
(1, '2024-04-15 10:30:00', 'Confirmado', 1020.00),
(2, '2024-04-18 11:00:00', 'Pendiente', 95.00),
(3, '2024-04-20 09:45:00', 'Confirmado', 120.00),
(1, '2024-04-25 14:10:00', 'Pendiente', 70.00);

INSERT INTO detalle_pedido (id_pedido, id_producto, cantidad, subtotal)
VALUES
(1, 1, 1, 950.00),
(1, 2, 1, 70.00),
(2, 4, 1, 25.00),
(2, 2, 1, 70.00),
(3, 5, 1, 120.00),
(4, 4, 2, 50.00);

INSERT INTO pago (id_pedido, fecha_pago, monto, metodo, estado)
VALUES
(1, '2024-04-15 10:45:00', 1020.00, 'Tarjeta', 'Completado'),
(2, '2024-04-18 11:20:00', 95.00, 'Transferencia', 'Pendiente'),
(3, '2024-04-20 10:00:00', 120.00, 'Efectivo', 'Completado');
```

### Ejemplo 1:

```sql
START TRANSACTION;

INSERT INTO pedido (id_cliente, total, estado)
VALUES (4, 500.00, 'Pendiente');

SET @id_pedido := LAST_INSERT_ID();

INSERT INTO detalle_pedido (id_pedido, id_producto, cantidad, subtotal)
VALUES
(@id_pedido, 3, 1, 450.00),
(@id_pedido, 2, 1, 50.00);

UPDATE producto SET stock = stock - 1 WHERE id_producto IN (3, 2);

INSERT INTO pago (id_pedido, monto, metodo, estado)
VALUES (@id_pedido, 500.00, 'Tarjeta', 'Completado');

UPDATE pedido SET estado = 'Confirmado' WHERE id_pedido = @id_pedido;

COMMIT;
```

**Resultado esperado:**

* El pedido y su detalle quedan guardados.
* Se descuenta stock.
* Se genera el pago y cambia el estado del pedido a “Confirmado”.

### Ejemplo 2: Transacción con error y ROLLBACK

```sql
START TRANSACTION;

INSERT INTO pedido (id_cliente, total, estado)
VALUES (2, 800.00, 'Pendiente');

SET @id_pedido := LAST_INSERT_ID();

-- error intencional: el producto 99 no existe
INSERT INTO detalle_pedido (id_pedido, id_producto, cantidad, subtotal)
VALUES (@id_pedido, 99, 1, 800.00);

-- Como esto generará un error, la transacción debe revertirse:
ROLLBACK;
```

**Resultado esperado:**

* Ningún pedido ni detalle es almacenado.
* La base de datos mantiene su consistencia.

### Ejemplo 3: SAVEPOINT y ROLLBACK parcial

```sql
START TRANSACTION;

INSERT INTO cliente (nombre, email) VALUES (10, 'Mario', 'mario@mail.com');
SAVEPOINT insercion_cliente;

INSERT INTO pedido  (id_cliente, fecha, estado, total) VALUES (1, CURDATE(), 'Pendiente', 350.00);
SAVEPOINT insercion_pedido;

ROLLBACK TO insercion_cliente;  -- anula la inserción de pedido, conserva cliente
COMMIT;
```

### Ejemplo 4 — Transacciones concurrentes

Dos usuarios intentan modificar el mismo stock simultáneamente:

```sql
-- Sesión A
START TRANSACTION;
SELECT stock FROM producto WHERE id_producto = 1 FOR UPDATE;
UPDATE producto SET stock = stock - 1 WHERE id_producto = 1;
-- (espera commit para liberar el bloqueo)

-- Sesión B
START TRANSACTION;
SELECT stock FROM producto WHERE id_producto = 1 FOR UPDATE;
--  Esta transacción se bloquea hasta que la sesión A haga COMMIT o ROLLBACK
```


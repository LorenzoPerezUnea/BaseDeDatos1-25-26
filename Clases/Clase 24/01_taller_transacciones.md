# **Taller simulación de operaciones completas**

## **Ejercicio 1**

Transacción básica con valdación de stock

```sql
CREATE DATABASE tienda_transacciones;
USE tienda_transacciones;

CREATE TABLE cliente (
  id_cliente INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100)
);

CREATE TABLE producto (
  id_producto INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100),
  precio DECIMAL(10,2),
  stock INT
);

CREATE TABLE venta (
  id_venta INT AUTO_INCREMENT PRIMARY KEY,
  id_cliente INT,
  fecha DATETIME,
  total DECIMAL(10,2),
  FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

CREATE TABLE detalle_venta (
  id_detalle INT AUTO_INCREMENT PRIMARY KEY,
  id_venta INT,
  id_producto INT,
  cantidad INT,
  subtotal DECIMAL(10,2),
  FOREIGN KEY (id_venta) REFERENCES venta(id_venta),
  FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);

CREATE TABLE pago (
  id_pago INT AUTO_INCREMENT PRIMARY KEY,
  id_venta INT,
  monto DECIMAL(10,2),
  fecha_pago DATETIME,
  FOREIGN KEY (id_venta) REFERENCES venta(id_venta)
);

INSERT INTO cliente (nombre)
VALUES ('Ana'), ('Luis'), ('Sofía');

INSERT INTO producto (nombre, precio, stock)
VALUES 
('Televisor', 950.00, 3),
('Cafetera', 70.00, 5),
('Laptop', 1200.00, 1);
```

## **Ejercicio 2**

Agregar ​cálculo automático del total de venta​, y validar que el ​total no sea menor que el pago recibido​.

```sql
CREATE DATABASE taller_ventas;
USE taller_ventas;

CREATE TABLE cliente (
  id_cliente INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100)
);

CREATE TABLE producto (
  id_producto INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100),
  precio DECIMAL(10,2),
  stock INT
);

CREATE TABLE venta (
  id_venta INT AUTO_INCREMENT PRIMARY KEY,
  id_cliente INT,
  fecha DATETIME,
  total DECIMAL(10,2) DEFAULT 0,
  FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

CREATE TABLE detalle_venta (
  id_detalle INT AUTO_INCREMENT PRIMARY KEY,
  id_venta INT,
  id_producto INT,
  cantidad INT,
  subtotal DECIMAL(10,2),
  FOREIGN KEY (id_venta) REFERENCES venta(id_venta),
  FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);

CREATE TABLE pago (
  id_pago INT AUTO_INCREMENT PRIMARY KEY,
  id_venta INT,
  monto DECIMAL(10,2),
  fecha_pago DATETIME,
  FOREIGN KEY (id_venta) REFERENCES venta(id_venta)
);

INSERT INTO cliente (nombre) VALUES ('Carlos'), ('María');

INSERT INTO producto (nombre, precio, stock)
VALUES 
('Monitor', 200.00, 3),
('Teclado', 50.00, 10),
('Ratón', 25.00, 8);
```

## **Ejercicio 3**

Si una **entrega** o un **pago** falla, se revierte toda la transacción.

```sql
CREATE DATABASE logistica;
USE logistica;

CREATE TABLE cliente (
  id_cliente INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100)
);

CREATE TABLE pedido (
  id_pedido INT AUTO_INCREMENT PRIMARY KEY,
  id_cliente INT,
  fecha DATETIME,
  estado VARCHAR(20),
  FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

CREATE TABLE entrega (
  id_entrega INT AUTO_INCREMENT PRIMARY KEY,
  id_pedido INT,
  fecha_entrega DATETIME,
  estado VARCHAR(20),
  FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido)
);

CREATE TABLE pago (
  id_pago INT AUTO_INCREMENT PRIMARY KEY,
  id_pedido INT,
  monto DECIMAL(10,2),
  estado VARCHAR(20),
  FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido)
);

INSERT INTO cliente (nombre)
VALUES ('Javier'), ('Lucía');

INSERT INTO pedido (id_cliente, fecha, estado)
VALUES 
(1, NOW(), 'Pendiente'),
(2, NOW(), 'Pendiente');

```


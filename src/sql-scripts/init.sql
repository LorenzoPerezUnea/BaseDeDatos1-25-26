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


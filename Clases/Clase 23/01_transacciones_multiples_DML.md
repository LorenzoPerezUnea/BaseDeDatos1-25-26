# **​ Práctica: Transacciones con múltiples DML**

En esta clase se trabajará con transacciones reales donde varios DML deben ejecutarse como un bloque lógico.
La base de datos simula un sistema de ventas simplificado.

## **1. DDL base**

```sql
CREATE DATABASE tienda_transacciones_2;

USE tienda_transacciones_2;

CREATE TABLE cliente (
  id_cliente INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100)
);

CREATE TABLE producto (
  id_producto INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100),
  stock INT,
  precio DECIMAL(10,2)
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
```

## **2. Inserts iniciales**

```sql
INSERT INTO cliente (nombre) VALUES ('Ana'), ('Bruno'), ('Carla');
INSERT INTO producto (nombre, stock, precio)
VALUES ('Laptop', 10, 950.00), ('Mouse', 30, 25.00), ('Monitor', 15, 180.00);
```


CREATE DATABASE taller_normalizacion;
USE taller_normalizacion;

CREATE TABLE cliente_pedido (
  id_cliente INT AUTO_INCREMENT PRIMARY KEY,
  nombre_cliente VARCHAR(100),
  direccion VARCHAR(150),
  id_pedido INT,
  fecha_pedido DATE,
  producto VARCHAR(100),
  cantidad INT,
  precio_unitario DECIMAL(10,2),
  region VARCHAR(100)
);

CREATE TABLE proveedor_producto_region (
  id_proveedor INT AUTO_INCREMENT PRIMARY KEY,
  nombre_proveedor VARCHAR(100),
  producto VARCHAR(100),
  region VARCHAR(100),
  precio DECIMAL(10,2)
);

CREATE TABLE producto_categoria (
  id_producto INT AUTO_INCREMENT PRIMARY KEY,
  nombre_producto VARCHAR(100),
  categoria VARCHAR(100),
  subcategoria VARCHAR(100)
);
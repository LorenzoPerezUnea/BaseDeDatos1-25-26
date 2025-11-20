```sql
CREATE DATABASE tienda_avanzada CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE tienda_avanzada;

CREATE TABLE cliente (
id_cliente INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
ciudad VARCHAR(100),
email VARCHAR(100)
) ENGINE=InnoDB;

CREATE TABLE categoria (
id_categoria INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE producto (
id_producto INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
precio DECIMAL(10,2) NOT NULL,
id_categoria INT,
FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria)
) ENGINE=InnoDB;

CREATE TABLE pedido (
id_pedido INT AUTO_INCREMENT PRIMARY KEY,
id_cliente INT NOT NULL,
fecha DATE,
estado ENUM('Pendiente','Pagado','Cancelado') DEFAULT 'Pendiente',
FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
) ENGINE=InnoDB;

CREATE TABLE detalle_pedido (
id_detalle INT AUTO_INCREMENT PRIMARY KEY,
id_pedido INT NOT NULL,
id_producto INT NOT NULL,
cantidad INT DEFAULT 1,
subtotal DECIMAL(10,2),
FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido) ON DELETE CASCADE,
FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
) ENGINE=InnoDB;

CREATE TABLE pago (
id_pago INT AUTO_INCREMENT PRIMARY KEY,
id_pedido INT NOT NULL,
metodo VARCHAR(50),
monto DECIMAL(10,2),
fecha_pago DATE,
FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido)
) ENGINE=InnoDB;
```


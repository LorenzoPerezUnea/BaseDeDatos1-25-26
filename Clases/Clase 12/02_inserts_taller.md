# Inserción Masiva de Datos de Prueba

Se insertan hasta 10 registros en cada tabla para generar un entorno de práctica DML completo.

```sql
USE tienda_dml;

INSERT INTO cliente (nombre, email, telefono) VALUES
('Carlos Pérez', 'carlos@correo.com', '600123123'),
('Ana López', 'ana@correo.com', '600234234'),
('Luis García', 'luis@correo.com', '600345345'),
('María Torres', 'maria@correo.com', '600456456'),
('Sofía Díaz', 'sofia@correo.com', '600567567');

INSERT INTO categoria (nombre, descripcion) VALUES
('Electrónica', 'Dispositivos y accesorios tecnológicos'),
('Hogar', 'Artículos para el hogar'),
('Deporte', 'Ropa y equipos deportivos'),
('Libros', 'Libros físicos y digitales'),
('Juguetes', 'Juguetes para niños de todas las edades');

INSERT INTO producto (nombre, precio, stock, id_categoria) VALUES
('Teclado Mecánico', 80.00, 15, 1),
('Ratón Inalámbrico', 25.00, 30, 1),
('Silla Gamer', 190.00, 5, 2),
('Pelota de Fútbol', 35.00, 20, 3),
('Libro de SQL', 45.00, 10, 4),
('Puzzle 1000 piezas', 20.00, 12, 5);

INSERT INTO pedido (id_cliente, total) VALUES
(1, 105.00),
(2, 70.00),
(3, 25.00),
(4, 190.00),
(5, 45.00);

INSERT INTO detalle_pedido (id_pedido, id_producto, cantidad) VALUES
(1, 1, 1),
(1, 2, 1),
(2, 4, 2),
(3, 2, 1),
(4, 3, 1),
(5, 5, 1);
```


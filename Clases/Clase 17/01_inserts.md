```sql
INSERT INTO cliente (nombre, ciudad, email) VALUES
('Ana Pérez','Quito','ana@example.com'),
('Bruno Díaz','Guayaquil','bruno@example.com'),
('Carla Mena','Cuenca','carla@example.com'),
('David Ruiz','Quito','david@example.com'),
('Elena Torres','Loja','elena@example.com');
('Juana Sanchez','Loja','jsan@example.com');

INSERT INTO categoria (nombre) VALUES
('Electrónica'),('Hogar'),('Ropa'),('Alimentos'),('Juguetes');

INSERT INTO producto (nombre, precio, id_categoria) VALUES
('Televisor 50"', 800.00, 1),
('Licuadora', 60.00, 2),
('Camisa Algodón', 25.00, 3),
('Leche Entera', 1.50, 4),
('Lego Star Wars', 120.00, 5),
('Laptop Gamer', 1200.00, 1),
('Aspiradora', 180.00, 2),
('Pantalón Jeans', 40.00, 3),
('Cereal Integral', 4.50, 4),
('Pelota de Fútbol', 35.00, 5);

INSERT INTO pedido (id_cliente, fecha, estado) VALUES
(1,'2024-06-01','Pagado'),
(2,'2024-06-03','Pendiente'),
(3,'2024-06-05','Pagado'),
(4,'2024-06-08','Cancelado'),
(5,'2024-06-10','Pagado');

INSERT INTO detalle_pedido (id_pedido,id_producto,cantidad,subtotal) VALUES
(1,1,1,800.00),
(1,2,1,60.00),
(2,4,10,15.00),
(3,6,1,1200.00),
(3,3,2,50.00),
(4,5,1,120.00),
(5,7,1,180.00),
(5,8,2,80.00),
(5,9,3,13.50);

INSERT INTO pago (id_pedido, metodo, monto, fecha_pago) VALUES
(1,'Tarjeta',860.00,'2024-06-02'),
(3,'Transferencia',1250.00,'2024-06-06'),
(5,'Efectivo',273.50,'2024-06-11');
```


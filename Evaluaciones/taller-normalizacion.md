# Respuestas de taller:

1.
- La segunda forma normal se viola debido a que la clave primaria idea seria id_pedido, e id_producto en una pivote. En este caso todas las relaciones se estan cuantificando en la table cliente pedido. 
- En la misma tabla esta misma relacion pedido producto, esta siendo determinada por la tabla cliente_pedido. Lo que causa una dependencia transitiva, un atributo no-clave depende de otros atributos no clave. Violando la 3era forma normal.
- Se viola la cuarta forma normal adicionalmente porque la table cuenta con multiples valores para una misma llave foranea. 


## CREATE TABLES CON SUS LLAVES FORANEAS Y REFERENCIAS
2 y 4. 

```sql 
    -- Tabla cliente normalizada
CREATE TABLE cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre_cliente VARCHAR(100) NOT NULL,
    direccion VARCHAR(255) NOT NULL,
    region VARCHAR(50) NOT NULL
);

-- Tabla pedido relacionada a cliente (1 pedido por cliente)
CREATE TABLE pedido (
    id_pedido INT PRIMARY KEY,
    id_cliente INT NOT NULL,
    fecha_pedido DATE NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

-- Tabla producto normalizada
CREATE TABLE producto (
    nombre_producto VARCHAR(50) PRIMARY KEY,
    categoria VARCHAR(50) NOT NULL,
    subcategoria VARCHAR(50) NOT NULL
);

-- Tabla proveedor para normalizar cliente_pedido
CREATE TABLE proveedor (
    id_proveedor INT AUTO_INCREMENT PRIMARY KEY,
    nombre_proveedor VARCHAR(100) NOT NULL
);

-- Relación proveedor-producto-región con precios
CREATE TABLE proveedor_producto_region (
    id_proveedor INT NOT NULL,
    nombre_producto VARCHAR(50) NOT NULL,
    region VARCHAR(50) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (id_proveedor, nombre_producto, region),
    FOREIGN KEY (id_proveedor) REFERENCES proveedor(id_proveedor),
    FOREIGN KEY (nombre_producto) REFERENCES producto(nombre_producto)
);

-- Detalle de pedido con productos (relación N a M)
CREATE TABLE pedido_producto (
    id_pedido INT NOT NULL,
    nombre_producto VARCHAR(50) NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (id_pedido, nombre_producto),
    FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
    FOREIGN KEY (nombre_producto) REFERENCES producto(nombre_producto)
);

```

### Tablas normalizadas con sus datos
3. 
```sql

INSERT INTO cliente (nombre_cliente, direccion, region) VALUES
('Ana Torres', 'Av. Central 101', 'Norte'),
('Carlos Ruiz', 'Calle 12 #45', 'Centro'),
('Laura Díaz', 'Av. Sur 303', 'Sur');

-- Proveedores
INSERT INTO proveedor (nombre_proveedor) VALUES
('Industrias Norte'),
('Acero Andino'),
('MetalSur');

-- Productos con categorías
INSERT INTO producto (nombre_producto, categoria, subcategoria) VALUES
('Tornillos', 'Fijaciones', 'Metálicos'),
('Tuercas', 'Fijaciones', 'Metálicos'),
('Arandelas', 'Fijaciones', 'Metálicos'),
('Cable eléctrico', 'Conectividad', 'Cobre'),
('Conector', 'Conectividad', 'Plástico');

-- Pedidos con referencia a clientes (suponiendo ID auto-incrementales según cliente insert)
INSERT INTO pedido (id_pedido, id_cliente, fecha_pedido) VALUES
(1, 1, '2024-05-10'),
(2, 2, '2024-05-12'),
(3, 2, '2024-06-02'),
(4, 3, '2024-06-15');

-- Relación proveedor-producto-región con precios, asignando IDs de proveedores según orden insert
INSERT INTO proveedor_producto_region (id_proveedor, nombre_producto, region, precio) VALUES
(1, 'Tornillos', 'Norte', 0.10),
(1, 'Tuercas', 'Norte', 0.12),
(2, 'Arandelas', 'Centro', 0.08),
(3, 'Tuercas', 'Sur', 0.11),
(3, 'Tornillos', 'Sur', 0.09);

-- Detalle de productos por pedido
INSERT INTO pedido_producto (id_pedido, nombre_producto, cantidad, precio_unitario) VALUES
(1, 'Tornillos', 100, 0.25),
(1, 'Tuercas', 100, 0.30),
(2, 'Arandelas', 50, 0.15),
(3, 'Tornillos', 200, 0.22),
(4, 'Tuercas', 150, 0.28);

```
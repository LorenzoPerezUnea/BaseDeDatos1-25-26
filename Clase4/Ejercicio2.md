# Marketplace + Logística (Ventas, Proveedores, Stock, Envíos, Devoluciones, Promociones)

---

## 1. Lista Predefinida de Requisitos

1. La plataforma es un **marketplace** donde **Vendedores** ponen a la venta **Productos** y **Clientes** compran.  
2. Un **Usuario** puede ser ​**Cliente**, **Vendedor** o ambos (subtipos).  
3. Los **Productos** tienen **variantes** (talla, color, etc.) y pertenecen a **Categorías jerárquicas**.  
4. Cada **Producto/Variante** mantiene **inventario** por **Almacén** (multi-warehouse).  
5. Los **Vendedores** pueden tener múltiples almacenes o usar “dropshipping”.  
6. Un **Pedido** es creado por un Cliente y puede contener múltiples **Líneas de pedido**.  
7. Un Pedido puede dividirse en **varios envíos (Shipments)** con estado de envío.  
8. Registro de **Pagos**, con posibles múltiples intentos y reembolsos parciales.  
9. **Devoluciones** por línea, con motivo, estado y posible nota de crédito o reembolso.  
10. **Promociones / Cupones** aplicables por producto, categoría, vendedor o pedido (fechas de validez y condiciones mínimas).  
11. **Reseñas y valoraciones** de producto por clientes; reputación de vendedor.  
12. **Historial de precios** por variante para auditoría y análisis.  
13. Reglas de negocio: reserva de stock al crear pedido, cancelación en ventana de tiempo, bloqueo de envío si stock insuficiente, máximos de compra por cliente.  
14. Registro de **logs de auditoría**: quién creó/actualizó pedidos, cambios críticos de stock.  
15. **Reportes**: ventas por día/región/vendedor, productos sin stock, pedidos pendientes de pago.

---

## 2. Identificación de Entidades y Atributos

### USUARIO
- id_usuario (PK)  
- nombre  
- email  
- telefono  

### CLIENTE (subtipo de USUARIO)
- id_cliente (PK, FK a USUARIO)  
- fecha_registro  
- nivel_fidelidad  

### VENDEDOR (subtipo de USUARIO)
- id_vendedor (PK, FK a USUARIO)  
- reputacion  
- fecha_alta  

### CATEGORIA
- id_categoria (PK)  
- nombre  
- id_categoria_padre (FK, nullable)  

### PRODUCTO
- id_producto (PK)  
- id_vendedor (FK)  
- nombre  
- descripcion  
- id_categoria (FK)  

### VARIANTE_PRODUCTO
- id_variante (PK)  
- id_producto (FK)  
- talla  
- color  
- sku  

### ALMACEN
- id_almacen (PK)  
- id_vendedor (FK)  
- nombre  
- direccion  

### INVENTARIO
- id_inventario (PK)  
- id_almacen (FK)  
- id_variante (FK)  
- cantidad_disponible  
- cantidad_reservada  

### PEDIDO
- id_pedido (PK)  
- id_cliente (FK)  
- fecha_creacion  
- estado_pedido  

### LINEA_PEDIDO
- id_linea (PK)  
- id_pedido (FK)  
- id_variante (FK)  
- cantidad  
- precio_unitario  

### ENVIO (Shipment)
- id_envio (PK)  
- id_pedido (FK)  
- estado_envio  
- fecha_envio  

### PAGO
- id_pago (PK)  
- id_pedido (FK)  
- monto  
- metodo_pago  
- estado_pago  

### REEMBOLSO
- id_reembolso (PK)  
- id_pago (FK)  
- monto_devuelto  
- motivo  

### DEVOLUCION
- id_devolucion (PK)  
- id_linea (FK)  
- motivo  
- estado  

### PROMOCION
- id_promocion (PK)  
- nombre  
- tipo_aplicacion (por_producto, por_categoria, por_pedido)  
- porcentaje_descuento  
- fecha_inicio / fecha_fin  

### RESEÑA
- id_resena (PK)  
- id_cliente (FK)  
- id_producto (FK)  
- calificacion  
- comentario  

### HISTORIAL_PRECIO
- id_historial (PK)  
- id_variante (FK)  
- precio  
- fecha_inicio  
- fecha_fin  

### LOG_AUDITORIA
- id_log (PK)  
- entidad_afectada  
- id_entidad  
- usuario_responsable  
- fecha  
- descripcion  

---

## 3. Identificación de Relaciones y Cardinalidades

| Entidad A | Entidad B | Cardinalidad | Verbo / Descripción |
|------------|-----------|-------------|-------------------|
| Usuario | Cliente | 1:1 opcional | Usuario puede ser cliente |
| Usuario | Vendedor | 1:1 opcional | Usuario puede ser vendedor |
| Vendedor | Producto | 1:N | Vendedor publica productos |
| Producto | Variante | 1:N | Producto tiene variantes |
| Producto | Categoria | N:1 | Producto pertenece a categoría |
| Categoria | Categoria | 1:N | Categoría padre contiene subcategorías |
| Variante | Inventario | 1:N | Variante tiene registros de inventario |
| Almacén | Inventario | 1:N | Almacén gestiona inventario |
| Vendedor | Almacén | 1:N | Vendedor posee almacenes |
| Cliente | Pedido | 1:N | Cliente realiza pedidos |
| Pedido | LíneaPedido | 1:N | Pedido contiene líneas |
| Variante | LíneaPedido | 1:N | Variante incluida en línea |
| Pedido | Envío | 1:N | Pedido genera envíos |
| Pedido | Pago | 1:N | Pedido tiene pagos |
| Pago | Reembolso | 1:N | Pago genera reembolsos |
| LíneaPedido | Devolución | 0..N | Línea puede ser devuelta |
| Promoción | Producto | M:N | Promoción aplica a productos |
| Cliente | Reseña | 1:N | Cliente escribe reseñas |
| Producto | Reseña | 1:N | Producto recibe reseñas |
| Variante | HistorialPrecio | 1:N | Variante registra historial |

---

## 4. Jerarquías / Generalizaciones

1. **Usuario**
   - Cliente  
   - Vendedor  

2. **Promoción**
   - Por producto  
   - Por categoría  
   - Por pedido  

3. **Stock / Inventario**
   - Multi-warehouse (almacenes del vendedor)  
   - Dropshipping (almacenes de proveedor)  

---


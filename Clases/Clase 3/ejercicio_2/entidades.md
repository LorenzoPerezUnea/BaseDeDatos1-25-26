# Modelo de Datos – Marketplace + Logística

## 1. Entidades principales

| **Entidad**        | **Atributos clave**                                                                                 | **Comentario**                                      |
|--------------------|------------------------------------------------------------------------------------------------------|------------------------------------------------------|
| **Usuario**        | **id_usuario (PK)**, nombre, email, password_hash, tipo(s) (Cliente/Vendedor)                        | Super-entidad.                                       |
| **Cliente** (sub)  | **id_cliente (PK, FK→Usuario)**, dirección_envío, fecha_registro                                      | Subtipo de Usuario.                                  |
| **Vendedor** (sub) | **id_vendedor (PK, FK→Usuario)**, reputación, nombre_tienda                                           | Subtipo de Usuario.                                  |
| **Categoría**      | **id_categoria (PK)**, nombre, id_padre (FK→Categoría)                                                | Jerárquica (self-join).                              |
| **Producto**       | **id_producto (PK)**, nombre, descripción, id_vendedor (FK→Vendedor), id_categoria (FK→Categoría)     |                                                      |
| **Variante**       | **id_variante (PK)**, id_producto (FK→Producto), sku, talla, color, precio_actual                     |                                                      |
| **HistorialPrecio**| **id_historial (PK)**, id_variante (FK→Variante), fecha, precio                                       | Auditoría de cambios de precio.                      |
| **Almacén**        | **id_almacen (PK)**, id_vendedor (FK→Vendedor, NULL si dropshipping), nombre, ubicación               |                                                      |
| **Inventario**     | **(PK compuesta)** id_variante (FK→Variante), id_almacen (FK→Almacén), stock, reservado               | Relación M:N Variante–Almacén.                       |
| **Pedido**         | **id_pedido (PK)**, id_cliente (FK→Cliente), fecha_creación, estado, total                             |                                                      |
| **LíneaPedido**    | **id_linea (PK)**, id_pedido (FK→Pedido), id_variante (FK→Variante), cantidad, precio_unitario         |                                                      |
| **Envío (Shipment)**| **id_envio (PK)**, id_pedido (FK→Pedido), estado_envío, fecha_envío                                   | Un pedido puede tener varios envíos.                 |
| **ItemEnvío**      | **(PK compuesta)** id_envio (FK→Envío), id_linea (FK→LíneaPedido)                                     | Relación M:N Envío–LíneaPedido.                      |
| **Pago**           | **id_pago (PK)**, id_pedido (FK→Pedido), método, monto, estado, fecha                                 | Múltiples intentos posibles.                         |
| **Devolución**     | **id_devolucion (PK)**, id_linea (FK→LíneaPedido), motivo, estado, nota_credito, monto_reembolso      |                                                      |
| **Promoción/Cupón**| **id_promocion (PK)**, tipo, descuento, fecha_inicio, fecha_fin, condiciones                           |                                                      |
| **PromocionProducto** | **(PK compuesta)** id_promocion (FK→Promoción), id_producto (FK→Producto)                          | M:N con Producto.                                    |
| **PromocionCategoria**| **(PK compuesta)** id_promocion (FK→Promoción), id_categoria (FK→Categoría)                        | M:N con Categoría.                                   |
| **PromocionVendedor** | **(PK compuesta)** id_promocion (FK→Promoción), id_vendedor (FK→Vendedor)                          | M:N con Vendedor.                                    |
| **PromocionPedido**   | **(PK compuesta)** id_promocion (FK→Promoción), id_pedido (FK→Pedido)                               | M:N con Pedido.                                      |
| **ReseñaProducto**| **id_resena (PK)**, id_cliente (FK→Cliente), id_producto (FK→Producto), rating, comentario, fecha      |                                                      |
| **LogAuditoria**  | **id_log (PK)**, usuario_actor (FK→Usuario), entidad, id_entidad, acción, fecha, detalles              | Registro de cambios críticos (stock, pedidos, etc.). |

---

## 2. Relaciones clave

- **Usuario 1—1 Cliente** 
- **Usuario 1—1 Vendedor**  
- **Vendedor 1—N Producto**  
- **Categoría 1—N Categoría** 
- **Categoría 1—N Producto**  
- **Producto 1—N Variante**  
- **Variante N—N Almacén** (por **Inventario**)  
- **Cliente 1—N Pedido**  
- **Pedido 1—N LíneaPedido**  
- **Pedido 1—N Envío**  
- **Envío N—N LíneaPedido** (por **ItemEnvío**)  
- **Pedido 1—N Pago**  
- **LíneaPedido 1—0..1 Devolución**  
- **Promoción M—N Producto / Categoría / Vendedor / Pedido**  
- **Variante 1—N HistorialPrecio**  
- **Producto 1—N ReseñaProducto (por Cliente)**  
- **Usuario 1—N LogAuditoria**

---
# Modelo Conceptual – Marketplace + Logística

## Paso 1 – Identificación de Entidades
- **Usuario** (superclase)  
- **Cliente** (subclase de Usuario)  
- **Vendedor** (subclase de Usuario)  
- **Producto**  
- **VarianteProducto**  
- **Categoría** (jerárquica)  
- **Almacén**  
- **Pedido**  
- **LíneaPedido**  
- **Envío (Shipment)**  
- **Pago**  
- **MétodoPago**  
- **Devolución**  
- **Promoción/Cupón**  
- **ReseñaProducto**  
- **ReputaciónVendedor**  
- **HistorialPrecio**  
- **LogAuditoría**


## Paso 2 – Relaciones y Verbos
- **Usuario —< es subtipo de >— Cliente/Vendedor**  
- **Vendedor —< ofrece >— Producto (1:N)**  
- **Producto —< tiene >— VarianteProducto (1:N)**  
- **Producto —< pertenece a >— Categoría (N:1)**  
- **Categoría —< subdivide en >— Categoría (1:N)**  
- **VarianteProducto —< se almacena en >— Almacén (N:M, atributo: stock)**  
- **Pedido —< creado por >— Cliente (N:1)**  
- **Pedido —< contiene >— LíneaPedido (1:N)**  
- **LíneaPedido —< corresponde a >— VarianteProducto (N:1)**  
- **Pedido —< se divide en >— Envío (1:N)**  
- **Envío —< agrupa >— LíneaPedido (N:M)**  
- **Pedido —< tiene >— Pago (1:N)**  
- **Pago —< usa >— MétodoPago (N:1)**  
- **LíneaPedido —< puede generar >— Devolución (1:N)**  
- **Promoción —< aplicable a >— Producto/Categoría/Vendedor/Pedido (N:M)**  
- **Cliente —< realiza >— ReseñaProducto (1:N)**  
- **ReseñaProducto —< se refiere a >— Producto (N:1)**  
- **ReputaciónVendedor —< se asocia a >— Vendedor (1:1)**  
- **VarianteProducto —< tiene >— HistorialPrecio (1:N)**  
- **LogAuditoría —< registra >— Pedido/VarianteProducto/Usuario (N:M)**  


## Paso 3 – Atributos (Nivel Conceptual)
- **Usuario**: id_usuario, nombre, email, contraseña, rol  
- **Cliente**: id_cliente, dirección_envío, preferencias  
- **Vendedor**: id_vendedor, razón_social, datos_fiscales  
- **Producto**: id_producto, nombre, descripción, estado_publicación  
- **VarianteProducto**: id_variante, atributos_variante (talla, color), sku, precio_actual  
- **Categoría**: id_categoria, nombre, descripción  
- **Almacén**: id_almacen, nombre, ubicación, tipo (propio/proveedor)  
- **Pedido**: id_pedido, fecha_creación, estado, total, región  
- **LíneaPedido**: id_linea, cantidad, precio_unitario  
- **Envío**: id_envio, fecha_envio, estado_envio, tracking  
- **Pago**: id_pago, monto, estado_pago, fecha, tipo_transacción (intento/reembolso)  
- **MétodoPago**: id_metodo, tipo, proveedor  
- **Devolución**: id_devolucion, fecha, motivo, estado, nota_credito  
- **Promoción**: id_promocion, tipo, condiciones, fecha_inicio, fecha_fin, valor_descuento  
- **ReseñaProducto**: id_reseña, comentario, puntuación, fecha  
- **ReputaciónVendedor**: id_reputacion, score, comentarios_agregados  
- **HistorialPrecio**: id_historial, fecha_inicio, fecha_fin, precio  
- **LogAuditoría**: id_log, usuario_actor, acción, entidad_afectada, fecha, detalle_cambio  


## Paso 4 – Identificadores
- Usuario: id_usuario  
- Cliente: id_cliente  
- Vendedor: id_vendedor  
- Producto: id_producto  
- VarianteProducto: id_variante  
- Categoría: id_categoria  
- Almacén: id_almacen  
- Pedido: id_pedido  
- LíneaPedido: id_linea  
- Envío: id_envio  
- Pago: id_pago  
- MétodoPago: id_metodo  
- Devolución: id_devolucion  
- Promoción: id_promocion  
- ReseñaProducto: id_reseña  
- ReputaciónVendedor: id_reputacion  
- HistorialPrecio: id_historial  
- LogAuditoría: id_log  


## Paso 5 – Jerarquías de Generalización
```text
Usuario
├── Cliente
└── Vendedor

## Ejercicio: Marketplace + Logística

Una **plataforma marketplace** conecta a vendedores y clientes para la compra de productos, con gestión de inventario, envíos, devoluciones, promociones y auditoría.

---

## Paso 1 – Identificación de Entidades

Entidades detectadas:

- **Usuario** (superclase)
- **Cliente** (subclase)
- **Vendedor** (subclase)
- **Proveedor**
- **Categoría**
- **Producto**
- **Variante** (SKU)
- **Almacén**
- **Inventario**
- **Pedido**
- **LíneaPedido**
- **Envío**
- **ItemEnvío**
- **MétodoPago**
- **Pago**
- **Devolución**
- **LíneaDevolución**
- **Reembolso / NotaCrédito**
- **Promoción**
- **Cupón**
- **PromociónProducto**
- **PromociónCategoría**
- **PromociónVendedor**
- **PedidoPromoción**
- **ReseñaProducto**
- **ValoraciónVendedor**
- **HistorialPrecio**
- **LogAuditoría**

---

## Paso 2 – Relaciones y Verbos

Relaciones principales con cardinalidades:

- **Usuario —< especializa >— Cliente / Vendedor**
- **Categoría —< subcategoriza >— Categoría** (autorreferencia)
- **Vendedor —< publica >— Producto**
- **Producto —< tiene >— Variante**
- **Producto —< pertenece a >— Categoría**
- **Vendedor / Proveedor —< opera >— Almacén**
- **Variante —< mantiene >— Inventario —< en >— Almacén**
- **Cliente —< crea >— Pedido**
- **Pedido —< contiene >— LíneaPedido**
- **Variante —< aparece en >— LíneaPedido**
- **Vendedor —< vende >— LíneaPedido**
- **Pedido —< se divide en >— Envío**
- **Envío —< agrupa >— ItemEnvío**
- **LíneaPedido —< referencia >— ItemEnvío**
- **Pedido —< registra >— Pago —< usa >— MétodoPago**
- **Pago —< puede generar >— Reembolso**
- **Pedido —< registra >— Devolución —< contiene >— LíneaDevolución**
- **LíneaPedido —< referencia >— LíneaDevolución**
- **Devolución —< puede generar >— Reembolso**
- **Promoción / Cupón —< se aplica a >— Producto / Categoría / Vendedor / Pedido**
- **Cliente —< publica >— ReseñaProducto —< sobre >— Producto**
- **Cliente —< valora >— Vendedor**
- **Variante —< tiene >— HistorialPrecio**
- **Usuario —< genera >— LogAuditoría**

---

## Paso 3 – Atributos (Nivel Conceptual)

- **Usuario**: id_usuario, nombre, email, rol
- **Cliente**: id_usuario(FK), dirección_envío
- **Vendedor**: id_usuario(FK), nombre_tienda, reputación
- **Proveedor**: id_proveedor, nombre, contacto
- **Categoría**: id_categoria, nombre, id_padre
- **Producto**: id_producto, id_vendedor(FK), id_categoria(FK), nombre, descripción, max_por_cliente
- **Variante**: id_variante, id_producto(FK), sku, atributos (ej. talla/color), precio_actual, activo
- **Almacén**: id_almacen, nombre, ubicación, tipo_propietario, id_propietario
- **Inventario**: id_variante(FK), id_almacen(FK), stock_disponible, stock_reservado, stock_minimo
- **Pedido**: id_pedido, id_cliente(FK), fecha_creación, estado, totales (bruto, descuento, envío, neto), fecha_cancelable_hasta
- **LíneaPedido**: id_linea, id_pedido(FK), id_variante(FK), id_vendedor(FK), cantidad, precio_unitario, subtotal
- **Envío**: id_envio, id_pedido(FK), estado_envío, transportista, tracking, fechas
- **ItemEnvío**: id_envio(FK), id_linea(FK), cantidad_enviada
- **MétodoPago**: id_metodopago, nombre
- **Pago**: id_pago, id_pedido(FK), id_metodopago(FK), intento, importe, estado, transacción_externa, fecha
- **Devolución**: id_devolucion, id_pedido(FK), estado, motivo, fecha
- **LíneaDevolución**: id_linea_devol, id_devolucion(FK), id_linea(FK), cantidad_devuelta, motivo
- **Reembolso**: id_reembolso, id_pago(FK), id_devolucion(FK), importe, tipo, estado, fecha
- **Promoción**: id_promocion, nombre, tipo_descuento, valor, fechas, condiciones, activo
- **Cupón**: id_cupon, código, usos_max, usos_por_usuario, fechas, activo
- **PromociónProducto**: id_promocion(FK), id_producto(FK)
- **PromociónCategoría**: id_promocion(FK), id_categoria(FK)
- **PromociónVendedor**: id_promocion(FK), id_vendedor(FK)
- **PedidoPromoción**: id_pedido(FK), id_promocion(FK), id_cupon(FK), ahorro
- **ReseñaProducto**: id_reseña, id_cliente(FK), id_producto(FK), rating, comentario, fecha
- **ValoraciónVendedor**: id_valoracion, id_cliente(FK), id_vendedor(FK), rating, comentario, fecha
- **HistorialPrecio**: id_historial, id_variante(FK), precio, fecha_inicio, fecha_fin
- **LogAuditoría**: id_log, entidad, id_entidad, acción, id_usuario_actor(FK), detalle, fecha

---

## Paso 4 – Identificadores

- **Usuario**: id_usuario  
- **Cliente**: id_usuario (FK/PK)  
- **Vendedor**: id_usuario (FK/PK)  
- **Proveedor**: id_proveedor  
- **Categoría**: id_categoria  
- **Producto**: id_producto  
- **Variante**: id_variante, (sku único)  
- **Almacén**: id_almacen  
- **Inventario**: (id_variante, id_almacen)  
- **Pedido**: id_pedido  
- **LíneaPedido**: id_linea  
- **Envío**: id_envio  
- **ItemEnvío**: (id_envio, id_linea)  
- **MétodoPago**: id_metodopago  
- **Pago**: id_pago  
- **Devolución**: id_devolucion  
- **LíneaDevolución**: id_linea_devol  
- **Reembolso**: id_reembolso  
- **Promoción**: id_promocion  
- **Cupón**: id_cupon (código único)  
- **PromociónProducto**: (id_promocion, id_producto)  
- **PromociónCategoría**: (id_promocion, id_categoria)  
- **PromociónVendedor**: (id_promocion, id_vendedor)  
- **PedidoPromoción**: (id_pedido, id_promocion, id_cupon)  
- **ReseñaProducto**: id_reseña  
- **ValoraciónVendedor**: id_valoracion  
- **HistorialPrecio**: id_historial  
- **LogAuditoría**: id_log  

---

## Paso 5 – Jerarquías de Generalización

Usuario  
├── Cliente  
└── Vendedor  

- **Cobertura:** Parcial (un usuario puede no ser ni cliente ni vendedor todavía).  
- **Disyunción:** No disjunta (un usuario puede ser ambas cosas).  

Categoría  
└── Subcategorías (autorreferencia recursiva).  

---

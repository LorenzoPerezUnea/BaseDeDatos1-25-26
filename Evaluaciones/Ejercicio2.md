# Ejercicio: Marketplace + Logística

## 1. Lista predefinida de requisitos
- Los **usuarios** pueden ser **clientes**, **vendedores** o ambos.  
- Los **vendedores** publican **productos** a la venta.  
- Los **productos** tienen **variantes** (atributos como talla, color).  
- Los productos pertenecen a una **categoría jerárquica** (categoría → subcategoría → …).  
- Cada variante mantiene inventario en uno o varios **almacenes** (multi-warehouse).  
- Los vendedores pueden usar **almacenes propios** o “**dropshipping**” desde proveedor.  
- Un **pedido** es creado por un cliente y tiene múltiples **líneas de pedido** (cada línea refiere a una variante).  
- Un pedido puede dividirse en múltiples **envíos (shipments)** con estado propio.  
- El sistema registra **pagos** (puede haber varios intentos) y permite **reembolsos parciales**.  
- Existen **devoluciones** a nivel de línea, con motivo, estado y posible nota de crédito o reembolso.  
- Se aplican **promociones / cupones** por producto, categoría, vendedor o pedido (con condiciones y fechas).  
- Los clientes pueden escribir **reseñas y valoraciones de productos**.  
- Se calcula la **reputación de vendedores**.  
- Se mantiene un **historial de precios** de cada variante para auditoría/análisis.  
- Reglas de negocio:  
  - Reserva de stock al crear pedido.  
  - Cancelación dentro de ventana X minutos.  
  - Bloqueo de envío si stock insuficiente.  
  - Límite de compra por cliente y producto (ej. 5 unidades).  
- Se registran **logs de auditoría** (quién creó/actualizó pedidos, cambios críticos de stock).  
- Reportes frecuentes:  
  - Ventas por día/región/vendedor.  
  - Productos sin stock.  
  - Pedidos pendientes de pago.  

---

## 2. Identificación de Entidades
- **USUARIO**: persona que usa la plataforma.  
- **CLIENTE**: subtipo de usuario que compra.  
- **VENDEDOR**: subtipo de usuario que vende productos y gestiona almacenes.  
- **CATEGORÍA**: clasificación jerárquica de productos.  
- **PRODUCTO**: ítem publicado por vendedor.  
- **VARIANTE**: versión específica de un producto (ej. talla, color).  
- **ALMACÉN**: lugar físico o virtual (dropshipping) con inventario.  
- **INVENTARIO**: relación variante–almacén con cantidad disponible/reservada.  
- **PEDIDO**: solicitud de compra creada por un cliente.  
- **LÍNEA DE PEDIDO**: item dentro de un pedido (referencia a variante).  
- **ENVÍO (SHIPMENT)**: agrupación de líneas enviadas con estado.  
- **PAGO**: transacción de pago asociada a pedido.  
- **REEMBOLSO**: devolución parcial/total de un pago.  
- **DEVOLUCIÓN**: registro de devolución por línea de pedido.  
- **PROMOCIÓN / CUPÓN**: descuento aplicable según condiciones.  
- **RESEÑA**: opinión y valoración de un producto por un cliente.  
- **REPUTACIÓN**: valoración agregada de un vendedor.  
- **HISTORIAL DE PRECIOS**: cambios de precio de una variante.  
- **LOG DE AUDITORÍA**: registro de operaciones críticas.  

---

## 3. Identificación de Relaciones
- Usuario (1) — puede ser — (0..1) Cliente  
- Usuario (1) — puede ser — (0..1) Vendedor  
- Vendedor (1) — publica — (0..N) Producto  
- Producto (1) — tiene — (1..N) Variante  
- Producto (N) — pertenece a — (1) Categoría  
- Categoría (1) — puede contener — (0..N) Subcategorías (jerarquía recursiva)  
- Variante (N) — está en — (N) Almacén → relación con Inventario  
- Cliente (1) — crea — (0..N) Pedido  
- Pedido (1) — contiene — (1..N) Línea de pedido  
- Línea de pedido (1..N) — corresponde a — (1) Variante  
- Pedido (1) — puede dividirse en — (0..N) Envíos  
- Envío (1) — agrupa — (1..N) Líneas de pedido  
- Pedido (1) — tiene — (0..N) Pagos  
- Pago (1) — puede tener — (0..N) Reembolsos  
- Línea de pedido (1) — puede tener — (0..1) Devolución  
- Promoción (0..N) — aplica a — (Producto / Categoría / Vendedor / Pedido)  
- Cliente (1) — escribe — (0..N) Reseña  
- Reseña (1) — sobre — (1) Producto  
- Vendedor (1) — recibe — (0..N) Reseñas → reputación calculada  
- Variante (1) — tiene — (0..N) Historial de precios  
- Entidad cualquiera — genera — (0..N) Logs de auditoría

---

## 4. Identificación de atributos

### Usuario (PK: id_usuario)
- id_usuario (PK)  
- nombre  
- email (único)  
- contraseña (hash)  
- región (para reportes)  
- fecha_creacion  

### Cliente (PK: id_cliente)
- id_cliente (PK)  
- id_usuario (FK → Usuario)  
- dirección_envío (texto/JSON opcional)  
- teléfono (opcional)  

### Vendedor (PK: id_vendedor)
- id_vendedor (PK)  
- id_usuario (FK → Usuario)  
- nombre_negocio  
- reputación (valor numérico calculado)  
- datos_adicionales (JSON opcional)  

### Categoría (PK: id_categoria)
- id_categoria (PK)  
- nombre  
- descripción  
- parent_id (FK → Categoría, jerarquía)  

### Producto (PK: id_producto)
- id_producto (PK)  
- id_vendedor (FK → Vendedor)  
- id_categoria (FK → Categoría)  
- nombre  
- descripción  

### Variante (PK: id_variante)
- id_variante (PK)  
- id_producto (FK → Producto)  
- sku (código único)  
- atributos (JSON: talla, color, etc.)  
- precio_actual  

### Almacén (PK: id_almacen)
- id_almacen (PK)  
- id_vendedor (FK → Vendedor)  
- nombre  
- dirección  
- es_dropshipping (booleano)  

### Inventario (PK: id_inventario)
- id_inventario (PK)  
- id_variante (FK → Variante)  
- id_almacen (FK → Almacén)  
- cantidad_disponible  
- cantidad_reservada  

### Pedido (PK: id_pedido)
- id_pedido (PK)  
- id_cliente (FK → Cliente)  
- fecha_creacion  
- estado (pendiente, pagado, cancelado, completado)  
- total  
- cancelacion_permitida_hasta (timestamp)  

### Línea de pedido (PK: id_linea_pedido)
- id_linea_pedido (PK)  
- id_pedido (FK → Pedido)  
- id_variante (FK → Variante)  
- cantidad  
- precio_unitario  
- estado_item (pendiente, reservado, enviado, entregado, devuelto)  

### Envío (Shipment) (PK: id_envio)
- id_envio (PK)  
- id_pedido (FK → Pedido)  
- fecha_creacion  
- fecha_envio  
- estado_envio (preparado, enviado, entregado, cancelado)  
- tracking_number  

### Pago (PK: id_pago)
- id_pago (PK)  
- id_pedido (FK → Pedido)  
- monto  
- fecha_pago  
- estado (pendiente, exitoso, fallido)  
- metodo_pago  

### Reembolso (PK: id_reembolso)
- id_reembolso (PK)  
- id_pago (FK → Pago)  
- monto  
- fecha_reembolso  
- motivo  

### Devolución (PK: id_devolucion)
- id_devolucion (PK)  
- id_linea_pedido (FK → Línea de pedido)  
- motivo  
- estado (pendiente, aprobada, rechazada, procesada)  
- nota_credito (booleano)  
- reembolso_asociado (opcional)  

### Promoción / Cupón (PK: id_promocion)
- id_promocion (PK)  
- codigo (único)  
- descripcion  
- tipo (porcentaje, monto fijo, envío gratis, etc.)  
- valor_descuento  
- fecha_inicio  
- fecha_fin  
- condiciones_minimas (texto/JSON)  

### Reseña (PK: id_resena)
- id_resena (PK)  
- id_cliente (FK → Cliente)  
- id_producto (FK → Producto)  
- calificacion (1–5)  
- comentario  
- fecha  

### Historial de precios (PK: id_historial_precio)
- id_historial_precio (PK)  
- id_variante (FK → Variante)  
- precio  
- fecha_inicio  
- fecha_fin (nullable)  

### Log de auditoría (PK: id_log)
- id_log (PK)  
- entidad (texto: Pedido, Inventario, etc.)  
- id_entidad (referencia al registro afectado)  
- accion (creación, actualización, eliminación)  
- usuario_responsable (FK → Usuario)  
- fecha  
- detalle (texto/JSON con cambios)  

---

## 5. Identificación de identificadores

### Usuario
- **PK:** id_usuario  

### Cliente
- **PK:** id_cliente  
- **FK:** id_usuario → Usuario  

### Vendedor
- **PK:** id_vendedor  
- **FK:** id_usuario → Usuario  

### Categoría
- **PK:** id_categoria  
- **FK:** parent_id → Categoría  

### Producto
- **PK:** id_producto  
- **FK:** id_vendedor → Vendedor  
- **FK:** id_categoria → Categoría  

### Variante
- **PK:** id_variante  
- **FK:** id_producto → Producto  

### Almacén
- **PK:** id_almacen  
- **FK:** id_vendedor → Vendedor  

### Inventario
- **PK:** id_inventario  
- **FK:** id_variante → Variante  
- **FK:** id_almacen → Almacén  

### Pedido
- **PK:** id_pedido  
- **FK:** id_cliente → Cliente  

### Línea de pedido
- **PK:** id_linea_pedido  
- **FK:** id_pedido → Pedido  
- **FK:** id_variante → Variante  

### Envío (Shipment)
- **PK:** id_envio  
- **FK:** id_pedido → Pedido  

### Pago
- **PK:** id_pago  
- **FK:** id_pedido → Pedido  

### Reembolso
- **PK:** id_reembolso  
- **FK:** id_pago → Pago  

### Devolución
- **PK:** id_devolucion  
- **FK:** id_linea_pedido → Línea de pedido  

### Promoción / Cupón
- **PK:** id_promocion  

### Reseña
- **PK:** id_resena  
- **FK:** id_cliente → Cliente  
- **FK:** id_producto → Producto  

### Historial de precios
- **PK:** id_historial_precio  
- **FK:** id_variante → Variante  

### Log de auditoría
- **PK:** id_log  
- **FK:** usuario_responsable → Usuario  

---

## 6. Jerarquías

Usuario
├─ Cliente
└─ Vendedor

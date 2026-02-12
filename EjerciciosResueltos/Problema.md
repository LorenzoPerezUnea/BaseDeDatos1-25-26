#  Marketplace + Gestión de Logística (modelo alternativo)





## Entidades y Campos principales

**USUARIO**  
- usuario_id (PK)  
- nombre_completo  
- correo  
- telefono  

**COMPRADOR** (subtipo de Usuario)  
- comprador_id (PK, FK → Usuario)  
- fecha_alta  
- nivel_membresia  

**COMERCIANTE** (subtipo de Usuario)  
- comerciante_id (PK, FK → Usuario)  
- reputacion  
- fecha_registro  

**CATEGORIA**  
- categoria_id (PK)  
- nombre  
- categoria_padre_id (FK, nullable)  

**ARTICULO**  
- articulo_id (PK)  
- comerciante_id (FK)  
- titulo  
- descripcion  
- categoria_id (FK)  

**VARIANTE**  
- variante_id (PK)  
- articulo_id (FK)  
- talla  
- color  
- codigo_sku  

**DEPOSITO**  
- deposito_id (PK)  
- comerciante_id (FK)  
- nombre  
- ubicacion  

**STOCK**  
- stock_id (PK)  
- deposito_id (FK)  
- variante_id (FK)  
- disponible  
- reservado  

**ORDEN**  
- orden_id (PK)  
- comprador_id (FK)  
- fecha_creacion  
- estado  

**DETALLE_ORDEN**  
- detalle_id (PK)  
- orden_id (FK)  
- variante_id (FK)  
- cantidad  
- precio_unitario  

**DESPACHO**  
- despacho_id (PK)  
- orden_id (FK)  
- estado_envio  
- fecha_despacho  

**TRANSACCION**  
- transaccion_id (PK)  
- orden_id (FK)  
- monto  
- medio_pago  
- estado  

**REEMBOLSO**  
- reembolso_id (PK)  
- transaccion_id (FK)  
- monto_reintegrado  
- causa  

**DEVOLUCION**  
- devolucion_id (PK)  
- detalle_id (FK)  
- razon  
- estado  

**DESCUENTO**  
- descuento_id (PK)  
- nombre  
- alcance (por_articulo / por_categoria / por_orden)  
- porcentaje  
- fecha_inicio  
- fecha_fin  

**OPINION**  
- opinion_id (PK)  
- comprador_id (FK)  
- articulo_id (FK)  
- puntuacion  
- comentario  

**HISTORICO_PRECIO**  
- historico_id (PK)  
- variante_id (FK)  
- precio  
- fecha_inicio  
- fecha_fin  

**BITACORA**  
- log_id (PK)  
- entidad  
- id_referencia  
- usuario_actor  
- fecha  
- descripcion  

---

## Relaciones y Cardinalidades

- **Usuario ↔ Comprador / Comerciante**: un usuario puede ser comprador y/o comerciante (1:1 opcional en ambos casos).  
- **Comerciante ↔ Artículo**: un comerciante publica múltiples artículos (1:N).  
- **Artículo ↔ Variante**: un artículo se ofrece en distintas variantes (1:N).  
- **Artículo ↔ Categoría**: cada artículo pertenece a una categoría (N:1).  
- **Categoría ↔ Subcategoría**: categorías anidadas en jerarquía (1:N).  
- **Variante ↔ Stock**: cada variante puede tener múltiples registros de stock (1:N).  
- **Depósito ↔ Stock**: un depósito administra existencias de varias variantes (1:N).  
- **Comerciante ↔ Depósito**: un comerciante gestiona uno o varios depósitos (1:N).  
- **Comprador ↔ Orden**: un comprador puede generar varias órdenes (1:N).  
- **Orden ↔ DetalleOrden**: una orden se compone de uno o más detalles (1:N).  
- **Variante ↔ DetalleOrden**: una variante puede aparecer en distintos detalles de orden (1:N).  
- **Orden ↔ Despacho**: una orden puede originar varios despachos (1:N).  
- **Orden ↔ Transacción**: varias transacciones pueden asociarse a la misma orden (1:N).  
- **Transacción ↔ Reembolso**: una transacción puede generar múltiples reembolsos (1:N).  
- **DetalleOrden ↔ Devolución**: un detalle de orden puede asociarse a varias devoluciones (1:N).  
- **Descuento ↔ Artículo**: relación muchos a muchos (M:N).  
- **Comprador ↔ Opinión**: un comprador puede publicar varias opiniones (1:N).  
- **Artículo ↔ Opinión**: un artículo recibe muchas opiniones (1:N).  
- **Variante ↔ HistóricoPrecio**: cada variante mantiene registro de cambios de precio (1:N).  



# Modelo Conceptual – Marketplace + Logística 

## Paso 1 – Identificación de Entidades
- **Usuario** (superclase)  
- **Comprador** (subclase de Usuario)  
- **Comerciante** (subclase de Usuario)  
- **Artículo**  
- **VarianteArtículo**  
- **Categoría** (jerárquica)  
- **Depósito**  
- **OrdenCompra**  
- **DetalleOrden**  
- **Despacho**  
- **TransacciónPago**  
- **MedioPago**  
- **Reclamación**  
- **Descuento/Oferta**  
- **OpiniónArtículo**  
- **ReputaciónComerciante**  
- **RegistroPrecios**  
- **BitácoraAuditoría**  

---

## Paso 2 – Relaciones y Verbos
- **Usuario —< es subtipo de >— Comprador/Comerciante**  
- **Comerciante —< publica >— Artículo (1:N)**  
- **Artículo —< presenta >— VarianteArtículo (1:N)**  
- **Artículo —< clasificado en >— Categoría (N:1)**  
- **Categoría —< se subdivide en >— Categoría (1:N)**  
- **VarianteArtículo —< almacenado en >— Depósito (N:M, atributo: stock_disponible)**  
- **OrdenCompra —< realizada por >— Comprador (N:1)**  
- **OrdenCompra —< incluye >— DetalleOrden (1:N)**  
- **DetalleOrden —< hace referencia a >— VarianteArtículo (N:1)**  
- **OrdenCompra —< origina >— Despacho (1:N)**  
- **Despacho —< contiene >— DetalleOrden (N:M)**  
- **OrdenCompra —< liquidada con >— TransacciónPago (1:N)**  
- **TransacciónPago —< utiliza >— MedioPago (N:1)**  
- **DetalleOrden —< puede originar >— Reclamación (1:N)**  
- **Descuento —< aplicable a >— Artículo/Categoría/Comerciante/OrdenCompra (N:M)**  
- **Comprador —< redacta >— OpiniónArtículo (1:N)**  
- **OpiniónArtículo —< corresponde a >— Artículo (N:1)**  
- **ReputaciónComerciante —< vinculada a >— Comerciante (1:1)**  
- **VarianteArtículo —< registra >— RegistroPrecios (1:N)**  
- **BitácoraAuditoría —< documenta >— OrdenCompra/VarianteArtículo/Usuario (N:M)**  

---

## Paso 3 – Atributos (Nivel Conceptual)
- **Usuario**: id_usuario, nombre, correo, clave_acceso, rol  
- **Comprador**: id_comprador, direccion_envio, preferencias_compra  
- **Comerciante**: id_comerciante, nombre_comercial, identificacion_fiscal  
- **Artículo**: id_articulo, titulo, descripcion, marca, fecha_publicacion  
- **VarianteArtículo**: id_variante, atributos (ej. talla, color), codigo_sku, precio_actual  
- **Categoría**: id_categoria, nombre, detalle  
- **Depósito**: id_deposito, nombre, ubicacion, capacidad  
- **OrdenCompra**: id_orden, fecha_creacion, estado, importe_total, region  
- **DetalleOrden**: id_detalle, cantidad, precio_unitario  
- **Despacho**: id_despacho, fecha_salida, estado_despacho, guia_tracking  
- **TransacciónPago**: id_pago, monto, estado, fecha_pago, referencia  
- **MedioPago**: id_medio, tipo, proveedor  
- **Reclamación**: id_reclamo, fecha, causa, estado, nota_credito  
- **Descuento**: id_descuento, tipo, condiciones, inicio, fin, porcentaje  
- **OpiniónArtículo**: id_opinion, comentario, puntuacion, fecha  
- **ReputaciónComerciante**: id_reputacion, indice, observaciones  
- **RegistroPrecios**: id_registro, fecha_inicio, fecha_fin, valor  
- **BitácoraAuditoría**: id_bitacora, actor, accion, entidad_afectada, fecha, detalle  

---

## Paso 4 – Identificadores
- Usuario: id_usuario  
- Comprador: id_comprador  
- Comerciante: id_comerciante  
- Artículo: id_articulo  
- VarianteArtículo: id_variante  
- Categoría: id_categoria  
- Depósito: id_deposito  
- OrdenCompra: id_orden  
- DetalleOrden: id_detalle  
- Despacho: id_despacho  
- TransacciónPago: id_pago  
- MedioPago: id_medio  
- Reclamación: id_reclamo  
- Descuento: id_descuento  
- OpiniónArtículo: id_opinion  
- ReputaciónComerciante: id_reputacion  
- RegistroPrecios: id_registro  
- BitácoraAuditoría: id_bitacora  

---

## Paso 5 – Jerarquías de Generalización
```text
Usuario
├── Comprador
└── Comerciante
```

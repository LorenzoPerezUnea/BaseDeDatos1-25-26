# Ejercicio 2: Marketplace + Logística

## 1. Lista predefinida de requisitos

1. La plataforma permite que vendedores publiquen productos y clientes realicen compras.  
2. Un usuario puede actuar como cliente, vendedor o ambos.  
3. Los productos tienen variantes (ej. talla, color) y pertenecen a categorías jerárquicas.  
4. Cada producto/variante mantiene inventario en uno o varios almacenes.  
5. Los vendedores pueden operar múltiples almacenes o usar stock de proveedores (dropshipping).  
6. Los clientes generan pedidos que contienen múltiples líneas de pedido.  
7. Los pedidos pueden dividirse en varios envíos, cada uno con estado de seguimiento.  
8. El sistema gestiona pagos, reintentos, reembolsos parciales y métodos de pago.  
9. Se gestionan devoluciones por línea de pedido, con motivo, estado y nota de crédito o reembolso.  
10. Existen promociones y cupones aplicables a productos, categorías, vendedores o pedidos.  
11. Los clientes pueden dejar reseñas y valoraciones de productos y reputación de vendedores.  
12. Se mantiene historial de precios para variantes de producto.  
13. Reglas de negocio: reserva de stock al crear pedido, cancelación en ventana definida, bloqueo de envío por falta de stock, límites de compra por cliente.  
14. Registro de logs de auditoría sobre pedidos y movimientos de stock críticos.  
15. Se generan reportes de ventas, productos sin stock y pedidos pendientes.  

---

## 2. Identificación de Entidades

* **USUARIO**: persona registrada en la plataforma.  
* **CLIENTE**: subtipo de usuario que compra productos.  
* **VENDEDOR**: subtipo de usuario que ofrece productos.  
* **PRODUCTO**: artículo en venta dentro del marketplace.  
* **VARIANTE**: versión específica del producto (ej. talla/color).  
* **CATEGORIA**: clasificación jerárquica de productos.  
* **ALMACEN**: depósito físico o virtual donde se guarda stock.  
* **INVENTARIO**: cantidad de una variante en un almacén.  
* **PEDIDO**: solicitud de compra creada por un cliente.  
* **LINEA DE PEDIDO**: item dentro de un pedido que referencia a una variante.  
* **ENVÍO (SHIPMENT)**: agrupación de ítems de un pedido con estado de envío.  
* **PAGO**: registro de transacción monetaria.  
* **METODO DE PAGO**: forma utilizada para procesar el pago.  
* **DEVOLUCIÓN**: proceso de retorno de productos.  
* **PROMOCIÓN/CUPÓN**: descuento o beneficio aplicado.  
* **RESEÑA**: comentario y valoración de un producto.  
* **HISTORIAL DE PRECIOS**: cambios de precio en variantes.  
* **LOG DE AUDITORÍA**: registro de acciones críticas.  
* **REPORTE**: informe generado a partir de la actividad de la plataforma.  

---

## 3. Identificación de Relaciones

* **Usuario — Cliente/Vendedor**  
  * `Usuario (1) — se especializa en — (0..1) Cliente`  
  * `Usuario (1) — se especializa en — (0..1) Vendedor`  
  * Generalización: Cliente y Vendedor son subtipos de Usuario.  

* **Vendedor — Producto**  
  * `Vendedor (1) — ofrece — (0..N) Producto`  
  * `Producto — pertenece a — Vendedor`  

* **Producto — Variante**  
  * `Producto (1) — tiene — (0..N) Variante`  
  * `Variante — corresponde a — Producto`  

* **Variante — Categoria**  
  * `Variante (0..N) — pertenece a — (1) Categoria`  
  * `Categoria — agrupa — Variante`  

* **Variante — Inventario — Almacén**  
  * `Variante (1) — está en — (0..N) Inventario`  
  * `Almacén (1) — mantiene — (0..N) Inventario`  

* **Cliente — Pedido**  
  * `Cliente (1) — crea — (0..N) Pedido`  

* **Pedido — Línea de pedido — Variante**  
  * `Pedido (1) — contiene — (1..N) Línea de pedido`  
  * `Línea de pedido — corresponde a — Variante (1)`  

* **Pedido — Envío**  
  * `Pedido (1) — se divide en — (0..N) Envíos`  
  * `Envío (1) — incluye — (1..N) Líneas de pedido`  

* **Pedido — Pago — Método de pago**  
  * `Pedido (1) — genera — (1..N) Pago`  
  * `Pago (1) — utiliza — (1) Método de pago`  

* **Pedido/Línea — Devolución**  
  * `Línea de pedido (0..N) — puede tener — (0..N) Devoluciones`  

* **Promoción — Producto/Categoria/Vendedor/Pedido**  
  * Una promoción se asocia a distintos elementos (relación N:M según contexto).  

* **Cliente — Reseña — Producto/Vendedor**  
  * `Cliente (1) — escribe — (0..N) Reseña`  
  * `Reseña — es sobre — Producto/Vendedor (1)`  

* **Variante — Historial de precios**  
  * `Variante (1) — tiene — (0..N) Historial de precios`  

* **Usuario — Log de auditoría — Pedido/Inventario**  
  * `Usuario (1) — genera — (0..N) Logs de auditoría`  

---

## 4. Identificación de Atributos

1. **Usuario** (`id_usuario`, `nombre`, `email`, `password_hash`, `fecha_registro`, `rol`)  
2. **Cliente** (`id_cliente`, `id_usuario`, `direccion_envio`, `telefono`)  
3. **Vendedor** (`id_vendedor`, `id_usuario`, `nombre_tienda`, `reputacion`, `pais`)  
4. **Producto** (`id_producto`, `id_vendedor`, `nombre`, `descripcion`, `estado`, `fecha_creacion`)  
5. **Variante** (`id_variante`, `id_producto`, `atributos` (JSON: talla, color), `precio_actual`, `sku`)  
6. **Categoria** (`id_categoria`, `nombre`, `descripcion`, `id_categoria_padre`)  
7. **Almacén** (`id_almacen`, `id_vendedor`, `nombre`, `direccion`, `tipo`)  
8. **Inventario** (`id_inventario`, `id_variante`, `id_almacen`, `cantidad_disponible`, `reservada`)  
9. **Pedido** (`id_pedido`, `id_cliente`, `fecha`, `estado`, `total`)  
10. **Línea de pedido** (`id_linea`, `id_pedido`, `id_variante`, `cantidad`, `precio_unitario`)  
11. **Envío** (`id_envio`, `id_pedido`, `estado_envio`, `fecha_envio`, `transportista`)  
12. **Pago** (`id_pago`, `id_pedido`, `monto`, `estado`, `fecha`, `intentos`)  
13. **Método de pago** (`id_metodo`, `nombre`, `proveedor`, `tipo`)  
14. **Devolución** (`id_devolucion`, `id_linea`, `motivo`, `estado`, `monto_reembolso`)  
15. **Promoción** (`id_promocion`, `nombre`, `descripcion`, `tipo`, `descuento`, `fecha_inicio`, `fecha_fin`, `condiciones`)  
16. **Reseña** (`id_resena`, `id_cliente`, `id_producto/id_vendedor`, `contenido`, `calificacion`, `fecha`)  
17. **Historial de precios** (`id_historial`, `id_variante`, `precio`, `fecha`)  
18. **Log de auditoría** (`id_log`, `id_usuario`, `accion`, `entidad`, `id_entidad`, `fecha`)  
19. **Reporte** (`id_reporte`, `tipo`, `parametros`, `fecha_generacion`, `contenido`)  

---

## 5. Jerarquías / Generalizaciones

* **USUARIO** (general) → **CLIENTE** y **VENDEDOR** (subtipos).  
* **PRODUCTO** → **VARIANTE** (especialización según atributos).  
* **CATEGORIA** → se organiza jerárquicamente (categoría → subcategoría → …).  
* **PAGO** → puede ser **REEMBOLSO** (subtipo especializado).  
* **ALMACÉN** → puede ser **físico** o **dropshipping/proveedor externo**.  

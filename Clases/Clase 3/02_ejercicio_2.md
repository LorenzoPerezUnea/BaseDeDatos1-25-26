## Marketplace + Logística (ventas, proveedores, stock, envíos, devoluciones, promociones)

1. La plataforma es un **marketplace** donde **Vendedores** ponen a la venta **Productos** y **Clientes** compran.
2. Un **Usuario** puede ser ​**Cliente**​, **Vendedor** o ambos (modelo con subtipos).
3. Los **Productos** tienen **variantes** (p. ej. talla, color) y pertenecen a una **Categoría** jerárquica (categoría → subcategoría → …).
4. Cada **Producto/Variante** mantiene **inventario** por **Almacén** (multi-warehouse).
5. Los **Vendedores** pueden tener **múltiples almacenes** u ofrecer “dropshipping” (stock en proveedor).
6. Un **Pedido** es creado por un Cliente y puede contener múltiples **Líneas de pedido (order items)** (cada item apunta a una variante de producto).
7. Un **Pedido** puede dividirse en ​**varios envíos (Shipments)**​; un envío agrupa uno o varios items y tiene ​**estado de envío**​.
8. El sistema registra **Pagos** (posibles múltiples intentos, reembolsos parciales) y ​**Método de pago**​.
9. Existencia de ​**Devoluciones**​: se registra devolución por línea, motivo, estado y posible **nota de crédito** o reembolso.
10. **Promociones / Cupones** aplicables por producto, categoría, vendedor o pedido (fechas de validez, condiciones mínimas).
11. **Reseñas** y **Valoraciones** de producto por clientes, y ​**reputación de vendedor**​.
12. **Historial de precios** (price history) para cada variante — interesa para auditoría y análisis.
13. **Reglas de negocio** importantes: reserva de stock cuando se crea pedido; cancelación en ventana X minutos; bloqueo de envío si stock insuficiente; máximos de compra por cliente por producto (ej.: 5 unidades).
14. Registro de ​**logs de auditoría**​: quién creó/actualizó pedidos, cambios de stock críticos.
15. **Reportes** frecuentes: ventas por día/region/vendedor, productos sin stock, pedidos pendientes de pago.

## 1. Lista Predefinida de Requisitos

1. La plataforma es un **marketplace** donde **Vendedores** ponen a la venta **Productos** y **Clientes** compran.  
2. Un **Usuario** puede ser **Cliente**, **Vendedor** o ambos (modelo con subtipos).  
3. Los **Productos** tienen **Variantes** (ej. talla, color) y pertenecen a una **Categoría** jerárquica.  
4. Cada **Variante** mantiene **Inventario** por **Almacén** (multi-warehouse).  
5. Los **Vendedores** pueden tener múltiples **Almacenes** u ofrecer **dropshipping**.  
6. Un **Pedido** es creado por un Cliente y puede contener múltiples **Líneas de pedido**.  
7. Un **Pedido** puede dividirse en varios **Envíos**, que agrupan items y tienen **estado**.  
8. El sistema registra **Pagos** (múltiples intentos posibles) y **Reembolsos** parciales, asociados a un **Método de Pago**.  
9. Existen **Devoluciones** por línea, con motivo, estado y posible **nota de crédito**.  
10. Hay **Promociones / Cupones** aplicables a productos, categorías, vendedores o pedidos.  
11. Los clientes dejan **Reseñas** de productos y contribuyen a la **reputación del vendedor**.  
12. Se registra un **Historial de Precios** de cada variante.  
13. Reglas de negocio: reserva de stock al crear pedido, cancelación en ventana, bloqueo de envío sin stock, máximos de compra por cliente/producto.  
14. **Logs de Auditoría** registran cambios críticos en pedidos y stock.  
15. Se generan **Reportes**: ventas por día/región/vendedor, productos sin stock, pedidos pendientes de pago.  

---

## 2. Identificación de Entidades

- **Usuario**  
- **Cliente**  
- **Vendedor**  
- **Categoría**  
- **Producto**  
- **Variante**  
- **Almacén**  
- **Inventario**  
- **Pedido**  
- **LíneaPedido**  
- **Envío**  
- **ItemEnvío**  
- **MétodoPago**  
- **Pago**  
- **Reembolso**  
- **Devolución**  
- **ItemDevolución**  
- **NotaCrédito**  
- **Promoción**  
- **Cupón**  
- **ReseñaProducto**  
- **ReputaciónVendedor**  
- **HistorialPrecio**  
- **LogAuditoría**  

---

## 3. Identificación de Relaciones y Cardinalidades

- Un **Usuario (1)** puede ser **Cliente (0..1)** o **Vendedor (0..1)**.  
- Una **Categoría (1)** puede tener **(0..N) Subcategorías**.  
- Un **Vendedor (1)** publica **(0..N) Productos**.  
- Una **Categoría (1)** clasifica **(0..N) Productos**.  
- Un **Producto (1)** tiene **(1..N) Variantes**.  
- Un **Vendedor (1)** gestiona **(0..N) Almacenes**.  
- Una **Variante (N)** se almacena en **(N) Almacenes** → relación **N:M** (Inventario).  
- Un **Cliente (1)** realiza **(0..N) Pedidos**.  
- Un **Pedido (1)** contiene **(1..N) Líneas de Pedido**.  
- Una **Variante (1)** aparece en **(0..N) Líneas de Pedido**.  
- Un **Pedido (1)** se divide en **(1..N) Envíos**.  
- Un **Envío (1)** contiene **(1..N) Items de Envío**, cada uno asociado a una línea.  
- Un **Pedido (1)** registra **(0..N) Pagos**.  
- Un **Pago (1)** puede tener **(0..N) Reembolsos**.  
- Un **Pedido (1)** puede tener **(0..N) Devoluciones**.  
- Una **Devolución (1)** contiene **(1..N) Items** y puede generar **(0..1) Nota de Crédito**.  
- Una **Promoción (1)** afecta a **(0..N) Productos, Categorías o Vendedores**.  
- Un **Cupón (1)** puede estar ligado a una **Promoción (1)**.  
- Un **Cliente (1)** escribe **(0..N) ReseñasProducto**.  
- Un **Producto (1)** recibe **(0..N) ReseñasProducto**.  
- Un **Cliente (1)** valora a un **Vendedor (0..N)** → **ReputaciónVendedor**.  
- Una **Variante (1)** tiene **(0..N) HistorialPrecio**.  
- Un **Usuario (1)** genera **(0..N) LogsAuditoría**.  

---

## 4. Identificación de Atributos

**Usuario**  
- nombre  
- email  
- password  
- rol  

**Cliente**  
- preferencias  
- historial_compra  

**Vendedor**  
- nombre_tienda  
- reputación  

**Categoría**  
- nombre  
- descripción  

**Producto**  
- nombre  
- descripción  
- precio_base  

**Variante**  
- sku  
- atributos (talla, color)  
- precio_final  

**Almacén**  
- ubicación  
- capacidad  

**Inventario**  
- cantidad  
- stock_mínimo  

**Pedido**  
- fecha  
- estado  
- total  

**LíneaPedido**  
- cantidad  
- precio_unitario  
- subtotal  

**Envío**  
- fecha_envío  
- estado  
- transportista  

**ItemEnvío**  
- cantidad  

**MétodoPago**  
- nombre  
- descripción  

**Pago**  
- fecha_pago  
- importe  
- referencia  

**Reembolso**  
- monto  
- motivo  
- fecha  
- estado  

**Devolución**  
- fecha  
- motivo  
- estado  

**ItemDevolución**  
- cantidad  

**NotaCrédito**  
- monto  
- fecha  
- estado  

**Promoción**  
- tipo  
- valor  
- fecha_inicio  
- fecha_fin  

**Cupón**  
- código  
- fecha_expiración  
- usos_restantes  

**ReseñaProducto**  
- calificación  
- comentario  
- fecha  

**ReputaciónVendedor**  
- puntuación  
- comentario  
- fecha  

**HistorialPrecio**  
- fecha  
- precio  

**LogAuditoría**  
- entidad_tipo  
- entidad_id  
- acción  
- usuario  
- fecha  

---

## 5. Jerarquías / Generalizaciones

- `Usuario` se especializa en `Cliente` o `Vendedor`.  
- `Categoría` admite jerarquía (categoría padre e hijas).  
- `Producto` se especializa en `Variante`.  
- `Promoción` puede ser de tipo porcentaje, monto fijo o envío gratis.  

---

## 6. Diagrama de Chen en Mermaid

```mermaid
erDiagram
    USUARIO ||--o| CLIENTE : "es"
    USUARIO ||--o| VENDEDOR : "es"
    CATEGORIA ||--o{ PRODUCTO : "clasifica"
    CATEGORIA ||--o{ CATEGORIA : "subcategoria"
    VENDEDOR ||--o{ PRODUCTO : "publica"
    PRODUCTO ||--o{ VARIANTE : "tiene"
    VENDEDOR ||--o{ ALMACEN : "gestiona"
    VARIANTE }o--o{ ALMACEN : "se almacena"
    CLIENTE ||--o{ PEDIDO : "realiza"
    PEDIDO ||--o{ LINEA_PEDIDO : "contiene"
    VARIANTE ||--o{ LINEA_PEDIDO : "aparece"
    PEDIDO ||--o{ ENVIO : "se divide"
    ENVIO ||--o{ ITEM_ENVIO : "contiene"
    LINEA_PEDIDO ||--o{ ITEM_ENVIO : "incluye"
    PEDIDO ||--o{ PAGO : "registra"
    PAGO ||--o{ REEMBOLSO : "genera"
    PEDIDO ||--o{ DEVOLUCION : "puede tener"
    DEVOLUCION ||--o{ ITEM_DEVOLUCION : "contiene"
    DEVOLUCION ||--o| NOTA_CREDITO : "genera"
    PROMOCION }o--o{ PRODUCTO : "afecta"
    PROMOCION }o--o{ CATEGORIA : "afecta"
    PROMOCION }o--o{ VENDEDOR : "afecta"
    PROMOCION ||--o{ CUPON : "genera"
    CLIENTE ||--o{ RESENA_PRODUCTO : "escribe"
    PRODUCTO ||--o{ RESENA_PRODUCTO : "recibe"
    CLIENTE ||--o{ REPUTACION_VENDEDOR : "valora"
    VENDEDOR ||--o{ REPUTACION_VENDEDOR : "recibe"
    VARIANTE ||--o{ HISTORIAL_PRECIO : "registra"
    USUARIO ||--o{ LOG_AUDITORIA : "genera"
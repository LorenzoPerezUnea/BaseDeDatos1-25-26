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

## Paso 1 – Identificación de Entidades

* **USUARIO**: actor del sistema (base).  
* **CLIENTE**: subtipo de usuario comprador.  
* **VENDEDOR**: subtipo de usuario que ofrece productos.  
* **PRODUCTO**: artículo publicado.  
* **VARIANTE**: versión específica de un producto (talla, color).  
* **CATEGORIA**: jerarquía de clasificación de productos.  
* **ALMACEN**: ubicación física (propio o dropshipping).  
* **INVENTARIO**: registro de stock por variante y almacén.  
* **PEDIDO**: orden creada por un cliente.  
* **LINEA_PEDIDO (OrderItem)**: item dentro de un pedido.  
* **ENVÍO (Shipment)**: agrupación de líneas con estado.  
* **PAGO**: registro de pago de pedido.  
* **METODO_PAGO**: forma de pago (tarjeta, PayPal, etc.).  
* **DEVOLUCION**: devolución de una línea de pedido.  
* **PROMOCION / CUPON**: descuentos aplicables.  
* **RESEÑA**: valoración de producto por cliente.  
* **REPUTACION_VENDEDOR**: puntuación agregada.  
* **PRECIO_HISTORICO**: historial de precios por variante.  
* **LOG_AUDITORIA**: registro de cambios y operaciones críticas.  


---

## Paso 2 – Relaciones y Verbos

* **Usuario — Cliente/Vendedor**  
  * `Usuario (1) — especializa — (0..1) Cliente`  
  * `Usuario (1) — especializa — (0..1) Vendedor`  
  * Permite que un usuario sea ambos.  

* **Vendedor — Producto**  
  * `Vendedor (1) — publica — (0..N) Producto`  
  * Cardinalidad: 1:N  

* **Producto — Variante**  
  * `Producto (1) — tiene — (1..N) Variante`  
  * Cardinalidad: 1:N  

* **Producto/Variante — Categoria**  
  * `Variante (N) — pertenece a — (1) Categoria`  
  * `Categoria (1) — puede tener — (0..N) Subcategorias`  
  * Jerarquía recursiva N:1  

* **Variante — Inventario — Almacén**  
  * `Variante (N) — registrado en — (N) Almacén`  
  * Relación N:M materializada como **Inventario** (con stock, reservado).  

* **Cliente — Pedido**  
  * `Cliente (1) — crea — (0..N) Pedido`  
  * Cardinalidad: 1:N  

* **Pedido — Línea de pedido**  
  * `Pedido (1) — contiene — (1..N) LineaPedido`  
  * Cardinalidad: 1:N  

* **LineaPedido — Variante**  
  * `LineaPedido (N) — corresponde a — (1) Variante`  
  * Cardinalidad: N:1  

* **Pedido — Envío**  
  * `Pedido (1) — se divide en — (1..N) Envío`  
  * Cardinalidad: 1:N  

* **Envío — LíneaPedido**  
  * `Envío (1) — agrupa — (1..N) LineaPedido`  
  * Cardinalidad: N:M (un ítem puede ir en un envío, requiere tabla intermedia `Envio_Item`)  

* **Pedido — Pago**  
  * `Pedido (1) — asociado a — (0..N) Pago`  
  * Cardinalidad: 1:N  

* **Pago — MetodoPago**  
  * `Pago (N) — utiliza — (1) MetodoPago`  
  * Cardinalidad: N:1  

* **LineaPedido — Devolucion**  
  * `LineaPedido (1) — puede generar — (0..1) Devolucion`  
  * Cardinalidad: 1:0..1  

* **Promocion — Producto / Categoria / Vendedor / Pedido**  
  * Relaciones N:M:  
    * `Promocion (N) — aplica a — (N) Producto`  
    * `Promocion (N) — aplica a — (N) Categoria`  
    * `Promocion (N) — aplica a — (N) Vendedor`  
    * `Promocion (N) — aplica a — (N) Pedido`  

* **Cliente — Reseña — Producto**  
  * `Cliente (1) — escribe — (0..N) Reseña`  
  * `Reseña — sobre — (1) Producto`  

* **Vendedor — Reputacion**  
  * `Vendedor (1) — tiene — (0..1) Reputacion`  

* **Variante — PrecioHistorico**  
  * `Variante (1) — registra — (0..N) PrecioHistorico`  

* **LogAuditoria**  
  * Se relaciona con cualquier operación crítica (ej. cambios en pedidos, stock). 

---

## Paso 4 – Identificadores

### Usuario
* id_usuario (PK)  
* nombre  
* email  
* password_hash  
* fecha_registro  

### Cliente
* id_cliente (PK, FK a Usuario)  
* direccion_envio  
* telefono  

### Vendedor
* id_vendedor (PK, FK a Usuario)  
* nombre_tienda  
* reputacion (opcional, redundante si hay tabla agregada)  

### Producto
* id_producto (PK)  
* id_vendedor (FK)  
* nombre  
* descripcion  
* estado (activo/inactivo)  

### Variante
* id_variante (PK)  
* id_producto (FK)  
* atributos (JSON: talla, color, etc.)  
* precio_actual  

### Categoria
* id_categoria (PK)  
* nombre  
* descripcion  
* id_categoria_padre (FK, recursiva)  

### Almacen
* id_almacen (PK)  
* id_vendedor (FK, opcional si es proveedor externo)  
* direccion  
* tipo (propio / dropshipping)  

### Inventario
* id_inventario (PK)  
* id_variante (FK)  
* id_almacen (FK)  
* stock_actual  
* stock_reservado  

### Pedido
* id_pedido (PK)  
* id_cliente (FK)  
* fecha_creacion  
* estado (pendiente, pagado, cancelado, enviado)  
* total  

### LineaPedido
* id_linea (PK)  
* id_pedido (FK)  
* id_variante (FK)  
* cantidad  
* precio_unitario  

### Envio (Shipment)
* id_envio (PK)  
* id_pedido (FK)  
* fecha_envio  
* estado (pendiente, en tránsito, entregado)  

### Pago
* id_pago (PK)  
* id_pedido (FK)  
* id_metodo_pago (FK)  
* monto  
* estado (exitoso, fallido, reembolsado)  
* fecha  

### MetodoPago
* id_metodo (PK)  
* nombre  

### Devolucion
* id_devolucion (PK)  
* id_linea (FK)  
* motivo  
* estado  
* monto_reembolsado  

### Promocion
* id_promo (PK)  
* codigo  
* descripcion  
* tipo (porcentaje, monto fijo)  
* valor  
* fecha_inicio  
* fecha_fin  
* condiciones  

### Reseña
* id_resena (PK)  
* id_cliente (FK)  
* id_producto (FK)  
* calificacion (1–5)  
* comentario  
* fecha  

### PrecioHistorico
* id_precio (PK)  
* id_variante (FK)  
* precio  
* fecha_inicio  
* fecha_fin  

### LogAuditoria
* id_log (PK)  
* id_usuario (FK)  
* accion  
* entidad_afectada  
* fecha_hora  

---

## Paso 5 – Jerarquías de Generalización

* **USUARIO → CLIENTE / VENDEDOR** (subtipos, un usuario puede ser ambos)  
* **PRODUCTO → VARIANTE** (especialización en atributos, talla/color)  
* **CATEGORIA → subcategoría** (jerarquía recursiva)  
* **PEDIDO → ENVÍOS / PAGOS / DEVOLUCIONES** (estructura compuesta)
---



```mermaid
erDiagram
    USUARIO {
        int id_usuario PK
        string nombre
        string email
        string password_hash
        date fecha_registro
    }
    CLIENTE {
        int id_cliente PK, FK
        string direccion_envio
        string telefono
    }
    VENDEDOR {
        int id_vendedor PK, FK
        string nombre_tienda
        float reputacion
    }
    PRODUCTO {
        int id_producto PK
        int id_vendedor FK
        string nombre
        string descripcion
        string estado
    }
    VARIANTE {
        int id_variante PK
        int id_producto FK
        json atributos
        float precio_actual
    }
    CATEGORIA {
        int id_categoria PK
        string nombre
        string descripcion
        int id_categoria_padre FK
    }
    ALMACEN {
        int id_almacen PK
        int id_vendedor FK
        string direccion
        string tipo
    }
    INVENTARIO {
        int id_inventario PK
        int id_variante FK
        int id_almacen FK
        int stock_actual
        int stock_reservado
    }
    PEDIDO {
        int id_pedido PK
        int id_cliente FK
        date fecha_creacion
        string estado
        float total
    }
    LINEA_PEDIDO {
        int id_linea PK
        int id_pedido FK
        int id_variante FK
        int cantidad
        float precio_unitario
    }
    ENVIO {
        int id_envio PK
        int id_pedido FK
        date fecha_envio
        string estado
    }
    ENVIO_ITEM {
        int id_envio FK
        int id_linea FK
    }
    PAGO {
        int id_pago PK
        int id_pedido FK
        int id_metodo_pago FK
        float monto
        string estado
        date fecha
    }
    METODO_PAGO {
        int id_metodo PK
        string nombre
    }
    DEVOLUCION {
        int id_devolucion PK
        int id_linea FK
        string motivo
        string estado
        float monto_reembolsado
    }
    PROMOCION {
        int id_promo PK
        string codigo
        string descripcion
        string tipo
        float valor
        date fecha_inicio
        date fecha_fin
        string condiciones
    }
    RESENA {
        int id_resena PK
        int id_cliente FK
        int id_producto FK
        int calificacion
        string comentario
        date fecha
    }
    REPUTACION_VENDEDOR {
        int id_vendedor PK, FK
        float puntuacion
    }
    PRECIO_HISTORICO {
        int id_precio PK
        int id_variante FK
        float precio
        date fecha_inicio
        date fecha_fin
    }
    LOG_AUDITORIA {
        int id_log PK
        int id_usuario FK
        string accion
        string entidad_afectada
        datetime fecha_hora
    }

    %% Jerarquías
    USUARIO ||--o| CLIENTE : "es"
    USUARIO ||--o| VENDEDOR : "es"

    %% Relaciones principales
    VENDEDOR ||--o{ PRODUCTO : "publica"
    PRODUCTO ||--|{ VARIANTE : "tiene"
    VARIANTE }o--|| CATEGORIA : "pertenece a"
    CATEGORIA ||--o{ CATEGORIA : "subcategoria"

    VARIANTE ||--o{ INVENTARIO : "registrado en"
    ALMACEN ||--o{ INVENTARIO : "contiene"
    VENDEDOR ||--o{ ALMACEN : "administra"

    CLIENTE ||--o{ PEDIDO : "crea"
    PEDIDO ||--|{ LINEA_PEDIDO : "contiene"
    LINEA_PEDIDO }o--|| VARIANTE : "corresponde a"

    PEDIDO ||--o{ ENVIO : "se divide en"
    ENVIO ||--o{ ENVIO_ITEM : "agrupa"
    LINEA_PEDIDO ||--o{ ENVIO_ITEM : "incluido en"

    PEDIDO ||--o{ PAGO : "asociado a"
    PAGO }o--|| METODO_PAGO : "usa"

    LINEA_PEDIDO ||--o| DEVOLUCION : "puede generar"

    PROMOCION }o--o{ PRODUCTO : "aplica"
    PROMOCION }o--o{ CATEGORIA : "aplica"
    PROMOCION }o--o{ VENDEDOR : "aplica"
    PROMOCION }o--o{ PEDIDO : "aplica"

    CLIENTE ||--o{ RESENA : "escribe"
    RESENA }o--|| PRODUCTO : "sobre"

    VENDEDOR ||--o| REPUTACION_VENDEDOR : "tiene"

    VARIANTE ||--o{ PRECIO_HISTORICO : "registra"

    USUARIO ||--o{ LOG_AUDITORIA : "genera"
    LOG_AUDITORIA }o--|| PEDIDO : "afecta"
    LOG_AUDITORIA }o--|| INVENTARIO : "afecta"
```
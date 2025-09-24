# Modelo de Datos Integrado – Marketplace & Logística

## 1. Entidades y Atributos

### USUARIO
- **usuario_id** (PK)  
- nombre_completo  
- correo  
- telefono  
- fecha_alta  
- password  
- rol (cliente / vendedor / ambos)  

---

### CLIENTE (subtipo de USUARIO)
- **cliente_id** (PK, FK → USUARIO)  
- fecha_registro  
- nivel_cliente (bronze, silver, gold)  
- preferencias  
- historial_compra  

---

### VENDEDOR (subtipo de USUARIO)
- **vendedor_id** (PK, FK → USUARIO)  
- nombre_tienda  
- reputacion_global  
- fecha_inicio  

---

### CATEGORIA
- **categoria_id** (PK)  
- nombre_categoria  
- descripcion  
- categoria_padre_id (FK → CATEGORIA, nullable)  

---

### PRODUCTO
- **producto_id** (PK)  
- vendedor_id (FK → VENDEDOR)  
- categoria_id (FK → CATEGORIA)  
- nombre_producto  
- descripcion  
- estado_publicacion  
- precio_base  

---

### VARIANTE
- **variante_id** (PK)  
- producto_id (FK → PRODUCTO)  
- codigo_sku  
- atributos (talla, color, etc.)  
- precio_final  

---

### ALMACEN
- **almacen_id** (PK)  
- vendedor_id (FK → VENDEDOR)  
- nombre_almacen  
- direccion  
- capacidad  

---

### STOCK (Inventario)
- **stock_id** (PK)  
- almacen_id (FK → ALMACEN)  
- variante_id (FK → VARIANTE)  
- cantidad_disponible  
- cantidad_reservada  
- stock_minimo  

---

### PEDIDO
- **pedido_id** (PK)  
- cliente_id (FK → CLIENTE)  
- fecha_pedido  
- estado_pedido  
- total_pedido  

---

### DETALLE_PEDIDO (Línea de Pedido)
- **detalle_id** (PK)  
- pedido_id (FK → PEDIDO)  
- variante_id (FK → VARIANTE)  
- cantidad  
- precio_unitario  
- subtotal  

---

### ENVIO
- **envio_id** (PK)  
- pedido_id (FK → PEDIDO)  
- estado_envio  
- fecha_envio  
- tracking  
- transportista  

---

### TRANSACCION (Pago)
- **transaccion_id** (PK)  
- pedido_id (FK → PEDIDO)  
- monto_total  
- metodo_pago  
- estado_transaccion  
- fecha_transaccion  

---

### REEMBOLSO
- **reembolso_id** (PK)  
- transaccion_id (FK → TRANSACCION)  
- monto  
- motivo  
- fecha  
- estado  

---

### DEVOLUCION
- **devolucion_id** (PK)  
- detalle_id (FK → DETALLE_PEDIDO)  
- motivo  
- estado_devolucion  
- fecha  
- nota_credito (opcional)  

---

### DESCUENTO / PROMOCION
- **descuento_id** (PK)  
- nombre_descuento  
- tipo (por_producto / por_categoria / por_vendedor / por_pedido)  
- valor_descuento  
- fecha_inicio  
- fecha_fin  
- condiciones_minimas  

---

### OPINION (Reseña)
- **opinion_id** (PK)  
- cliente_id (FK → CLIENTE)  
- producto_id (FK → PRODUCTO)  
- puntuacion (1-5)  
- comentario  
- fecha_opinion  

---

### REPUTACION_VENDEDOR
- **reputacion_id** (PK)  
- cliente_id (FK → CLIENTE)  
- vendedor_id (FK → VENDEDOR)  
- puntuacion  
- comentario  
- fecha  

---

### HISTORICO_PRECIO
- **historico_id** (PK)  
- variante_id (FK → VARIANTE)  
- precio  
- fecha_inicio  
- fecha_fin  

---

### AUDITORIA
- **log_id** (PK)  
- entidad_modificada  
- id_referencia  
- usuario_actor (FK → USUARIO)  
- fecha_accion  
- detalle_accion  

---

## 2. Relaciones y Cardinalidades

- **Usuario – Cliente / Vendedor**: 1:1 opcional (subtipos).  
- **Vendedor – Producto**: 1:N.  
- **Producto – Variante**: 1:N.  
- **Producto – Categoría**: N:1.  
- **Categoría – Subcategoría**: 1:N recursiva.  
- **Variante – Stock – Almacén**: N:M (resuelto con entidad STOCK).  
- **Cliente – Pedido**: 1:N.  
- **Pedido – DetallePedido**: 1:N.  
- **Variante – DetallePedido**: 1:N.  
- **Pedido – Envío**: 1:N.  
- **Pedido – Transacción**: 1:N.  
- **Transacción – Reembolso**: 1:N.  
- **DetallePedido – Devolución**: 0..N.  
- **Promoción – Producto / Categoría / Vendedor**: M:N.  
- **Cliente – Opinión**: 1:N.  
- **Producto – Opinión**: 1:N.  
- **Cliente – ReputaciónVendedor**: 1:N.  
- **Variante – HistóricoPrecio**: 1:N.  
- **Usuario – Auditoría**: 1:N.  

---

## 3. Reglas de Negocio

- Reserva de stock al crear pedido.  
- Cancelación posible en ventana de tiempo X minutos.  
- Bloqueo de envío si stock insuficiente.  
- Máximo de compra por cliente/producto (ej. 5 unidades).  
- Múltiples intentos de pago y reembolsos parciales.  
- Cupones aplicables con fecha de validez y condiciones.  

---

## 4. Diagrama ER (Mermaid)

```mermaid
erDiagram
    USUARIO ||--o| CLIENTE : "es"
    USUARIO ||--o| VENDEDOR : "es"
    VENDEDOR ||--o{ PRODUCTO : "publica"
    PRODUCTO ||--o{ VARIANTE : "tiene"
    PRODUCTO }o--|| CATEGORIA : "pertenece"
    CATEGORIA ||--o{ CATEGORIA : "subcategoría"
    VARIANTE ||--o{ STOCK : "gestiona"
    ALMACEN ||--o{ STOCK : "almacena"
    VENDEDOR ||--o{ ALMACEN : "posee"
    CLIENTE ||--o{ PEDIDO : "realiza"
    PEDIDO ||--o{ DETALLE_PEDIDO : "contiene"
    VARIANTE ||--o{ DETALLE_PEDIDO : "aparece_en"
    PEDIDO ||--o{ ENVIO : "genera"
    PEDIDO ||--o{ TRANSACCION : "se_paga_con"
    TRANSACCION ||--o{ REEMBOLSO : "origina"
    DETALLE_PEDIDO ||--o{ DEVOLUCION : "puede_tener"
    PRODUCTO }o--o{ DESCUENTO : "aplica"
    CLIENTE ||--o{ OPINION : "escribe"
    PRODUCTO ||--o{ OPINION : "recibe"
    CLIENTE ||--o{ REPUTACION_VENDEDOR : "valora"
    VENDEDOR ||--o{ REPUTACION_VENDEDOR : "recibe"
    VARIANTE ||--o{ HISTORICO_PRECIO : "registra"
    USUARIO ||--o{ AUDITORIA : "genera"
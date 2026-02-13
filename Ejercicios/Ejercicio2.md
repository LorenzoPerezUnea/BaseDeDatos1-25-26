# 📌 Modelo de Datos - Marketplace & Logística

## Entidades y Atributos

### USUARIO
- **usuario_id** (PK)  
- nombre_completo  
- correo  
- telefono  
- fecha_alta  

---

### CLIENTE (subtipo de USUARIO)
- **cliente_id** (PK, FK → USUARIO)  
- fecha_registro  
- nivel_cliente (bronze, silver, gold)  

---

### VENDEDOR (subtipo de USUARIO)
- **vendedor_id** (PK, FK → USUARIO)  
- reputacion_global  
- fecha_inicio  

---

### CATEGORIA
- **categoria_id** (PK)  
- nombre_categoria  
- categoria_padre_id (FK → CATEGORIA, nullable)  

---

### PRODUCTO
- **producto_id** (PK)  
- vendedor_id (FK → VENDEDOR)  
- categoria_id (FK → CATEGORIA)  
- nombre_producto  
- descripcion  
- estado_publicacion  

---

### VARIANTE
- **variante_id** (PK)  
- producto_id (FK → PRODUCTO)  
- atributo_talla  
- atributo_color  
- codigo_sku  

---

### ALMACEN
- **almacen_id** (PK)  
- vendedor_id (FK → VENDEDOR)  
- nombre_almacen  
- direccion  

---

### STOCK
- **stock_id** (PK)  
- almacen_id (FK → ALMACEN)  
- variante_id (FK → VARIANTE)  
- disponible  
- reservado  

---

### PEDIDO
- **pedido_id** (PK)  
- cliente_id (FK → CLIENTE)  
- fecha_pedido  
- estado_pedido  
- total_pedido  

---

### DETALLE_PEDIDO
- **detalle_id** (PK)  
- pedido_id (FK → PEDIDO)  
- variante_id (FK → VARIANTE)  
- cantidad  
- precio_unitario  

---

### ENVIO
- **envio_id** (PK)  
- pedido_id (FK → PEDIDO)  
- estado_envio  
- fecha_envio  
- tracking  

---

### TRANSACCION (Pago)
- **transaccion_id** (PK)  
- pedido_id (FK → PEDIDO)  
- monto_total  
- metodo  
- estado_transaccion  
- fecha_transaccion  

---

### REEMBOLSO
- **reembolso_id** (PK)  
- transaccion_id (FK → TRANSACCION)  
- cantidad_reembolsada  
- razon  
- fecha_reembolso  

---

### DEVOLUCION
- **devolucion_id** (PK)  
- detalle_id (FK → DETALLE_PEDIDO)  
- motivo  
- estado_devolucion  

---

### DESCUENTO (Promoción / Cupón)
- **descuento_id** (PK)  
- nombre_descuento  
- tipo (por_producto / por_categoria / por_pedido)  
- valor_descuento  
- fecha_inicio  
- fecha_fin  

---

### OPINION (Reseña)
- **opinion_id** (PK)  
- cliente_id (FK → CLIENTE)  
- producto_id (FK → PRODUCTO)  
- puntuacion (1-5)  
- comentario  
- fecha_opinion  

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
- usuario_actor  
- fecha_accion  
- detalle_accion  

---

## Relaciones y Cardinalidades

- **Usuario – Cliente**: 1:1 (opcional)  
- **Usuario – Vendedor**: 1:1 (opcional)  
- **Vendedor – Producto**: 1:N  
- **Producto – Variante**: 1:N  
- **Producto – Categoría**: N:1  
- **Categoría – Categoría (padre-hijo)**: 1:N  
- **Variante – Stock**: 1:N  
- **Almacén – Stock**: 1:N  
- **Vendedor – Almacén**: 1:N  
- **Cliente – Pedido**: 1:N  
- **Pedido – DetallePedido**: 1:N  
- **Variante – DetallePedido**: 1:N  
- **Pedido – Envío**: 1:N  
- **Pedido – Transacción**: 1:N  
- **Transacción – Reembolso**: 1:N  
- **DetallePedido – Devolución**: 0..N  
- **Descuento – Producto**: M:N  
- **Cliente – Opinión**: 1:N  
- **Producto – Opinión**: 1:N  
- **Variante – HistóricoPrecio**: 1:N  

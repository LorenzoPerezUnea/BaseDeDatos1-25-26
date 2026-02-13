# 📌 Diagrama Entidad-Relación (Marketplace + Logística)

## Entidades y Atributos

### Usuario
- **usuario_id** (PK)
- nombre
- email
- contraseña
- rol (Cliente, Vendedor, ambos)

### Cliente (subtipo de Usuario)
- **cliente_id** (PK, FK → Usuario)
- dirección
- teléfono

### Vendedor (subtipo de Usuario)
- **vendedor_id** (PK, FK → Usuario)
- reputación

---

### Producto
- **producto_id** (PK)
- nombre
- descripción
- categoria_id (FK → Categoría)

### VarianteProducto
- **variante_id** (PK)
- producto_id (FK → Producto)
- talla
- color
- SKU
- precio_actual

### Categoría
- **categoria_id** (PK)
- nombre
- categoria_padre_id (FK → Categoría) ← relación recursiva

---

### Almacén
- **almacen_id** (PK)
- vendedor_id (FK → Vendedor)
- ubicación

### Inventario
- **inventario_id** (PK)
- variante_id (FK → VarianteProducto)
- almacen_id (FK → Almacén)
- cantidad_disponible

---

### Pedido
- **pedido_id** (PK)
- cliente_id (FK → Cliente)
- fecha_creación
- estado
- total

### LíneaPedido
- **linea_id** (PK)
- pedido_id (FK → Pedido)
- variante_id (FK → VarianteProducto)
- cantidad
- precio_unitario

---

### Envío (Shipment)
- **envio_id** (PK)
- pedido_id (FK → Pedido)
- estado_envio
- transportista
- tracking

---

### Pago
- **pago_id** (PK)
- pedido_id (FK → Pedido)
- metodo_pago_id (FK → MétodoPago)
- estado
- monto
- fecha

### MétodoPago
- **metodo_pago_id** (PK)
- tipo (tarjeta, PayPal, transferencia, etc.)

---

### Devolución
- **devolucion_id** (PK)
- linea_id (FK → LíneaPedido)
- motivo
- estado
- nota_credito
- reembolso_id (FK → Reembolso, opcional)

### Reembolso
- **reembolso_id** (PK)
- pago_id (FK → Pago)
- monto
- fecha
- estado

---

### Promoción / Cupón
- **promo_id** (PK)
- tipo (producto, categoría, vendedor, pedido)
- condicion_minima
- descuento
- fecha_inicio
- fecha_fin

---

### Reseña
- **reseña_id** (PK)
- cliente_id (FK → Cliente)
- producto_id (FK → Producto)
- rating
- comentario
- fecha

---

### HistorialPrecio
- **historial_id** (PK)
- variante_id (FK → VarianteProducto)
- precio
- fecha_inicio
- fecha_fin

---

### Auditoría / Logs
- **log_id** (PK)
- usuario_id (FK → Usuario)
- entidad_afectada
- tipo_cambio
- fecha
- detalle

---

## 📊 Relaciones Clave

- **Usuario** ↔ (subtipos) ↔ Cliente / Vendedor
- **Vendedor** ↔ Productos ↔ Variantes ↔ Inventario ↔ Almacén
- **Cliente** ↔ Pedido ↔ LíneasPedido ↔ VarianteProducto
- **Pedido** ↔ Envíos ↔ LíneasPedido
- **Pedido** ↔ Pagos ↔ Reembolso
- **LíneaPedido** ↔ Devolución
- **Promoción** ↔ Producto / Categoría / Vendedor / Pedido
- **Cliente** ↔ Reseñas ↔ Producto
- **VarianteProducto** ↔ HistorialPrecio
- **Usuario** ↔ Logs

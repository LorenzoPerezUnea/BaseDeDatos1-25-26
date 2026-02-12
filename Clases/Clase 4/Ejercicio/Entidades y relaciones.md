# Entidades
### Usuario
### Vendedores
### Clientes
### Productos
### Almacenes
### Pedido
### Envíos
### Pagos
### Método de pago
### Devoluciones
### Promociones
### Reseñas
### Categoría
### Variante_Producto
### Inventario
### Línea_pedido
### Reembolso
### Historial_precio
### Log_auditoría

# Relaciones
### Usuario cliente: 1:1
### Usuario vendedor: 1:1
### Vendedor producto: 1:N
### Producto variante: 1:N
### Producto categoría: N:1
### Categoría categoría: 1:N
### Variante inventario: 1:N
### Almacén inventario: 1:N
### Vendedor almacén: 1:N
### Cliente pedido: 1:N
### Pedido línea_pedido: 1:N
### Variante línea_pedido: 1:N 
### Pedido envío: 1:N
### Pedido pago: 1:N
### Pago reembolso: 1:N
### Línea_pedido devolución: 0..N
### Promoción producto: M:N
### Cliente reseña: 1:N
### Producto reseña: 1:N
### Variante Historial_precio: 1:N
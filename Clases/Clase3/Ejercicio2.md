# Identificación Entidades
## Usuario 
    - id_usuario (PK)
    - nombre 
    - email
    - contraseña

## Cliente
    - id_cliente (PK, FK usuario)
    - fecha_registro
    - nivel_fidelidad

## Vendedor
    - id_vendedor (FK, PK usuario) 
    - reputacion
    - fecha_alta

## Producto
    - id_producto (PK)
    - id_vendedor (FK)
    - nombre
    - descripcion
    - foto

## Variante_Producto
    - id_variante_producto (PK)
    - id_producto (FK)
    - color
    - talla

## Categoria
    - id_categoria (PK)
    - subcategoria
    - nombre

## Almacen
    - id_almacen (PK)
    - id_vendedor (FK)
    - nombre   
    - direccion

## Pedido
    - id_pedido (PK)
    - numero_items
    - numero_pedido
    - estado_pedido

## Linea_Pedido
    - id_linea_pedido (PK)
    - id_variante_producto (FK)
    - id_pedido (FK)
    - cantidad
    - precio

## Envio
    - id_envio (PK)
    - estado_envio
    - numero_item

## Pago
    - id_pago (PK)
    - id_Pedido (FK)
    - cantidad
    - metodo_pago
    - estado_pago

## Reembolso
    - id_reembolso (PK)
    - id_pago (FK)
    - cantidad
    - motivo

## Devolucion
    - id_devolucion (PK)
    - id_linea_pedido (FK)
    - motivo
    - estado

## Promocion
    - id_promocion (PK)
    - id_categoria (FK)
    - id_vendedor (FK)
    - porcentaje_descuento
    - nombre
    - fecha_inicio
    - fecha_fin

## Historial_precio
    - id_historial_precio (PK)
    - id_variante (FK)
    - precio
    - fecha_inicio

## Log_auditoria
    - id_log_auditoria (PK)
    - id_usuario (FK)
    - id_pedido (FK)
    - historial_precios

# Relaciones entre entidades
    - Usuario-Cliente: Un usuario puede ser un cliente (1:1)
    - Usuario-Vendedor: Un usuario puede ser un vendedor (1:1)
    - Vendedor-Producto: Un vendedor pone a la venta muchos productos (1:N)
    - Cliente-Producto. Un cliente compra muchos productos (1:N)
    - Producto-Variante_producto: Un producto puede tener una variante (1:1)
    - Producto-Categoria: Un producto pertenece a una categoria (1:1)
    - Producto-Almacen: Un producto esta en un almacen (1:1)
    - Vendedor-Almacen: Un vendedor puede tener muchos almacenes (1:N)
    - Cliente-Pedido: Un cliente puede crear muchos pedidos(1:N)
    - Pedido-Lineas_de_pedido: Un pedido puede tener muchas lineas de pedido (1:N)
    - Pedido-Envio: Un pedido puede dividirse en muchos envios (1:N)
    - Pedido-Pago: Un pedido puede registrar un pago (1:1)
    - Promocion-Producto: Una promocion se puede aplicar a un producto (1:1)
    - Promocion-Categoria: Una promocion se aplica a una categoria (1:1)
    - Promocion-Vendedor: Una promocion se aplica por un vendedor (1:1)
    - Producto-Reseña: Un producto puede tener muchas reseñas (1:N)
    - Producto-Reporte: Un producto puede ser reportado muchas veces (1:N)
    - Pedido-Reporte: Un pedido puede ser reportado muchas veces (1:N)


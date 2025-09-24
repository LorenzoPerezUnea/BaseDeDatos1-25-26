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
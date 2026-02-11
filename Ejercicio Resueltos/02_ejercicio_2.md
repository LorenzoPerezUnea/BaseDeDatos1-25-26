# Marketplace y Logística  
Modelo Conceptual de Base de Datos

## Identificación de Entidades
- Usuario (Cliente, Vendedor o ambos)  
- Producto  
- VarianteProducto  
- Categoria  
- Almacen  
- Inventario  
- Pedido  
- LineaPedido  
- Envio (Shipment)  
- Pago  
- MetodoPago  
- Devolucion  
- Promocion / Cupon  
- ResenaProducto  
- HistorialPrecio  
- LogAuditoria  

---

## Identificación de Atributos

| **Entidad** | **Atributos** |
|------------|----------------|
| **Usuario** | id_usuario, nombre, email, telefono, tipo (cliente/vendedor/ambos) |
| **Producto** | id_producto, nombre, descripcion, id_categoria, id_vendedor, activo |
| **VarianteProducto** | id_variante, id_producto, atributos (talla, color, etc.), sku |
| **Categoria** | id_categoria, nombre, id_padre (para jerarquía) |
| **Almacen** | id_almacen, id_vendedor, nombre, direccion, tipo (propio/proveedor) |
| **Inventario** | id_variante, id_almacen, cantidad_disponible |
| **Pedido** | id_pedido, id_cliente, fecha_creacion, estado, total |
| **LineaPedido** | id_linea, id_pedido, id_variante, cantidad, precio_unitario |
| **Envio** | id_envio, id_pedido, estado, fecha_envio, fecha_entrega |
| **Pago** | id_pago, id_pedido, monto, estado, fecha, id_metodo_pago |
| **MetodoPago** | id_metodo_pago, tipo, descripcion |
| **Devolucion** | id_devolucion, id_linea, motivo, estado, monto_reembolsado, nota_credito |
| **Promocion** | id_promocion, codigo, descripcion, descuento, tipo_aplicacion (producto/categoria/pedido), fecha_inicio, fecha_fin, condiciones |
| **ResenaProducto** | id_resena, id_variante, id_cliente, calificacion, comentario, fecha |
| **HistorialPrecio** | id_historial, id_variante, precio, fecha_inicio, fecha_fin |
| **LogAuditoria** | id_log, id_usuario, entidad_afectada, accion, fecha, detalle |

---

## 🔗 Identificación de Relaciones y Cardinalidades

- Usuario 1 ─── N Pedido (Cliente)  
- Usuario 1 ─── N Producto (Vendedor)  
- Producto 1 ─── N VarianteProducto  
- Categoria 1 ─── N Producto  
- VarianteProducto N ─── N Almacen (a través de Inventario)  
- Pedido 1 ─── N LineaPedido  
- LineaPedido 1 ─── N Envio  
- Pedido 1 ─── N Pago  
- LineaPedido 1 ─── 0..1 Devolucion  
- Promocion N ─── N Producto / VarianteProducto / Pedido (dependiendo de tipo_aplicacion)  
- VarianteProducto 1 ─── N ResenaProducto  
- VarianteProducto 1 ─── N HistorialPrecio  
- Usuario 1 ─── N LogAuditoria  

---

## 📝 Diagrama Chen (Mermaid)

```mermaid
erDiagram
    USUARIO ||--o{ PEDIDO : "realiza"
    USUARIO ||--o{ PRODUCTO : "vende"
    PRODUCTO ||--o{ VARIANTEPRODUCTO : "tiene"
    CATEGORIA ||--o{ PRODUCTO : "agrupa"
    VARIANTEPRODUCTO ||--o{ INVENTARIO : "mantiene en"
    ALMACEN ||--o{ INVENTARIO : "contiene"
    PEDIDO ||--o{ LINEAPEDIDO : "contiene"
    LINEAPEDIDO ||--o{ ENVIO : "agrupa"
    PEDIDO ||--o{ PAGO : "tiene"
    LINEAPEDIDO ||--o| DEVOLUCION : "puede tener"
    PROMOCION ||--o{ PRODUCTO : "aplica a"
    VARIANTEPRODUCTO ||--o{ RESENAPRODUCTO : "recibe"
    VARIANTEPRODUCTO ||--o{ HISTORIALPRECIO : "registra"
    USUARIO ||--o{ LOGAUDITORIA : "genera"

    USUARIO {
        int id_usuario PK
        string nombre
        string email
        string telefono
        enum tipo
    }

    PRODUCTO {
        int id_producto PK
        string nombre
        string descripcion
        int id_categoria FK
        int id_vendedor FK
        boolean activo
    }

    VARIANTEPRODUCTO {
        int id_variante PK
        int id_producto FK
        string atributos
        string sku
    }

    CATEGORIA {
        int id_categoria PK
        string nombre
        int id_padre FK
    }

    ALMACEN {
        int id_almacen PK
        int id_vendedor FK
        string nombre
        string direccion
        enum tipo
    }

    INVENTARIO {
        int id_variante FK
        int id_almacen FK
        int cantidad_disponible
    }

    PEDIDO {
        int id_pedido PK
        int id_cliente FK
        datetime fecha_creacion
        string estado
        decimal total
    }

    LINEAPEDIDO {
        int id_linea PK
        int id_pedido FK
        int id_variante FK
        int cantidad
        decimal precio_unitario
    }

    ENVIO {
        int id_envio PK
        int id_pedido FK
        string estado
        datetime fecha_envio
        datetime fecha_entrega
    }

    PAGO {
        int id_pago PK
        int id_pedido FK
        decimal monto
        string estado
        datetime fecha
        int id_metodo_pago FK
    }

    METODOPAGO {
        int id_metodo_pago PK
        string tipo
        string descripcion
    }

    DEVOLUCION {
        int id_devolucion PK
        int id_linea FK
        string motivo
        string estado
        decimal monto_reembolsado
        string nota_credito
    }

    PROMOCION {
        int id_promocion PK
        string codigo
        string descripcion
        decimal descuento
        enum tipo_aplicacion
        date fecha_inicio
        date fecha_fin
        string condiciones
    }

    RESENAPRODUCTO {
        int id_resena PK
        int id_variante FK
        int id_cliente FK
        int calificacion
        string comentario
        date fecha
    }

    HISTORIALPRECIO {
        int id_historial PK
        int id_variante FK
        decimal precio
        date fecha_inicio
        date fecha_fin
    }

    LOGAUDITORIA {
        int id_log PK
        int id_usuario FK
        string entidad_afectada
        string accion
        datetime fecha
        string detalle
    }

```mermaid
erDiagram
    Usuario {
        int id_usuario
        string nombre
        string email
        string contraseña
        string rol
    }
    Cliente {
        int id_cliente
        string direccion_envio
        string preferencias
    }
    Vendedor {
        int id_vendedor
        string razon_social
        string datos_fiscales
    }
    Producto {
        int id_producto
        string nombre
        string descripcion
        string estado_publicacion
    }
    VarianteProducto {
        int id_variante
        string atributos_variante
        string sku
        float precio_actual
    }
    Categoria {
        int id_categoria
        string nombre
        string descripcion
    }
    Almacen {
        int id_almacen
        string nombre
        string ubicacion
        string tipo
    }
    Pedido {
        int id_pedido
        date fecha_creacion
        string estado
        float total
        string region
    }
    LineaPedido {
        int id_linea
        int cantidad
        float precio_unitario
    }
    Envio {
        int id_envio
        date fecha_envio
        string estado_envio
        string tracking
    }
    Pago {
        int id_pago
        float monto
        string estado_pago
        date fecha
        string tipo_transaccion
    }
    MetodoPago {
        int id_metodo
        string tipo
        string proveedor
    }
    Devolucion {
        int id_devolucion
        date fecha
        string motivo
        string estado
        string nota_credito
    }
    Promocion {
        int id_promocion
        string tipo
        string condiciones
        date fecha_inicio
        date fecha_fin
        float valor_descuento
    }
    ResenaProducto {
        int id_resena
        string comentario
        int puntuacion
        date fecha
    }
    ReputacionVendedor {
        int id_reputacion
        float score
        string comentarios_agregados
    }
    HistorialPrecio {
        int id_historial
        date fecha_inicio
        date fecha_fin
        float precio
    }
    LogAuditoria {
        int id_log
        string usuario_actor
        string accion
        string entidad_afectada
        date fecha
        string detalle_cambio
    }

    Usuario ||--o{ Cliente : "es subtipo de"
    Usuario ||--o{ Vendedor : "es subtipo de"
    Vendedor ||--o{ Producto : "ofrece"
    Producto ||--o{ VarianteProducto : "tiene"
    Producto }o--|| Categoria : "pertenece a"
    Categoria ||--o{ Categoria : "subdivide en"
    VarianteProducto }o--o{ Almacen : "se almacena en"
    Pedido }o--|| Cliente : "creado por"
    Pedido ||--o{ LineaPedido : "contiene"
    LineaPedido }o--|| VarianteProducto : "corresponde a"
    Pedido ||--o{ Envio : "se divide en"
    Envio }o--o{ LineaPedido : "agrupa"
    Pedido ||--o{ Pago : "tiene"
    Pago }o--|| MetodoPago : "usa"
    LineaPedido ||--o{ Devolucion : "puede generar"
    Promocion }o--o{ Producto : "aplicable a"
    Promocion }o--o{ Categoria : "aplicable a"
    Promocion }o--o{ Vendedor : "aplicable a"
    Promocion }o--o{ Pedido : "aplicable a"
    Cliente ||--o{ ResenaProducto : "realiza"
    ResenaProducto }o--|| Producto : "se refiere a"
    Vendedor ||--|| ReputacionVendedor : "se asocia a"
    VarianteProducto ||--o{ HistorialPrecio : "tiene"
    LogAuditoria }o--o{ Pedido : "registra"
    LogAuditoria }o--o{ VarianteProducto : "registra"
    LogAuditoria }o--o{ Usuario : "registra"

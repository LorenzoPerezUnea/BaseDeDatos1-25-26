erDiagram
    Usuario {
        int id_usuario
        string nombre
        string correo
        string clave_acceso
        string rol
    }
    Cliente {
        int id_cliente
        string direccion
        string preferencias_compra
    }
    Vendedor {
        int id_vendedor
        string nombre_comercial
        string identificacion_fiscal
    }
    Producto {
        int id_producto
        string nombre
        string descripcion
        string marca
        date fecha_publicacion
    }
    VarianteProducto {
        int id_variante
        string combinacion_atributos
        string codigo_sku
        float precio
    }
    Categoria {
        int id_categoria
        string titulo
        string detalle
    }
    Almacen {
        int id_almacen
        string nombre
        string ubicacion
        string capacidad
    }
    Pedido {
        int id_pedido
        date fecha_creacion
        string estado
        float importe_total
    }
    LineaPedido {
        int id_linea
        int cantidad
        float precio_unitario
    }
    Envio {
        int id_envio
        date fecha_salida
        string estado_envio
        string guia_tracking
    }
    Pago {
        int id_pago
        float monto
        string estado
        date fecha_pago
        string referencia
    }
    MetodoPago {
        int id_metodo
        string nombre_metodo
        string proveedor
    }
    Devolucion {
        int id_devolucion
        date fecha
        string causa
        string estado
    }
    Promocion {
        int id_promocion
        string tipo
        string condiciones
        date inicio
        date fin
        float descuento
    }
    ResenaProducto {
        int id_resena
        string opinion
        int puntuacion
        date fecha
    }
    ReputacionVendedor {
        int id_reputacion
        float indice
        string comentarios
    }
    HistorialPrecio {
        int id_historial
        date fecha_inicio
        date fecha_fin
        float valor
    }
    LogAuditoria {
        int id_log
        string actor
        string accion
        string entidad
        date fecha
        string detalle
    }

    %% Jerarquía de usuario
    Usuario ||--o{ Cliente : "subtipo"
    Usuario ||--o{ Vendedor : "subtipo"

    %% Relaciones
    Vendedor ||--o{ Producto : "publica"
    Producto ||--o{ VarianteProducto : "posee"
    Producto }o--|| Categoria : "clasificado en"
    Categoria ||--o{ Categoria : "subcategoria"
    VarianteProducto }o--o{ Almacen : "se guarda en"
    Pedido }o--|| Cliente : "realizado por"
    Pedido ||--o{ LineaPedido : "incluye"
    LineaPedido }o--|| VarianteProducto : "referencia"
    Pedido ||--o{ Envio : "genera"
    Envio }o--|| Cliente : "destinado a"
    Pedido ||--o{ Pago : "liquidado con"
    Pago }o--|| MetodoPago : "utiliza"
    LineaPedido ||--o{ Devolucion : "puede originar"
    Promocion }o--o{ Producto : "afecta"
    Promocion }o--o{ Categoria : "aplicable"
    Promocion }o--o{ Vendedor : "ofrecida por"
    Cliente ||--o{ ResenaProducto : "escribe"
    ResenaProducto }o--|| Producto : "sobre"
    Vendedor ||--|| ReputacionVendedor : "tiene"
    VarianteProducto ||--o{ HistorialPrecio : "registra"
    LogAuditoria }o--o{ Pedido : "audita"
    LogAuditoria }o--o{ Usuario : "audita"
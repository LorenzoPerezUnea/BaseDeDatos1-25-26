```mermaid
erDiagram

    USUARIO {
        int usuario_id PK
        string nombre_completo
        string correo
        string telefono
        date fecha_alta
    }

    CLIENTE {
        int cliente_id PK, FK
        date fecha_registro
        string nivel_cliente
    }

    VENDEDOR {
        int vendedor_id PK, FK
        float reputacion_global
        date fecha_inicio
    }

    CATEGORIA {
        int categoria_id PK
        string nombre_categoria
        int categoria_padre_id FK
    }

    PRODUCTO {
        int producto_id PK
        string nombre_producto
        string descripcion
        string estado_publicacion
        int vendedor_id FK
        int categoria_id FK
    }

    VARIANTE {
        int variante_id PK
        string atributo_talla
        string atributo_color
        string codigo_sku
        int producto_id FK
    }

    ALMACEN {
        int almacen_id PK
        string nombre_almacen
        string direccion
        int vendedor_id FK
    }

    STOCK {
        int stock_id PK
        int disponible
        int reservado
        int almacen_id FK
        int variante_id FK
    }

    PEDIDO {
        int pedido_id PK
        date fecha_pedido
        string estado_pedido
        float total_pedido
        int cliente_id FK
    }

    DETALLE_PEDIDO {
        int detalle_id PK
        int cantidad
        float precio_unitario
        int pedido_id FK
        int variante_id FK
    }

    ENVIO {
        int envio_id PK
        string estado_envio
        date fecha_envio
        string tracking
        int pedido_id FK
    }

    TRANSACCION {
        int transaccion_id PK
        float monto_total
        string metodo
        string estado_transaccion
        date fecha_transaccion
        int pedido_id FK
    }

    REEMBOLSO {
        int reembolso_id PK
        float cantidad_reembolsada
        string razon
        date fecha_reembolso
        int transaccion_id FK
    }

    DEVOLUCION {
        int devolucion_id PK
        string motivo
        string estado_devolucion
        int detalle_id FK
    }

    DESCUENTO {
        int descuento_id PK
        string nombre_descuento
        string tipo
        float valor_descuento
        date fecha_inicio
        date fecha_fin
    }

    OPINION {
        int opinion_id PK
        int puntuacion
        string comentario
        date fecha_opinion
        int cliente_id FK
        int producto_id FK
    }

    HISTORICO_PRECIO {
        int historico_id PK
        float precio
        date fecha_inicio
        date fecha_fin
        int variante_id FK
    }

    AUDITORIA {
        int log_id PK
        string entidad_modificada
        int id_referencia
        int usuario_actor
        date fecha_accion
        string detalle_accion
    }

    %% Relaciones

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
    VARIANTE ||--o{ HISTORICO_PRECIO : "registra"

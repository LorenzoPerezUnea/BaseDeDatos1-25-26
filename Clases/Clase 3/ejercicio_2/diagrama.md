```mermaid
erDiagram
    USUARIO ||--o| CLIENTE : es
    USUARIO ||--o| VENDEDOR : es

    VENDEDOR ||--o{ PRODUCTO : "publica"
    CATEGORIA ||--o{ CATEGORIA : "subcategoria"
    CATEGORIA ||--o{ PRODUCTO : "clasifica"
    PRODUCTO ||--o{ VARIANTE : "posee"
    VARIANTE ||--o{ HISTORIALPRECIO : "registra"

    VENDEDOR ||--o{ ALMACEN : "administra"
    VARIANTE ||--o{ INVENTARIO : "stock"
    ALMACEN ||--o{ INVENTARIO : "contiene"

    CLIENTE ||--o{ PEDIDO : "realiza"
    PEDIDO ||--o{ LINEAPEDIDO : "incluye"
    PEDIDO ||--o{ ENVIO : "genera"
    ENVIO ||--o{ ITEMENVIO : "agrupa"
    LINEAPEDIDO ||--o{ ITEMENVIO : "se_envia"

    PEDIDO ||--o{ PAGO : "procesa"
    LINEAPEDIDO ||--o{ DEVOLUCION : "puede_tener"

    PROMOCION ||--o{ PROMO_PRODUCTO : "afecta"
    PROMOCION ||--o{ PROMO_CATEGORIA : "afecta"
    PROMOCION ||--o{ PROMO_VENDEDOR : "afecta"
    PROMOCION ||--o{ PROMO_PEDIDO : "afecta"

    PRODUCTO ||--o{ RESENA : "recibe"
    CLIENTE ||--o{ RESENA : "escribe"

    USUARIO ||--o{ LOGAUDITORIA : "registra"

    %% Definición de atributos clave (PK marcados con *)
    USUARIO {
        int id_usuario PK
        string nombre
        string email
        string password_hash
    }
    CLIENTE {
        int id_cliente PK,FK
        string direccion_envio
        date fecha_registro
    }
    VENDEDOR {
        int id_vendedor PK,FK
        string nombre_tienda
        float reputacion
    }
    CATEGORIA {
        int id_categoria PK
        string nombre
        int id_padre FK
    }
    PRODUCTO {
        int id_producto PK
        string nombre
        string descripcion
        int id_vendedor FK
        int id_categoria FK
    }
    VARIANTE {
        int id_variante PK
        int id_producto FK
        string sku
        string talla
        string color
        decimal precio_actual
    }
    HISTORIALPRECIO {
        int id_historial PK
        int id_variante FK
        date fecha
        decimal precio
    }
    ALMACEN {
        int id_almacen PK
        int id_vendedor FK
        string nombre
        string ubicacion
    }
    INVENTARIO {
        int id_variante FK
        int id_almacen FK
        int stock
        int reservado
    }
    PEDIDO {
        int id_pedido PK
        int id_cliente FK
        date fecha_creacion
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
        string estado_envio
        date fecha_envio
    }
    ITEMENVIO {
        int id_envio FK
        int id_linea FK
    }
    PAGO {
        int id_pago PK
        int id_pedido FK
        string metodo
        decimal monto
        string estado
        date fecha
    }
    DEVOLUCION {
        int id_devolucion PK
        int id_linea FK
        string motivo
        string estado
        decimal monto_reembolso
        string nota_credito
    }
    PROMOCION {
        int id_promocion PK
        string tipo
        decimal descuento
        date fecha_inicio
        date fecha_fin
        string condiciones
    }
    PROMO_PRODUCTO {
        int id_promocion FK
        int id_producto FK
    }
    PROMO_CATEGORIA {
        int id_promocion FK
        int id_categoria FK
    }
    PROMO_VENDEDOR {
        int id_promocion FK
        int id_vendedor FK
    }
    PROMO_PEDIDO {
        int id_promocion FK
        int id_pedido FK
    }
    RESENA {
        int id_resena PK
        int id_cliente FK
        int id_producto FK
        int rating
        string comentario
        date fecha
    }
    LOGAUDITORIA {
        int id_log PK
        int usuario_actor FK
        string entidad
        int id_entidad
        string accion
        date fecha
        string detalles
    }
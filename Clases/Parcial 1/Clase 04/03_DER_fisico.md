# DER Físico (Modelo Relacional) – Plataforma de Torneos

```mermaid
erDiagram
    %% ==== RELACIONES ====
    USUARIO ||--|| CLIENTE : "es"
    USUARIO ||--|| VENDEDOR : "es"
    VENDEDOR ||--o{ PRODUCTO : "publica"
    PRODUCTO ||--o{ VARIANTE_PRODUCTO : "tiene"
    PRODUCTO }o--|| CATEGORIA : "pertenece"
    CATEGORIA ||--o{ CATEGORIA : "subcategoria"
    VARIANTE_PRODUCTO ||--o{ INVENTARIO : "tiene"
    ALMACEN ||--o{ INVENTARIO : "gestiona"
    VENDEDOR ||--o{ ALMACEN : "posee"
    CLIENTE ||--o{ PEDIDO : "realiza"
    PEDIDO ||--o{ LINEA_PEDIDO : "contiene"
    VARIANTE_PRODUCTO ||--o{ LINEA_PEDIDO : "incluye"
    LINEA_PEDIDO ||--o{ ENVIO : "es_despachada_en"
    ALMACEN ||--o{ LINEA_PEDIDO : "surte"
    PEDIDO ||--o{ PAGO : "tiene"
    PAGO ||--o{ REEMBOLSO : "genera"
    LINEA_PEDIDO ||--o{ DEVOLUCION : "puede_ser_devuelta"
    PRODUCTO }o--o{ PROMOCION : "aplica"
    CLIENTE ||--o{ RESENA : "escribe"
    PRODUCTO ||--o{ RESENA : "recibe"
    VARIANTE_PRODUCTO ||--o{ HISTORIAL_PRECIO : "registra"
    LOG_AUDITORIA ||--o{ PEDIDO : "log_de" 

    %% ==== ENTIDADES Y ATRIBUTOS ====
    USUARIO {
        int id_usuario PK
        string nombre
        string email
        string telefono
    }

    CLIENTE {
        int id_cliente PK
        int id_usuario FK
        date fecha_registro
        string nivel_fidelidad
    }

    VENDEDOR {
        int id_vendedor PK
        int id_usuario FK
        float reputacion
        date fecha_alta
    }

    CATEGORIA {
        int id_categoria PK
        string nombre
        int id_categoria_padre FK
    }

    PRODUCTO {
        int id_producto PK
        int id_vendedor FK
        string nombre
        string descripcion
        int id_categoria FK
    }

    VARIANTE_PRODUCTO {
        int id_variante PK
        int id_producto FK
        string sku
        string talla
        string color
    }

    ALMACEN {
        int id_almacen PK
        int id_vendedor FK
        string nombre
        string direccion
        string tipo_stock
    }

    INVENTARIO {
        int id_inventario PK
        int id_almacen FK
        int id_variante FK
        int cantidad_disponible
        int cantidad_reservada
    }

    PEDIDO {
        int id_pedido PK
        int id_cliente FK
        datetime fecha_creacion
        string estado_pedido
        float total
    }

    LINEA_PEDIDO {
        int id_linea PK
        int id_pedido FK
        int id_variante FK
        int id_almacen FK
        int id_envio FK "nullable"
        int cantidad
        float precio_unitario
    }

    ENVIO {
        int id_envio PK
        string estado_envio
        date fecha_envio
        string empresa_transporte
        string codigo_seguimiento
    }

    PAGO {
        int id_pago PK
        int id_pedido FK
        int id_cliente FK
        float monto
        string metodo_pago
        string estado_pago
        datetime fecha_pago
    }

    REEMBOLSO {
        int id_reembolso PK
        int id_pago FK
        float monto_devuelto
        string motivo
        date fecha_reembolso
    }

    DEVOLUCION {
        int id_devolucion PK
        int id_linea FK
        string motivo
        string estado
        int cantidad
    }

    PROMOCION {
        int id_promocion PK
        string nombre
        string tipo_aplicacion
        float porcentaje_descuento
        date fecha_inicio
        date fecha_fin
    }

    RESENA {
        int id_resena PK
        int id_cliente FK
        int id_producto FK
        int calificacion
        string comentario
        date fecha_resena
    }

    HISTORIAL_PRECIO {
        int id_historial PK
        int id_variante FK
        float precio
        date fecha_inicio
        date fecha_fin
    }

    LOG_AUDITORIA {
        int id_log PK
        string entidad_afectada
        int id_entidad
        int id_usuario_fk
        datetime fecha
        string descripcion
    }
```


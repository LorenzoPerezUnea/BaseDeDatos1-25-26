``` mermaid
erDiagram
    USUARIO {
        int id_usuario PK
        string nombre
        string email
        string password_hash
        date fecha_registro
        string rol
    }
    CLIENTE {
        int id_cliente PK
        int id_usuario FK
        string direccion_envio
        string telefono
    }
    VENDEDOR {
        int id_vendedor PK
        int id_usuario FK
        string nombre_tienda
        float reputacion
        string pais
    }
    PRODUCTO {
        int id_producto PK
        int id_vendedor FK
        string nombre
        string descripcion
        string estado
        date fecha_creacion
    }
    VARIANTE {
        int id_variante PK
        int id_producto FK
        string atributos_json
        decimal precio_actual
        string sku
    }
    CATEGORIA {
        int id_categoria PK
        string nombre
        string descripcion
        int id_categoria_padre FK
    }
    ALMACEN {
        int id_almacen PK
        int id_vendedor FK
        string nombre
        string direccion
        string tipo
    }
    INVENTARIO {
        int id_inventario PK
        int id_variante FK
        int id_almacen FK
        int cantidad_disponible
        int cantidad_reservada
    }
    PEDIDO {
        int id_pedido PK
        int id_cliente FK
        date fecha
        string estado
        decimal total
    }
    LINEA_PEDIDO {
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
        string transportista
    }
    PAGO {
        int id_pago PK
        int id_pedido FK
        decimal monto
        string estado
        date fecha
        int intentos
    }
    METODO_PAGO {
        int id_metodo PK
        string nombre
        string proveedor
        string tipo
    }
    DEVOLUCION {
        int id_devolucion PK
        int id_linea FK
        string motivo
        string estado
        decimal monto_reembolso
    }
    PROMOCION {
        int id_promocion PK
        string nombre
        string descripcion
        string tipo
        decimal descuento
        date fecha_inicio
        date fecha_fin
    }
    RESENA {
        int id_resena PK
        int id_cliente FK
        string objetivo_tipo
        int id_objetivo
        string contenido
        int calificacion
        date fecha
    }
    HISTORIAL_PRECIOS {
        int id_historial PK
        int id_variante FK
        decimal precio
        date fecha
    }
    LOG_AUDITORIA {
        int id_log PK
        int id_usuario FK
        string accion
        string entidad
        int id_entidad
        date fecha
    }

    USUARIO ||--o{ CLIENTE : puede_ser
    USUARIO ||--o{ VENDEDOR : puede_ser

    VENDEDOR ||--o{ PRODUCTO : ofrece
    PRODUCTO ||--o{ VARIANTE : tiene

    VARIANTE }o--|| CATEGORIA : pertenece_a
    VARIANTE ||--o{ INVENTARIO : stock_en
    ALMACEN ||--o{ INVENTARIO : mantiene

    CLIENTE ||--o{ PEDIDO : realiza
    PEDIDO ||--o{ LINEA_PEDIDO : contiene
    LINEA_PEDIDO }o--|| VARIANTE : refiere_a

    PEDIDO ||--o{ ENVIO : tiene
    ENVIO ||--o{ LINEA_PEDIDO : agrupa

    PEDIDO ||--o{ PAGO : procesa
    PAGO }o--|| METODO_PAGO : usa

    LINEA_PEDIDO ||--o{ DEVOLUCION : puede_tener

    PROMOCION }o--o{ PRODUCTO : aplica_a
    PROMOCION }o--o{ CATEGORIA : aplica_a
    PROMOCION }o--o{ VENDEDOR : aplica_a
    PROMOCION }o--o{ PEDIDO : aplica_a

    CLIENTE ||--o{ RESENA : escribe
    VARIANTE ||--o{ HISTORIAL_PRECIOS : tiene
    USUARIO ||--o{ LOG_AUDITORIA : genera
```
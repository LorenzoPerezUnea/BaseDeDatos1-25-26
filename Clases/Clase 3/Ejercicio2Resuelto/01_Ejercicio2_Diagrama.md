```mermaid
erDiagram

    %% --- Usuarios y roles ---
    USUARIO ||--o| CLIENTE : "puede ser"
    USUARIO ||--o| VENDEDOR : "puede ser"

    USUARIO {
        int usuario_id PK
        string nombre
        string email
        string contraseña
        string rol
    }

    CLIENTE {
        int cliente_id PK,FK
        string direccion
        string telefono
    }

    VENDEDOR {
        int vendedor_id PK,FK
        string reputacion
    }

    %% --- Productos ---
    PRODUCTO ||--o{ VARIANTE : "tiene"
    CATEGORIA ||--o{ PRODUCTO : "agrupa"
    CATEGORIA ||--o| CATEGORIA : "subcategoría"

    PRODUCTO {
        int producto_id PK
        string nombre
        string descripcion
        int categoria_id FK
    }

    VARIANTE {
        int variante_id PK
        int producto_id FK
        string talla
        string color
        string SKU
        float precio_actual
    }

    CATEGORIA {
        int categoria_id PK
        string nombre
        int categoria_padre_id FK
    }

    %% --- Almacenes e inventario ---
    VENDEDOR ||--o{ ALMACEN : "posee"
    ALMACEN ||--o{ INVENTARIO : "mantiene"
    VARIANTE ||--o{ INVENTARIO : "se almacena"

    ALMACEN {
        int almacen_id PK
        int vendedor_id FK
        string ubicacion
    }

    INVENTARIO {
        int inventario_id PK
        int variante_id FK
        int almacen_id FK
        int cantidad_disponible
    }

    %% --- Pedidos ---
    CLIENTE ||--o{ PEDIDO : "realiza"
    PEDIDO ||--o{ LINEAPEDIDO : "contiene"
    LINEAPEDIDO }o--|| VARIANTE : "corresponde a"

    PEDIDO ||--o{ ENVIO : "se divide en"
    PEDIDO ||--o{ PAGO : "genera"

    PEDIDO {
        int pedido_id PK
        int cliente_id FK
        date fecha_creacion
        string estado
        float total
    }

    LINEAPEDIDO {
        int linea_id PK
        int pedido_id FK
        int variante_id FK
        int cantidad
        float precio_unitario
    }

    ENVIO {
        int envio_id PK
        int pedido_id FK
        string estado_envio
        string transportista
        string tracking
    }

    %% --- Pagos ---
    PAGO ||--o{ REEMBOLSO : "puede tener"
    PAGO }o--|| METODOPAGO : "usa"

    PAGO {
        int pago_id PK
        int pedido_id FK
        int metodo_pago_id FK
        string estado
        float monto
        date fecha
    }

    METODOPAGO {
        int metodo_pago_id PK
        string tipo
    }

    REEMBOLSO {
        int reembolso_id PK
        int pago_id FK
        float monto
        date fecha
        string estado
    }

    %% --- Devoluciones ---
    LINEAPEDIDO ||--o{ DEVOLUCION : "puede tener"
    DEVOLUCION }o--|| REEMBOLSO : "puede generar"

    DEVOLUCION {
        int devolucion_id PK
        int linea_id FK
        string motivo
        string estado
        string nota_credito
        int reembolso_id FK
    }

    %% --- Promociones ---
    PROMOCION {
        int promo_id PK
        string tipo
        string condicion_minima
        float descuento
        date fecha_inicio
        date fecha_fin
    }

    PRODUCTO }o--o{ PROMOCION : "aplicable"
    CATEGORIA }o--o{ PROMOCION : "aplicable"
    VENDEDOR }o--o{ PROMOCION : "aplicable"
    PEDIDO }o--o{ PROMOCION : "aplicable"

    %% --- Reseñas ---
    CLIENTE ||--o{ RESENA : "escribe"
    PRODUCTO ||--o{ RESENA : "recibe"

    RESENA {
        int resena_id PK
        int cliente_id FK
        int producto_id FK
        int rating
        string comentario
        date fecha
    }

    %% --- Historial de precios ---
    VARIANTE ||--o{ HISTORIALPRECIO : "registra"

    HISTORIALPRECIO {
        int historial_id PK
        int variante_id FK
        float precio
        date fecha_inicio
        date fecha_fin
    }

    %% --- Logs de auditoría ---
    USUARIO ||--o{ LOG : "realiza"

    LOG {
        int log_id PK
        int usuario_id FK
        string entidad_afectada
        string tipo_cambio
        date fecha
        string detalle
    }

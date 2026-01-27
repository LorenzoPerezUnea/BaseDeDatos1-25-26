# DER Conceptual

```mermaid
erDiagram
    CLIENTE ||--o{ CONTRATO : "contrata"
    CONTRATO }o--|| EMPLEADO : "es atendido por"
    CONTRATO }o--o{ SERVICIO : "incluye"

    CLIENTE {
        int id_cliente
        string nombre
        string direccion
        string telefono
    }

    PERSONA {
        string dni
        date fecha_nacimiento
    }
    PERSONA ||--|| CLIENTE : "es un"

    EMPRESA {
        string cif
        string razon_social
    }
    EMPRESA ||--|| CLIENTE : "es un"

    EMPLEADO {
        int id_empleado
        string nombre
        string cargo
    }

    TECNICO {
        string especialidad
    }
    TECNICO ||--|| EMPLEADO : "es un"

    ADMINISTRATIVO {
        string departamento
    }
    ADMINISTRATIVO ||--|| EMPLEADO : "es un"

    SERVICIO {
        int id_servicio
        string nombre
        string tipo
        decimal precio
    }

    CONTRATO {
        int id_contrato
        date fecha_inicio
        date fecha_fin
        string estado
    }
```


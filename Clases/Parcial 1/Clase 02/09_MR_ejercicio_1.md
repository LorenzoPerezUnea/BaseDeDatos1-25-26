# 📊 DER Físico (Modelo Relacional) en Mermaid

```mermaid
erDiagram
    CLIENTE ||--o{ CONTRATO : "tiene"
    EMPLEADO ||--o{ CONTRATO : "atiende"
    CONTRATO ||--o{ DETALLE_CONTRATO : "tiene"
    SERVICIO ||--o{ DETALLE_CONTRATO : "aparece en"
    CLIENTE ||--|| PERSONA : "es una"
    CLIENTE ||--|| EMPRESA : "es una"
    EMPLEADO ||--|| TECNICO : "es un"
    EMPLEADO ||--|| ADMINISTRATIVO : "es un"

    CLIENTE {
        int id_cliente PK
        string nombre
        string direccion
        string telefono
        string tipo_cliente
    }

    PERSONA {
        int id_cliente PK, FK
        date fecha_nacimiento
        string dni
    }

    EMPRESA {
        int id_cliente PK, FK
        string razon_social
        string cif
    }

    CONTRATO {
        int id_contrato PK
        date fecha_inicio
        date fecha_fin
        string estado
        int id_cliente FK
        int id_empleado FK
    }

    EMPLEADO {
        int id_empleado PK
        string nombre
        string cargo
        string tipo_empleado
    }

    TECNICO {
        int id_empleado PK, FK
        string especialidad
    }

    ADMINISTRATIVO {
        int id_empleado PK, FK
        string departamento
    }

    SERVICIO {
        int id_servicio PK
        string nombre
        string tipo
        decimal precio
    }

    DETALLE_CONTRATO {
        int id_contrato FK
        int id_servicio FK
        int cantidad
    }
```

---

### 🔑 Explicación de la Transformación

1. **Jerarquías eliminadas:**
   
   - `Persona` y `Empresa` → se representarán como columnas opcionales o como una tabla extendida según el enfoque (Single Table Inheritance o varias tablas).
   - `Técnico` y `Administrativo` → igual, se pueden manejar con un atributo `tipo_empleado` + columnas opcionales, o tablas separadas.
2. **Relación N:M entre Contrato y Servicio:**
   
   - Se creó la tabla intermedia **DETALLE_CONTRATO** con **FK a Contrato y Servicio**, más el atributo `cantidad`.
3. **Claves foráneas en CONTRATO:**
   
   - `id_cliente` para ligar con CLIENTE.
   - `id_empleado` para ligar con EMPLEADO.
4. **Relaciones renombradas** para indicar acción desde la perspectiva física:
   
   - Cliente → Contrato = "tiene"
   - Empleado → Contrato = "atiende"


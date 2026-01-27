# DER Físico – Plataforma de Fitness

```mermaid
erDiagram
    %% ==== RELACIONES ====
    USUARIO ||--|| PERFIL : "tiene"
    USUARIO ||--o{ PROGRESO : "registra"
    USUARIO ||--o{ USUARIO_GRUPO : "pertenece"
    GRUPO ||--o{ USUARIO_GRUPO : "tiene"
    USUARIO ||--o{ USUARIO_RUTINA : "sigue"
    RUTINA ||--o{ USUARIO_RUTINA : "seguida por"
    ENTRENADOR ||--o{ RUTINA : "crea"
    RUTINA }o--|| CATEGORIA : "pertenece a"
    PRODUCTO }o--|| CATEGORIA : "pertenece a"
    USUARIO ||--o{ COMPRA : "compra"
    COMPRA }o--|| PRODUCTO : "de"
    USUARIO ||--o{ RESENA : "escribe"
    RESENA }o--|| PRODUCTO : "sobre"
    RESENA }o--|| RUTINA : "sobre"
    RESENA }o--|| ENTRENADOR : "sobre"

    %% ==== TABLAS ====
    USUARIO {
        int id_usuario
        string nombre
        string email
        date fecha_nacimiento
        string telefono
        string direccion
    }

    PERFIL {
        int id_perfil
        int id_usuario
        float altura
        float peso
        string objetivos
        string preferencias
    }

    ENTRENADOR {
        int id_entrenador
        int id_usuario
        string especialidad
        string certificaciones
        string tipo_entrenador
        string bio
    }

    RUTINA {
        int id_rutina
        int id_entrenador
        string nombre
        string descripcion
        int duracion
        string nivel_dificultad
        int id_categoria
    }

    USUARIO_RUTINA {
        int id_usuario
        int id_rutina
        date fecha_inicio
        string estado
    }

    PROGRESO {
        int id_progreso
        int id_usuario
        int id_rutina
        date fecha
        float peso
        int repeticiones
        string notas
    }

    PRODUCTO {
        int id_producto
        string nombre
        string descripcion
        string tipo
        decimal precio
        int stock
        int id_categoria
    }

    COMPRA {
        int id_compra
        int id_usuario
        int id_producto
        int cantidad
        decimal precio_comprado
        date fecha_compra
    }

    RESENA {
        int id_resena PK
        int id_usuario FK
        int id_rutina FK
        int id_producto FK
        int id_entrenador FK
        string contenido
        int calificacion
        date fecha
    }

    GRUPO {
        int id_grupo
        string nombre
        string descripcion
        string privacidad
    }

    USUARIO_GRUPO {
        int id_usuario
        int id_grupo
        date fecha_union
    }

    CATEGORIA {
        int id_categoria
        string nombre
        string descripcion
        int id_parent_categoria
    }
```

---

### Transformación

**Herencia resuelta con FK:**

- `ENTRENADOR.id_usuario` referencia a `USUARIO`.

**Relaciones N:M resueltas con tablas intermedias:**

- `USUARIO_RUTINA`, `USUARIO_PRODUCTO`, `USUARIO_GRUPO`.
- Cada una incluye FKs + atributos propios (por ejemplo, `fecha_inicio` para saber desde cuándo sigue la rutina).

**Relaciones 1:N:**

- `PERFIL.id_usuario` → un usuario puede tener varios perfiles (o uno según reglas).
- `RUTINA.id_entrenador` → una rutina la crea un entrenador.
- `RESEÑA.id_usuario` y `RESEÑA.id_entrenador` → se puede saber quién escribió y a quién va dirigida.

**Integridad referencial explícita:**
Todas las tablas con FK están claramente ligadas a su tabla padre.

**CATEGORIA reutilizada**

- Tanto `RUTINA` como `PRODUCTO` se ligan a `CATEGORIA` vía FK → evita duplicar categorías.

**Nutricionista y Personal Trainer como tipo_entrenador**

- El campo  tipo_entrenador incluirá : personal_trainer | nutricionista | otro


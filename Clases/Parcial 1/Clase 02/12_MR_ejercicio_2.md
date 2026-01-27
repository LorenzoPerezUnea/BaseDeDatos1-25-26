# DER Físico (Modelo Relacional) – Plataforma de Torneos

```mermaid
erDiagram
    %% ==== RELACIONES PRINCIPALES ====
    USUARIO ||--o{ JUGADOR : "es"
    USUARIO ||--o{ ESPECTADOR : "es"
    JUGADOR ||--|| PERFIL : "tiene"
    JUGADOR ||--o{ TRANSMISION : "realiza"
    JUGADOR ||--o{ JUGADOR_FOLLOW : "sigue a"
    JUGADOR ||--o{ JUGADOR_FOLLOW : "es seguido por"
    JUGADOR ||--o{ JUGADOR_EQUIPO : "pertenece"
    EQUIPO ||--o{ JUGADOR_EQUIPO : "tiene"
    EQUIPO ||--o{ EQUIPO_TORNEO : "participa"
    TORNEO ||--o{ EQUIPO_TORNEO : "incluye"
    TORNEO ||--o{ PARTIDA : "contiene"
    PARTIDA ||--o{ PARTICIPACION_PARTIDA : "tiene participación"
    JUGADOR ||--o{ PARTICIPACION_PARTIDA : "participa en"
    EQUIPO ||--o{ PARTICIPACION_PARTIDA : "participa en"
    PARTIDA }o--|| JUEGO : "usa"
    ESPECTADOR ||--o{ DONACION : "realiza"
    ESPECTADOR ||--o{ COMENTARIO : "escribe"

    %% ==== TABLAS ====
    USUARIO {
        int id_usuario PK
        string email
        date fecha_registro
    }

    JUGADOR {
        int id_jugador PK
        int id_usuario FK
        string nickname
        int nivel
        int experiencia
    }

    JUGADOR_FOLLOW {
        int id_seguidor FK
        int id_seguido FK
        date fecha_follow
    }

    ESPECTADOR {
        int id_espectador PK
        int id_usuario FK
        string nickname
    }

    PERFIL {
        int id_perfil PK
        int id_jugador FK
        string avatar
        string bio
        string preferencias
        string redes_sociales
    }

    TRANSMISION {
        int id_transmision PK
        int id_jugador FK
        string titulo
        datetime fecha_hora
        int duracion
        int visualizaciones
    }

    EQUIPO {
        int id_equipo PK
        string nombre
        int ranking
    }

    JUGADOR_EQUIPO {
        int id_jugador FK
        int id_equipo FK
        date fecha_union
        date fecha_salida
    }

    TORNEO {
        int id_torneo PK
        string nombre
        datetime fecha_inicio
        datetime fecha_fin
        string premios
    }

    EQUIPO_TORNEO {
        int id_equipo FK
        int id_torneo FK
    }

    PARTIDA {
        int id_partida PK
        int id_torneo FK
        int id_juego FK
        datetime fecha_hora
        int duracion
        string resultado
    }

    PARTICIPACION_PARTIDA {
        int id_partida FK
        int id_jugador FK
        int id_equipo FK
        string resultado_parcial
        int puntos_obtenidos
    }

    JUEGO {
        int id_juego PK
        string nombre
        string genero
        string plataforma
    }

    DONACION {
        int id_donacion PK
        int id_espectador FK
        float monto
        datetime fecha_hora
    }

    COMENTARIO {
        int id_comentario PK
        int id_espectador FK
        string contenido
        datetime fecha_hora
    }
```

---

### Transformación

**Subtipos resueltos como tablas hijas**

- `JUGADOR` y `ESPECTADOR` tienen FK a `USUARIO`.
- Esto preserva la herencia y permite datos específicos de cada subtipo.

**Relaciones N:M convertidas en tablas intermedias:**

- `JUGADOR` ↔ `EQUIPO` → `JUGADOR_EQUIPO`
- `EQUIPO` ↔ `TORNEO` → `EQUIPO_TORNEO`
- `PARTIDA` ↔ `JUGADOR`/`EQUIPO` → `PARTICIPACION_PARTIDA` (N:M para permitir múltiples participantes por partida).

**Relaciones 1:N como FK:**

- `TRANSMISION.id_jugador`
- `PERFIL.id_jugador`
- `DONACION.id_espectador`
- `COMENTARIO.id_espectador`

**Integridad referencial explícita:**
Todas las tablas con FK están claramente ligadas a su tabla padre.


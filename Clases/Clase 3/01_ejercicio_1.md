## Plataforma de Eventos y Entradas (Eventos → Sesiones → Tickets)

1. El sistema gestiona **Eventos** (con nombre, descripción, lugar, fechas).
2. Un Evento puede tener **múltiples Sesiones** (fechas/horas distintas en mismo evento).
3. Cada Sesión tiene **Tipos de Ticket** (General, VIP, Early-bird) con precio y cantidad limitada por tipo.
4. **Asiento opcional**: algunas sesiones son numeradas (asientos), otras son libres (capacidad general).
5. Un **Cliente** compra uno o varios **Tickets** para una sesión — cada ticket es único y puede cambiar de estado (reservado, pagado, cancelado, usado).
6. Soportar **descuentos/promocodes** aplicables a sesiones específicas o tipo de ticket.
7. Registrar **Check-in** cuando el asistente usa el ticket; no se puede volver a usar.
8. Posibilidad de **reembolso parcial** con reglas (plazo para devolución, comisión).
9. **Reseñas** del evento por asistentes después de la sesión.
10. Necesidad de reportes: ocupación por sesión, ingresos por evento, tickets vendidos por tipo.

# Ejercicio: Plataforma de Eventos y Entradas

## 1. Lista Predefinida de Requisitos

- El sistema gestiona **Eventos** (con nombre, descripción, lugar, fechas).
- Un **Evento** puede tener múltiples **Sesiones** (fechas/horas distintas).
- Cada **Sesión** tiene **Tipos de Ticket** (General, VIP, Early-bird) con precio y cantidad limitada.
- Algunas sesiones tienen **asientos numerados**, otras son de **capacidad general**.
- Un **Cliente** puede comprar uno o varios **Tickets** únicos para una sesión.
- Cada **Ticket** cambia de estado: `reservado`, `pagado`, `cancelado`, `usado`.
- Soporte para **Descuentos/Promocodes** aplicables a sesiones o tipos de tickets.
- Se debe registrar el **Check-in** cuando se usa un ticket (una sola vez).
- Posibilidad de **reembolso parcial** (con reglas: plazo, comisión).
- Los **asistentes pueden dejar reseñas** de eventos luego de asistir.
- Generación de **reportes**: ocupación por sesión, ingresos por evento, tickets vendidos por tipo.

---

## 2. Identificación de Entidades

- `EVENTO`: Información general del evento.
- `SESION`: Fechas/horarios distintos dentro de un evento.
- `TICKET`: Entrada individual para una sesión, con estado y precio.
- `TIPO_TICKET`: Tipo de entrada (General, VIP, Early-bird).
- `CLIENTE`: Persona que compra tickets.
- `DESCUENTO`: Promocodes o descuentos aplicables.
- `CHECKIN`: Registro de uso de ticket.
- `REEMBOLSO`: Solicitudes de devolución de dinero.
- `RESEÑA`: Opiniones de los clientes sobre eventos.
- `ASIENTO`: Asiento numerado en sesiones que lo requieran.

---

## 3. Identificación de Relaciones

- **EVENTO – SESION**: 1:N  
  Un evento puede tener muchas sesiones.

- **SESION – TICKET**: 1:N  
  Una sesión puede tener muchos tickets.

- **TICKET – TIPO_TICKET**: N:1  
  Cada ticket pertenece a un tipo.

- **CLIENTE – TICKET**: 1:N  
  Un cliente puede comprar múltiples tickets.

- **TICKET – DESCUENTO**: N:M  
  Un ticket puede tener múltiples descuentos aplicables.

- **CLIENTE – CHECKIN**: 1:N  
  Un cliente puede tener múltiples registros de check-in.

- **EVENTO – RESEÑA**: 1:N  
  Un evento puede tener muchas reseñas.

- **CLIENTE – RESEÑA**: 1:N  
  Un cliente puede dejar muchas reseñas.

- **TICKET – REEMBOLSO**: 1:1  
  Un ticket puede tener un único reembolso (si aplica).

- **SESION – ASIENTO**: 1:N  
  Una sesión puede tener múltiples asientos (si es numerada).

---

## 4. Identificación de Atributos

### EVENTO
- `id_evento`
- `nombre`
- `descripcion`
- `lugar`
- `fecha_inicio`
- `fecha_fin`

### SESION
- `id_sesion`
- `id_evento`
- `fecha_hora`
- `tipo_sesion` (numerada / general)

### TICKET
- `id_ticket`
- `id_sesion`
- `id_cliente`
- `id_tipo_ticket`
- `estado` (reservado, pagado, cancelado, usado)
- `precio`

### TIPO_TICKET
- `id_tipo_ticket`
- `nombre` (General, VIP, Early-bird)
- `precio`
- `cantidad_disponible`

### CLIENTE
- `id_cliente`
- `nombre`
- `email`
- `telefono`
- `direccion`

### DESCUENTO
- `id_descuento`
- `tipo_descuento` (porcentaje / cantidad fija)
- `valor`
- `aplicable_a_sesion` (opcional)
- `aplicable_a_tipo_ticket` (opcional)
- `fecha_inicio`
- `fecha_fin`

### CHECKIN
- `id_checkin`
- `id_ticket`
- `fecha_hora_checkin`

### REEMBOLSO
- `id_reembolso`
- `id_ticket`
- `fecha_solicitud`
- `estado` (pendiente, aprobado, rechazado)
- `monto_reembolsado`
- `comision`

### RESEÑA
- `id_resena`
- `id_evento`
- `id_cliente`
- `puntuacion`
- `contenido`
- `fecha`

### ASIENTO
- `id_asiento`
- `id_sesion`
- `numero_asiento`
- `estado` (disponible, reservado, ocupado)

---

## 5. Jerarquías / Generalizaciones

- `TICKET` puede ser extendido a subtipos según el `TIPO_TICKET` (VIP, General, Early-bird).
- `CLIENTE` podría ser una generalización futura para roles adicionales (como organizadores o admins).
- `SESION` puede tener una relación opcional con `ASIENTO` si es numerada.

---

``` mermaid
erDiagram
    EVENTO ||--o{ SESION : "tiene"
    SESION ||--o{ TICKET : "genera"
    TICKET }o--|| TIPO_TICKET : "pertenece"
    CLIENTE ||--o{ TICKET : "compra"
    TICKET }o--o{ DESCUENTO : "aplica"
    CLIENTE ||--o{ CHECKIN : "registra"
    TICKET ||--|| CHECKIN : "se usa en"
    EVENTO ||--o{ RESENA : "recibe"
    CLIENTE ||--o{ RESENA : "escribe"
    TICKET ||--|| REEMBOLSO : "puede tener"
    SESION ||--o{ ASIENTO : "incluye"

    EVENTO {
        int id_evento
        string nombre
        string descripcion
        string lugar
        date fecha_inicio
        date fecha_fin
    }

    SESION {
        int id_sesion
        int id_evento
        datetime fecha_hora
        string tipo_sesion
    }

    TICKET {
        int id_ticket
        int id_sesion
        int id_cliente
        int id_tipo_ticket
        string estado
        float precio
    }

    TIPO_TICKET {
        int id_tipo_ticket
        string nombre
        float precio
        int cantidad_disponible
    }

    CLIENTE {
        int id_cliente
        string nombre
        string email
        string telefono
        string direccion
    }

    DESCUENTO {
        int id_descuento
        string tipo_descuento
        float valor
        int aplicable_a_sesion
        int aplicable_a_tipo_ticket
        date fecha_inicio
        date fecha_fin
    }

    CHECKIN {
        int id_checkin
        int id_ticket
        datetime fecha_hora_checkin
    }

    REEMBOLSO {
        int id_reembolso
        int id_ticket
        date fecha_solicitud
        string estado
        float monto_reembolsado
        float comision
    }

    RESENA {
        int id_resena
        int id_evento
        int id_cliente
        int puntuacion
        string contenido
        date fecha
    }

    ASIENTO {
        int id_asiento
        int id_sesion
        string numero_asiento
        string estado
    }

```
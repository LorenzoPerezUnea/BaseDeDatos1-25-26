# Plataforma de Eventos y Entradas  
Modelo Conceptual de Base de Datos

## Identificación de Entidades 
- Evento
- Sesion 
- TipoTicket
- Ticket
- Cliente
- Promocion
- PromocionSesionTipoTicket\
- Reembolso
- Resena

## Identificación de Atributos 

| **Entidad** | **Atributos** |
|------------|----------------|
| **Evento** | id_evento, nombre, descripcion, lugar, fecha_inicio, fecha_fin |
| **Sesion** | id_sesion, id_evento, fecha, hora, es_numerada, capacidad |
| **TipoTicket** | id_tipo_ticket, id_sesion, nombre, precio, cantidad_total, cantidad_disponible |
| **Ticket** | id_ticket, id_tipo_ticket, id_cliente, estado, asiento, check_in |
| **Cliente** | id_cliente, nombre, email, telefono |
| **Promocion** | id_promocion, codigo, descripcion, descuento, fecha_inicio, fecha_fin |
| **PromocionSesionTipoTicket** | id_promocion, id_tipo_ticket |
| **Reembolso** | id_reembolso, id_ticket, fecha_solicitud, monto_devuelto, comision, estado |
| **Resena** | id_resena, id_evento, id_cliente, calificacion, comentario, fecha |
---

## 🔗 Identificación de Relaciones y Cardinalidades

- Evento 1 ─── N Sesion  
- Sesion 1 ─── N TipoTicket  
- TipoTicket 1 ─── N Ticket  
- Cliente 1 ─── N Ticket  
- Promocion N ─── N TipoTicket (a través de PromocionSesionTipoTicket)  
- Ticket 1 ─── 0..1 Reembolso  
- Cliente 1 ─── N Resena  
- Evento 1 ─── N Resena  

---

## 📝 Diagrama Chen (Mermaid)

```mermaid
erDiagram
    EVENTO ||--o{ SESION : "tiene"
    SESION ||--o{ TIPOTICKET : "define"
    TIPOTICKET ||--o{ TICKET : "genera"
    CLIENTE ||--o{ TICKET : "compra"
    TICKET ||--o| REEMBOLSO : "puede tener"
    CLIENTE ||--o{ RESENA : "escribe"
    EVENTO ||--o{ RESENA : "recibe"
    PROMOCION ||--o{ PROMOCIONSESIONTIPOTICKET : "aplica a"
    TIPOTICKET ||--o{ PROMOCIONSESIONTIPOTICKET : "puede tener"

    EVENTO {
        int id_evento PK
        string nombre
        string descripcion
        string lugar
        date fecha_inicio
        date fecha_fin
    }

    SESION {
        int id_sesion PK
        int id_evento FK
        date fecha
        time hora
        boolean es_numerada
        int capacidad
    }

    TIPOTICKET {
        int id_tipo_ticket PK
        int id_sesion FK
        string nombre
        decimal precio
        int cantidad_total
        int cantidad_disponible
    }

    TICKET {
        int id_ticket PK
        int id_tipo_ticket FK
        int id_cliente FK
        string estado
        string asiento
        datetime check_in
    }

    CLIENTE {
        int id_cliente PK
        string nombre
        string email
        string telefono
    }

    PROMOCION {
        int id_promocion PK
        string codigo
        string descripcion
        decimal descuento
        date fecha_inicio
        date fecha_fin
    }

    PROMOCIONSESIONTIPOTICKET {
        int id_promocion FK
        int id_tipo_ticket FK
    }

    REEMBOLSO {
        int id_reembolso PK
        int id_ticket FK
        date fecha_solicitud
        decimal monto_devuelto
        decimal comision
        string estado
    }

    RESENA {
        int id_resena PK
        int id_evento FK
        int id_cliente FK
        int calificacion
        string comentario
        date fecha
    }
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


## 1. Lista predefinida de requisitos
1. El sistema gestiona **Eventos** con su nombre, descripción, lugar y rango de fechas.  
2. Cada **Evento** puede tener **múltiples Sesiones**, cada una con fecha y hora.  
3. En cada **Sesión** se definen distintos **Tipos de Ticket** (General, VIP, Early-bird), cada uno con precio y cupo.  
4. Una **Sesión** puede ser numerada (con asientos concretos) o libre (capacidad general).  
5. Un **Cliente** puede comprar uno o varios **Tickets**; cada ticket es único y pasa por distintos estados: reservado, pagado, cancelado, usado.  
6. Los **Pagos** permiten registrar la liquidación de los tickets (importe, fecha, método de pago, referencia). Un ticket puede tener más de un pago (ej. cuotas).  
7. Se contemplan **Promocodes**, que ofrecen descuentos aplicables a sesiones o tipos de ticket.  
8. Pueden existir **Reembolsos**, totales o parciales, asociados a tickets.  
9. Los **Clientes** pueden escribir **Reseñas** sobre un evento después de asistir.  
10. El sistema genera **reportes**: ocupación por sesión, ingresos por evento, tickets vendidos por tipo.  

---

## 2. Identificación de Entidades
- **Evento**  
- **Sesión**  
- **TipoTicket**  
- **Ticket**  
- **Cliente**  
- **Asiento**  
- **Promocode**  
- **Pago**  
- **Reembolso**  
- **Reseña**  

---

## 3. Identificación de Relaciones y Cardinalidades
- Un **Evento (1)** tiene **(1..N) Sesiones**.  
- Una **Sesión (1)** define **(1..N) Tipos de Ticket**.  
- Una **Sesión (1)** vende **(0..N) Tickets**.  
- Un **TipoTicket (1)** clasifica **(0..N) Tickets**.  
- Un **Cliente (1)** posee **(0..N) Tickets**.  
- Una **Sesión (1)** ofrece **(0..N) Asientos** (si es numerada).  
- Un **Asiento (1)** puede estar asignado a **(0..1) Ticket**.  
- Un **Promocode (1)** se aplica a **(0..N) Sesiones**.  
- Un **Promocode (1)** se aplica a **(0..N) Tipos de Ticket**.  
- Un **Ticket (0..N)** puede usar **(0..N) Promocodes** → relación **N:M**.  
- Un **Ticket (1)** se paga con **(1..N) Pagos**.  
- Un **Ticket (1)** puede tener **(0..N) Reembolsos**.  
- Un **Cliente (1)** escribe **(0..N) Reseñas**.  
- Un **Evento (1)** recibe **(0..N) Reseñas**.  

---

## 4. Identificación de Atributos
**Evento**  
- nombre  
- descripción  
- lugar  
- fecha_inicio  
- fecha_fin  

**Sesión**  
- fecha_hora_inicio  
- fecha_hora_fin  
- es_numerada (sí/no)  
- capacidad_general (si no hay asientos numerados)  

**TipoTicket**  
- nombre_tipo (General, VIP, Early-bird)  
- precio  
- cupo  

**Ticket**  
- código único (QR o de barras)  
- estado (reservado, pagado, cancelado, usado)  
- fecha_compra  
- importe_pagado  

**Cliente**  
- nombre  
- email  
- teléfono  

**Asiento**  
- sección  
- fila  
- número  
- accesibilidad (sí/no)  

**Promocode**  
- código único  
- tipo_descuento (porcentaje o monto fijo)  
- valor  
- fecha_inicio  
- fecha_fin  
- límite de uso  

**Pago**  
- fecha_pago  
- importe  
- método_pago (tarjeta, PayPal, etc.)  
- referencia  

**Reembolso**  
- monto  
- motivo  
- fecha_solicitud  
- fecha_aprobacion  
- comisión  
- estado (solicitado, aprobado, rechazado, abonado)  

**Reseña**  
- calificación (1–5)  
- comentario  
- fecha  

---

## 5. Jerarquías / Generalizaciones

- `TICKET` puede ser extendido a subtipos según el `TIPO_TICKET` (VIP, General, Early-bird).  
- `CLIENTE` podría ser una generalización futura para roles adicionales (como organizadores o admins).  
- `SESION` puede tener una relación opcional con `ASIENTO` si es numerada.  

---

## 6. Diagrama de Chen en Mermaid

```mermaid
erDiagram
    EVENTO ||--o{ SESION : "tiene"
    SESION ||--o{ TICKET : "genera"
    TICKET }o--|| TIPO_TICKET : "pertenece"
    CLIENTE ||--o{ TICKET : "compra"
    TICKET }o--o{ DESCUENTO : "aplica"
    TICKET ||--o{ PAGO : "se paga con"
    EVENTO ||--o{ RESENA : "recibe"
    CLIENTE ||--o{ RESENA : "escribe"
    TICKET ||--o{ REEMBOLSO : "puede tener"
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

    PAGO {
        int id_pago
        int id_ticket
        date fecha_pago
        float importe
        string metodo_pago
        string referencia
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
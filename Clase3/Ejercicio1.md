## 1. Lista Predefinida de Requisitos

1. Gestión de **Eventos** con nombre, descripción, lugar y fechas.  
2. Un Evento puede tener **múltiples Sesiones** (fechas/horas distintas).  
3. Cada Sesión tiene **Tipos de Ticket** (General, VIP, Early-bird) con precio y cantidad limitada.  
4. **Asientos opcionales**: numerados o libres (capacidad general).  
5. Un **Cliente** puede comprar uno o varios **Tickets**; cada ticket es único y tiene estados: reservado, pagado, cancelado, usado.  
6. Soportar **descuentos/promocodes** aplicables a sesiones específicas o tipo de ticket.  
7. Registrar **Check-in** al asistir; un ticket no puede volver a usarse.  
8. **Reembolsos parciales** con reglas de plazo y comisión.  
9. **Reseñas** de eventos por los asistentes después de la sesión.  
10. Generación de **reportes**: ocupación por sesión, ingresos por evento, tickets vendidos por tipo.

---

## 2. Identificación de Entidades

- **EVENTO**  
- **SESION**  
- **TIPO_TICKET**  
- **ASIENTO**  
- **CLIENTE**  
- **TICKET**  
- **PAGO**  
- **REEMBOLSO**  
- **DESCUENTO**  
- **CHECKIN**  
- **RESEÑA**

---

## 3. Identificación de Relaciones

| Entidad A | Entidad B | Cardinalidad | Verbo / Descripción |
|------------|-----------|-------------|-------------------|
| Evento | Sesión | 1:N | Evento **tiene** Sesiones |
| Sesión | Tipo_Ticket | 1:N | Sesión **ofrece** Tipos de Ticket |
| Sesión | Asiento | 1:N (opcional) | Sesión **contiene** Asientos |
| Sesión | Ticket | 1:N | Sesión **genera** Tickets |
| Cliente | Ticket | 1:N | Cliente **compra** Tickets |
| Ticket | Pago | 1:1 | Ticket **se paga con** Pago |
| Pago | Reembolso | 1:N | Pago **genera** Reembolsos |
| Ticket | Descuento | N:1 (opcional) | Ticket **aplica** Descuento |
| Ticket | Checkin | 1:1 (opcional) | Ticket **genera** Check-in |
| Cliente | Reseña | 1:N | Cliente **escribe** Reseñas |
| Evento | Reseña | 1:N | Evento **recibe** Reseñas |

---

## 4. Identificación de Atributos (Nivel Conceptual)

### EVENTO
- id_evento (PK)  
- nombre  
- descripcion  
- lugar  
- fecha_inicio  
- fecha_fin  

### SESION
- id_sesion (PK)  
- id_evento (FK)  
- fecha  
- hora  
- capacidad  

### TIPO_TICKET
- id_tipo_ticket (PK)  
- id_sesion (FK)  
- nombre_tipo  
- precio  
- cantidad_max  

### ASIENTO
- id_asiento (PK)  
- id_sesion (FK)  
- fila  
- numero  
- estado  

### CLIENTE
- id_cliente (PK)  
- nombre  
- email  
- telefono  

### DESCUENTO
- id_descuento (PK)  
- codigo  
- porcentaje  
- valido_desde  
- valido_hasta  

### TICKET
- id_ticket (PK)  
- id_cliente (FK)  
- id_sesion (FK)  
- id_tipo_ticket (FK)  
- id_asiento (FK, nullable)  
- id_descuento (FK, nullable)  
- estado  

### PAGO
- id_pago (PK)  
- id_ticket (FK)  
- monto_pagado  
- fecha_pago  
- metodo_pago  
- estado_pago  

### REEMBOLSO
- id_reembolso (PK)  
- id_pago (FK)  
- monto_devuelto  
- fecha_reembolso  
- motivo  
- porcentaje_comision  

### CHECKIN
- id_checkin (PK)  
- id_ticket (FK)  
- fecha_checkin  
- validado_por  

### RESEÑA
- id_resena (PK)  
- id_cliente (FK)  
- id_evento (FK)  
- calificacion  
- comentario  
- fecha_resena  

---

## 5. Jerarquías / Generalizaciones

1. **Ticket**
   - **Ticket numerado**: asignado a asiento específico.  
   - **Ticket libre**: no asigna asiento (capacidad general).  

2. **Pago**
   - **Pago completado**  
   - **Pago con reembolso parcial**  
   - **Pago con reembolso total**  

3. **Descuento**
   - Aplicable a **tipo de ticket**  
   - Aplicable a **sesión completa** 
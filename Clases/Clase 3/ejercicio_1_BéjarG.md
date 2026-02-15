# Plataforma de Eventos y Entradas

## Entidades y Atributos

### Evento
- id_evento (PK)  
- nombre  
- descripción  
- lugar  
- fecha_inicio  
- fecha_fin  

### Sesión
- id_sesion (PK)  
- fecha  
- hora_inicio  
- hora_fin  
- es_numerada (boolean)  
- capacidad_total (nullable)  

### TipoTicket
- id_tipo_ticket (PK)  
- nombre_tipo (General, VIP, Early-bird, etc.)  
- precio  
- cantidad_disponible  

### Ticket
- id_ticket (PK)  
- estado (reservado, pagado, cancelado, usado)  
- asiento (nullable)  

### Cliente
- id_cliente (PK)  
- nombre  
- email  

### Promocode
- id_promocode (PK)  
- codigo  
- descuento (%) o monto fijo  
- fecha_inicio  
- fecha_fin  

### Check-in
- id_checkin (PK)  
- fecha_hora  

### Reembolso
- id_reembolso (PK)  
- fecha_solicitud  
- monto_devuelto  
- comision  
- motivo  

### Reseña
- id_resena (PK)  
- puntuacion (1–5)  
- comentario  
- fecha  


## Relaciones

- **Evento → Sesión** (1:N)  
- **Sesión → TipoTicket** (1:N)  
- **TipoTicket → Ticket** (1:N)  
- **Cliente → Ticket** (1:N)  
- **Ticket → Check-in** (1:1 opcional)  
- **Ticket → Reembolso** (1:1 opcional)  
- **Evento → Reseña** (1:N)  
- **Cliente → Reseña** (1:N)  
- **Promocode → Sesión/TipoTicket** (N:M)  

---

## Reportes

El sistema debe generar:
- **Ocupación por sesión** (tickets vendidos vs capacidad)  
- **Ingresos por evento** (total monetario por venta de tickets)  
- **Tickets vendidos por tipo** (General, VIP, Early-bird, etc.)  
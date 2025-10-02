# Taller de Ejercicios de Álgebra Relacional

## Relaciones Base

### EMPLEADO

| id_empleado | nombre     | depto   | salario | id_depto |
|--------------|------------|----------|----------|-----------|
| 1 | Ana Torres  | Ventas   | 2500 | 10 |
| 2 | Luis Pérez  | Finanzas | 1800 | 20 |
| 3 | Marta Díaz  | Ventas   | 2100 | 10 |
| 4 | Pedro Gómez | IT       | 3200 | 30 |
| 5 | Laura Ruiz  | Finanzas | 2600 | 20 |

---

### DEPARTAMENTO

| id_depto | nombre_depto | ciudad     | presupuesto | jefe |
|-----------|---------------|-------------|-------------|------|
| 10 | Ventas   | Madrid     | 200000 | Ana Torres |
| 20 | Finanzas | Sevilla    | 150000 | Laura Ruiz |
| 30 | IT       | Barcelona  | 250000 | Pedro Gómez |

---

### CLIENTE

| id_cliente | nombre       | ciudad     | edad | tipo |
|-------------|--------------|-------------|------|------|
| 1 | Carlos Vega   | Madrid     | 25 | Premium |
| 2 | Sofía López   | Sevilla    | 31 | Estándar |
| 3 | Javier Ramos  | Valencia   | 22 | Premium |
| 4 | Elena Navarro | Madrid     | 27 | Estándar |
| 5 | Diego Morales | Bilbao     | 35 | Premium |

---

### PRODUCTO

| id_producto | nombre       | categoria     | precio | stock |
|--------------|--------------|----------------|---------|--------|
| 101 | Portátil X      | Electrónica | 950 | 20 |
| 102 | Ratón Óptico    | Accesorios  | 25  | 120 |
| 103 | Auriculares Pro | Electrónica | 120 | 80 |
| 104 | Mochila Travel  | Accesorios  | 70  | 40 |
| 105 | Tablet Air      | Electrónica | 500 | 50 |

---

### PEDIDO

| id_pedido | id_cliente | fecha       | total | estado |
|------------|-------------|-------------|--------|---------|
| 1001 | 1 | 2024-03-15 | 1020 | Pagado |
| 1002 | 2 | 2024-03-22 | 95 | Pagado |
| 1003 | 3 | 2024-04-02 | 120 | Pendiente |
| 1004 | 4 | 2024-03-18 | 70 | Pagado |
| 1005 | 5 | 2024-04-10 | 950 | Pagado |

---

### DETALLE_PEDIDO

| id_pedido | id_producto | cantidad | descuento | subtotal |
|-------------|--------------|-----------|------------|------------|
| 1001 | 101 | 1 | 0 | 950 |
| 1001 | 102 | 1 | 0 | 25 |
| 1002 | 104 | 1 | 0 | 70 |
| 1003 | 103 | 1 | 10 | 108 |
| 1004 | 104 | 1 | 0 | 70 |
| 1005 | 101 | 1 | 0 | 950 |

---

### CURSO

| id_curso | nombre        | profesor | tipo          | duracion |
|-----------|----------------|-----------|----------------|-----------|
| 11 | Base de Datos  | Rivera | Técnico       | 60 |
| 12 | Programación   | Molina | Técnico       | 70 |
| 13 | IA y Big Data  | Gómez  | Avanzado      | 80 |

---

### INSCRIPCION

| id_curso | id_estudiante |
|-----------|----------------|
| 11 | 1 |
| 11 | 2 |
| 12 | 1 |
| 12 | 3 |
| 13 | 1 |
| 13 | 3 |

---

### ASIGNACION

| id_empleado | id_proyecto |
|--------------|--------------|
| 1 | 100 |
| 1 | 200 |
| 2 | 100 |
| 3 | 200 |
| 4 | 300 |

---

### PROYECTO

| id_proyecto | nombre_proy | tipo          | cliente |
|--------------|--------------|----------------|----------|
| 100 | Alfa     | Nacional      | CEVISA |
| 200 | Beta     | Internacional | COMEX |
| 300 | Gamma    | Internacional | TERRA |


# Resolución Ejercicios 1–5 (con resultados parciales)

## Ejercicio 1 — Selección (σ) + Proyección (π)

Obtener los nombres y departamentos de los empleados con salario > 2000.

R1 := σ{salario > 2000}(EMPLEADO)
R2 := π{nombre, depto}(R1)

**Cálculo intermedio y resultado:**

R1 = σ{salario > 2000}(EMPLEADO)

| id_empleado | nombre      | depto    | salario | id_depto |
|-------------|-------------|----------|---------|----------|
| 1           | Ana Torres  | Ventas   | 2500    | 10       |
| 3           | Marta Díaz  | Ventas   | 2100    | 10       |
| 4           | Pedro Gómez | IT       | 3200    | 30       |
| 5           | Laura Ruiz  | Finanzas | 2600    | 20       |

R2 = π_{nombre, depto}(R1)

| nombre      | depto    |
|-------------|----------|
| Ana Torres  | Ventas   |
| Marta Díaz  | Ventas   |
| Pedro Gómez | IT       |
| Laura Ruiz  | Finanzas |

---

## Ejercicio 2 — Selección (σ) + Proyección (π) + Renombramiento (ρ)

Mostrar nombre y ciudad de los clientes menores de 30 años, renombrando el resultado como JOVENES.

R1 := σ{edad < 30}(CLIENTE)
R2 := π{nombre, ciudad}(R1)
JOVENES := ρ{JOVENES(nombre, ciudad)}(R2)

**Cálculo intermedio y resultado:**

R1 = σ{edad < 30}(CLIENTE)

| id_cliente | nombre        | ciudad   | edad | tipo    |
|------------|---------------|----------|------|---------|
| 1          | Carlos Vega   | Madrid   | 25   | Premium |
| 3          | Javier Ramos  | Valencia | 22   | Premium |
| 4          | Elena Navarro | Madrid   | 27   | Estándar|

R2 = π{nombre, ciudad}(R1)

| nombre        | ciudad   |
|---------------|----------|
| Carlos Vega   | Madrid   |
| Javier Ramos  | Valencia |
| Elena Navarro | Madrid   |

JOVENES (renombrada) = resultado final (misma tabla, nombre de relación JOVENES).

---

## Ejercicio 3 — Producto Cartesiano (×) + Selección (σ) + Proyección (π)

(simulación de JOIN)

Mostrar los nombres de los empleados junto al nombre del departamento donde trabajan.

R1 := EMPLEADO × DEPARTAMENTO
R2 := σ{EMPLEADO.id_depto = DEPARTAMENTO.id_depto}(R1)
R3 := π{EMPLEADO.nombre, DEPARTAMENTO.nombre_depto}(R2)

**Cálculo intermedio y resultado:**

R1 = EMPLEADO × DEPARTAMENTO (no mostramos la tabla completa del producto, directamente aplicamos la selección)

R2 = σ{EMPLEADO.id_depto = DEPARTAMENTO.id_depto}(EMPLEADO × DEPARTAMENTO)

| id_empleado | nombre      | depto    | salario | id_depto | id_depto_2 | nombre_depto | ciudad   | presupuesto | jefe       |
|-------------|-------------|----------|---------|----------|------------|--------------|----------|-------------|------------|
| 1           | Ana Torres  | Ventas   | 2500    | 10       | 10         | Ventas       | Madrid   | 200000      | Ana Torres |
| 2           | Luis Pérez  | Finanzas | 1800    | 20       | 20         | Finanzas     | Sevilla  | 150000      | Laura Ruiz |
| 3           | Marta Díaz  | Ventas   | 2100    | 10       | 10         | Ventas       | Madrid   | 200000      | Ana Torres |
| 4           | Pedro Gómez | IT       | 3200    | 30       | 30         | IT           | Barcelona| 250000      | Pedro Gómez|
| 5           | Laura Ruiz  | Finanzas | 2600    | 20       | 20         | Finanzas     | Sevilla  | 150000      | Laura Ruiz |

(Observa que `id_depto_2` viene de DEPARTAMENTO; es el mismo valor que EMPLEADO.id_depto cuando hay match)

R3 = π{EMPLEADO.nombre, DEPARTAMENTO.nombre_depto}(R2)

| nombre       | nombre_depto |
|--------------|--------------|
| Ana Torres   | Ventas       |
| Luis Pérez   | Finanzas     |
| Marta Díaz   | Ventas       |
| Pedro Gómez  | IT           |
| Laura Ruiz   | Finanzas     |

---

## Ejercicio 4 — Unión (∪) y Diferencia (−)

el enunciado pide CLIENTES_A y CLIENTES_B con misma estructura; definimos para el ejercicio:

CLIENTES_A

| id_cliente | nombre        |
|------------|---------------|
| 1          | Carlos Vega   |
| 2          | Sofía López   |
| 3          | Javier Ramos  |

CLIENTES_B

| id_cliente | nombre        |
|------------|---------------|
| 3          | Javier Ramos  |
| 4          | Elena Navarro |
| 5          | Diego Morales |

**Tareas y pasos:**

(1) Todos los clientes de A o B:
R1 := CLIENTES_A ∪ CLIENTES_B

(2) Clientes que solo pertenecen a A (A − B):
R2 := CLIENTES_A − CLIENTES_B

**Resultados:**

R1 = CLIENTES_A ∪ CLIENTES_B

| id_cliente | nombre        |
|------------|---------------|
| 1          | Carlos Vega   |
| 2          | Sofía López   |
| 3          | Javier Ramos  |
| 4          | Elena Navarro |
| 5          | Diego Morales |

R2 = CLIENTES_A − CLIENTES_B

| id_cliente | nombre      |
|------------|-------------|
| 1          | Carlos Vega |
| 2          | Sofía López |

---

## Ejercicio 5 — Join (⨝) + Selección (σ) + Proyección (π)

Mostrar los nombres de los clientes que compraron productos con precio > 100.

R1 := DETALLE_PEDIDO ⨝_{DETALLE_PEDIDO.id_producto = PRODUCTO.id_producto} PRODUCTO
R2 := σ{PRODUCTO.precio > 100}(R1)
R3 := π{id_pedido}(R2)
R4 := R3 ⨝{R3.id_pedido = PEDIDO.id_pedido} PEDIDO
R5 := R4 ⨝{R4.id_cliente = CLIENTE.id_cliente} CLIENTE
Resultado := π{CLIENTE.nombre, PEDIDO.id_pedido}(R5)

R1 = DETALLE_PEDIDO ⨝ PRODUCTO (añadimos precios)

| id_pedido | id_producto | cantidad | descuento | subtotal | nombre_producto  | categoria   | precio |
|-----------|-------------|----------|-----------|----------|------------------|-------------|--------|
| 1001      | 101         | 1        | 0         | 950      | Portátil X       | Electrónica | 950    |
| 1001      | 102         | 1        | 0         | 25       | Ratón Óptico     | Accesorios  | 25     |
| 1002      | 104         | 1        | 0         | 70       | Mochila Travel   | Accesorios  | 70     |
| 1003      | 103         | 1        | 10        | 108      | Auriculares Pro  | Electrónica | 120    |
| 1004      | 104         | 1        | 0         | 70       | Mochila Travel   | Accesorios  | 70     |
| 1005      | 101         | 1        | 0         | 950      | Portátil X       | Electrónica | 950    |

R2 = σ{precio > 100}(R1)

| id_pedido | id_producto | cantidad | descuento | subtotal | nombre_producto | categoria   | precio |
|-----------|-------------|----------|-----------|----------|-----------------|-------------|--------|
| 1001      | 101         | 1        | 0         | 950      | Portátil X      | Electrónica | 950    |
| 1003      | 103         | 1        | 10        | 108      | Auriculares Pro | Electrónica | 120    |
| 1005      | 101         | 1        | 0         | 950      | Portátil X      | Electrónica | 950    |

R3 = π{id_pedido}(R2)

| id_pedido |
|-----------|
| 1001      |
| 1003      |
| 1005      |

R4 = R3 ⨝ PEDIDO  (añadimos id_cliente)

| id_pedido | id_cliente | fecha      | total | estado    |
|-----------|-----------|------------|-------|-----------|
| 1001      | 1         | 2024-03-15 | 1020  | Pagado    |
| 1003      | 3         | 2024-04-02 | 120   | Pendiente |
| 1005      | 5         | 2024-04-10 | 950   | Pagado    |

R5 = R4 ⨝ CLIENTE  (añadimos datos del cliente)

| id_pedido | id_cliente | nombre        | ciudad   | fecha      | total | estado    |
|-----------|------------|---------------|----------|------------|-------|-----------|
| 1001      | 1          | Carlos Vega   | Madrid   | 2024-03-15 | 1020  | Pagado    |
| 1003      | 3          | Javier Ramos  | Valencia | 2024-04-02 | 120   | Pendiente |
| 1005      | 5          | Diego Morales | Bilbao   | 2024-04-10 | 950   | Pagado    |

Resultado = π{nombre, id_pedido}(R5)

| nombre        | id_pedido |
|---------------|-----------|
| Carlos Vega   | 1001      |
| Javier Ramos  | 1003      |
| Diego Morales | 1005      |


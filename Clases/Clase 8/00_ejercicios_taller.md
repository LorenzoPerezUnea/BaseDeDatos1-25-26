# Taller

## EMPLEADO

| id_empleado | nombre      |  salario | id_depto |
|--------------|-------------|----------|-----------|
| 1 | Ana Torres  | 2500 | 10 |
| 2 | Luis Pérez  |  1800 | 20 |
| 3 | Laura Ruiz  | 2600 | 20 |
| 4 | Pedro Gómez |3200 | 30 |


## DEPARTAMENTO

| id_depto | nombre_depto | ciudad     | presupuesto |
|-----------|---------------|-------------|-------------|
| 10 | Ventas   | Madrid     | 200000 |
| 20 | Finanzas | Sevilla    | 150000 |
| 30 | IT       | Barcelona  | 250000 |

## CLIENTE

| id_cliente | nombre       | ciudad     | edad | tipo     |
|-------------|--------------|-------------|------|----------|
| 1 | Carlos Vega   | Madrid     | 25 | Premium |
| 2 | Sofía López   | Sevilla    | 31 | Estándar |
| 3 | Javier Ramos  | Valencia   | 22 | Premium |
| 4 | Diego Morales | Bilbao     | 35 | Premium |

## PRODUCTO

| id_producto | nombre         | categoria     | precio | stock |
|--------------|----------------|----------------|---------|--------|
| 101 | Portátil X      | Electrónica | 950 | 20 |
| 102 | Ratón Óptico    | Accesorios  | 25  | 120 |
| 103 | Auriculares Pro | Electrónica | 120 | 80 |
| 104 | Mochila Travel  | Accesorios  | 70  | 40 |

## PEDIDO

| id_pedido | id_cliente | fecha       | total | estado   |
|------------|-------------|-------------|--------|----------|
| 1001 | 1 | 2024-03-15 | 975 | Pagado |
| 1002 | 2 | 2024-03-22 | 95 | Pagado |
| 1003 | 3 | 2024-04-02 | 120 | Pendiente |

## DETALLE_PEDIDO

| id_pedido | id_producto | cantidad | descuento | subtotal |
|-------------|--------------|-----------|------------|------------|
| 1001 | 101 | 1 | 0 | 950 |
| 1001 | 102 | 1 | 0 | 25 |
| 1002 | 104 | 1 | 0 | 70 |
| 1003 | 103 | 1 | 10 | 108 |

## PROYECTO

| id_proyecto | nombre_proy | tipo          | cliente |
|--------------|--------------|----------------|----------|
| 100 | Alfa     | Nacional      | CEVISA |
| 200 | Beta     | Internacional | COMEX |
| 300 | Gamma    | Internacional | TERRA |

## ASIGNACION

| id_empleado | id_proyecto |
|--------------|--------------|
| 1 | 100 |
| 1 | 200 |
| 2 | 100 |
| 3 | 200 |
| 4 | 300 |

---

## Ejercicio 1 — (Selección + Proyección + Renombramiento)

**Enunciado:**
Listar los nombres y salarios de los empleados del departamento “Finanzas” cuyo salario sea mayor a 2000, renombrando la relación final como `EMPLEADOS_FINANZAS`.

**Operaciones esperadas:**

- Selección (σ)
- Proyección (π)
- Renombramiento (ρ)

## Ejercicio 2 —  (Join + Selección múltiple)

**Enunciado:**
Mostrar los nombres de los clientes y los productos comprados con precio mayor a 100 **y** con un descuento aplicado distinto de cero.
El resultado debe mostrar: `nombre_cliente`, `nombre_producto`, `precio`, `descuento`.

**Operaciones esperadas:**

- Join (⨝)
- Selección (σ)
- Proyección (π)

## Ejercicio 3 — (Join + Diferencia + Unión)

**Enunciado:**
Encontrar los clientes que **compraron productos electrónicos**,
pero **no compraron accesorios**.
Además, incluir los clientes que **aún no han comprado nada**.

**Operaciones esperadas:**

- Join
- Diferencia
- Unión
- Proyección

## Ejercicio 4 —  (Join + División + Diferencia)

**Enunciado:**
Encontrar los empleados que **trabajaron en todos los proyectos** de tipo *Nacional*,
pero **no** en ningún proyecto *Internacional*.

**Operaciones esperadas:**

- Selección
- División
- Diferencia
- Join


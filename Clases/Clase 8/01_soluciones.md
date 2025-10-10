# Soluciones (ejercicios del taller) — con cerraduras parciales

## Ejercicio 1

**Enunciado:** Listar los nombres y salarios de los empleados del departamento “Finanzas” cuyo salario sea > 2000, renombrando la relación final como `EMPLEADOS_FINANZAS`.

R1 = σ{depto = 'Finanzas' ∧ salario > 2000}(EMPLEADO)

| id_empleado | nombre     | depto    | salario | id_depto |
|-------------|------------|----------|---------|----------|
| 3           | Laura Ruiz | Finanzas | 2600    | 20       |

R2 = π{nombre, salario}(R1)

| nombre     | salario |
|------------|---------|
| Laura Ruiz | 2600    |

EMPLEADOS_FINANZAS := ρ{EMPLEADOS_FINANZAS(nombre, salario)}(R2)

resultado final:

| nombre     | salario |
|------------|---------|
| Laura Ruiz | 2600    |

---

## Ejercicio 2

**Enunciado:** Mostrar los nombres de los clientes y los productos comprados con precio > 100 **y** con un descuento aplicado distinto de 0. Resultado: `nombre_cliente`, `nombre_producto`, `precio`, `descuento`.

R1 = DETALLE_PEDIDO ⨝ PRODUCTO

| id_pedido | id_producto | cantidad | descuento | subtotal | nombre_producto  | categoria   | precio |
|-----------|-------------|----------|-----------|----------|------------------|-------------|--------|
| 1001      | 101         | 1        | 0         | 950      | Portátil X       | Electrónica | 950    |
| 1001      | 102         | 1        | 0         | 25       | Ratón Óptico     | Accesorios  | 25     |
| 1002      | 104         | 1        | 0         | 70       | Mochila Travel   | Accesorios  | 70     |
| 1003      | 103         | 1        | 10        | 108      | Auriculares Pro  | Electrónica | 120    |

R2 = σ{precio > 100 ∧ descuento > 0}(R1)

| id_pedido | id_producto | descuento | nombre_producto  | categoria   | price |
|-----------|-------------|-----------|------------------|-------------|-------|
| 1003      | 103         | 10        | Auriculares Pro  | Electrónica | 120   |

R3 = R2 ⨝ PEDIDO  → (añadir id_cliente)

| id_pedido | id_producto | descuento | nombre_producto  | precio | id_cliente |
|-----------|-------------|-----------|------------------|--------|------------|
| 1003      | 103         | 10        | Auriculares Pro  | 120    | 3          |

R4 = R3 ⨝ CLIENTE  → (añadir nombre cliente)

| id_pedido | id_producto | descuento | nombre_producto  | precio | id_cliente | nombre        |
|-----------|-------------|-----------|------------------|--------|------------|---------------|
| 1003      | 103         | 10        | Auriculares Pro  | 120    | 3          | Javier Ramos  |

π{CLIENTE.nombre AS nombre_cliente, PRODUCTO.nombre AS nombre_producto, precio, descuento}(R4)

Resultado:

| nombre_cliente | nombre_producto  | precio | descuento |
|----------------|------------------|--------|-----------|
| Javier Ramos   | Auriculares Pro  | 120    | 10        |

---

## Ejercicio 3

**Enunciado:** Encontrar los clientes que **compraron productos Electrónica** pero **no** compraron Accesorios. Además, incluir los clientes que **no han comprado nada**.
ACCS  := π_{id_cliente}(σ_{categoria = 'Accesorios'}(A))   -- clientes que compraron Accesorios

A = PEDIDO ⨝ DETALLE_PEDIDO ⨝ PRODUCTO

| id_pedido | id_cliente | id_producto | categoria   |
|-----------|-----------:|------------:|-------------|
| 1001      | 1         | 101         | Electrónica |
| 1001      | 1         | 102         | Accesorios  |
| 1002      | 2         | 104         | Accesorios  |
| 1003      | 3         | 103         | Electrónica |

ELEC = π{id_cliente}(σ{categoria='Electrónica'}(A)) = {1, 3}

ACCS = π{id_cliente}(σ{categoria='Accesorios'}(A)) = {1, 2}

CONDICION_1 = ELECT − ACCS = {1,3} − {1,2} = {3}

TODOS_CLEINTES = π{id_cliente}(CLIENTE) = {1,2,3,4}

COMPRADORES = π{id_cliente}(PEDIDO) = {1,2,3}

NO_COMPRADORES  = TODOS_CLEINTES − COMPRADORES = {4}

RESULT_IDS = CONDICION_1 ∪ NO_COMPRADORES  = {3} ∪ {4} = {3,4}

| id_cliente | nombre        |
|------------|---------------|
| 3          | Javier Ramos  |
| 4          | Diego Morales |

---

## Ejercicio 4

**Enunciado:** Encontrar los empleados que trabajaron en **todos** los proyectos de tipo *Nacional*, pero **no** en **ningún** proyecto *Internacional*.

TARGET_IDS := EMPS_NAC − EMPS_INT

Resultado final: TARGET := TARGET_IDS ⨝ EMPLEADO  (para obtener datos de los empleados)

PROYECTO:

| id_proyecto | tipo          |
|-------------|---------------|
| 100         | Nacional      |
| 200         | Internacional |
| 300         | Internacional |

S_nac = π{id_proyecto}(σ{tipo = 'Nacional'}(PROYECTO))  = {100}
S_int = π{id_proyecto}(σ{tipo = 'Internacional'}(PROYECTO)) =  {200, 300}

R = π{id_empleado, id_proyecto}(ASIGNACION)

| id_empleado | id_proyecto |
|-------------|-------------|
| 1           | 100         |
| 1           | 200         |
| 2           | 100         |
| 3           | 200         |
| 4           | 300         |

EMPS_NAC = R ÷ S_nac:
EMPS_NAC = {1,2}

EMPS_INT = R ÷ S_int  → empleados que tienen relación con **ambos** 200 y 300:

- Emp1 → proyectos {100,200}  (no 300)
- Emp2 → {100}               (no 200 ni 300)
- Emp3 → {200}               (no 300)
- Emp4 → {300}               (no 200)
- 

EMPS_INT = ∅

IDS = EMPS_NAC − EMPS_INT = {1,2} − ∅ = {1,2}
IDS ⨝ EMPLEADO

| id_empleado | nombre      | depto     | salario |
|-------------|-------------|-----------|---------|
| 1           | Ana Torres  | Ventas    | 2500    |
| 2           | Luis Pérez  | Finanzas  | 1800    |


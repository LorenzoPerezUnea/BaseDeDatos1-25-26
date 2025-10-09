# Resolución Ejercicios 6–10 (con resultados parciales R₁, R₂, ...)

## Ejercicio 6 — Intersección + Diferencia (cursos)

1) Obtener los estudiantes inscritos en los cursos “Base de Datos” (id_curso = 11) **y** “Programación” (id_curso = 12).
2) Obtener los estudiantes inscritos en “Base de Datos” pero **no** en “Programación”.

R1 := σ{id_curso = 11}(INSCRIPCION)
R1 (inscripciones en Base de Datos):

| id_curso | id_estudiante |
|----------|---------------|
| 11       | 1             |
| 11       | 2             |

R2 := σ{id_curso = 12}(INSCRIPCION)
R2 (inscripciones en Programación):

| id_curso | id_estudiante |
|----------|---------------|
| 12       | 1             |
| 12       | 3             |

R3 := π{id_estudiante}(R1)
R3 = {1, 2}

R4 := π{id_estudiante}(R2)
R4 = {1, 3}

(1) Estudiantes en ambos cursos: R5 := R3 ∩ R4

R5:

| id_estudiante |
|---------------|
| 1             |

Para obtener el nombre (unir con CLIENTE si los ids coinciden con clientes):
R6 := R5 ⨝{id_estudiante = id_cliente} CLIENTE

R6:

| id_estudiante / id_cliente | nombre      | ciudad | edad | tipo   |
|----------------------------|-------------|--------|------|--------|
| 1                          | Carlos Vega | Madrid | 25   | Premium|

(2) Estudiantes en Base de Datos pero no en Programación: R7 := R3 − R4

R7:

| id_estudiante |
|---------------|
| 2             |

Unimos para ver nombre:

R8 := R7 ⨝{id_estudiante = id_cliente} CLIENTE

R8:

| id_estudiante | nombre      | ciudad  | edad | tipo     |
|---------------|-------------|---------|------|----------|
| 2             | Sofía López | Sevilla | 31   | Estándar |

---

## Ejercicio 7 — División (proyectos 'Internacional')

Encontrar los empleados que han trabajado en **todos** los proyectos de tipo 'Internacional'.

S := π{id_proyecto}(σ{tipo = 'Internacional'}(PROYECTO))
S (proyectos internacionales):

| id_proyecto |
|-------------|
| 200         |
| 300         |

R := π{id_empleado, id_proyecto}(ASIGNACION)
R (asignaciones):

| id_empleado | id_proyecto |
|-------------|-------------|
| 1           | 100         |
| 1           | 200         |
| 2           | 100         |
| 3           | 200         |
| 4           | 300         |

Aplicar división: EmpleadosIds := R ÷ S
(Queremos empleados que tienen asignaciones a **todos** los proyectos {200,300})

Observando R y S:

- Emp 1 → {100,200}  (no 300)
- Emp 2 → {100}      (ni 200 ni 300)
- Emp 3 → {200}      (no 300)
- Emp 4 → {300}      (no 200)

Por tanto la división **no devuelve filas**

Resultado EmpleadosIds (vacío):

| id_empleado |
|-------------|
| (ninguno)   |

---

## Ejercicio 8 — Join + Unión + Selección (compras en marzo por categorías)

Obtener los nombres de los clientes que compraron productos de las categorías “Electrónica” **o** “Accesorios” durante marzo de 2024.

R1 := σ{fecha >= '2024-03-01' ∧ fecha <= '2024-03-31'}(PEDIDO)
R1 (pedidos en marzo):

| id_pedido | id_cliente | fecha       | total | estado |
|-----------|------------|-------------|-------|--------|
| 1001      | 1          | 2024-03-15  | 1020  | Pagado |
| 1002      | 2          | 2024-03-22  | 95    | Pagado |
| 1004      | 4          | 2024-03-18  | 70    | Pagado |

R2 := R1 ⨝{R1.id_pedido = DETALLE_PEDIDO.id_pedido} DETALLE_PEDIDO
R2 (detalles de pedidos de marzo):

| id_pedido | id_producto | cantidad | descuento | subtotal |
|-----------|-------------|----------|-----------|----------|
| 1001      | 101         | 1        | 0         | 950      |
| 1001      | 102         | 1        | 0         | 25       |
| 1002      | 104         | 1        | 0         | 70       |
| 1004      | 104         | 1        | 0         | 70       |

R3 := R2 ⨝{R2.id_producto = PRODUCTO.id_producto} PRODUCTO
R3 (añadimos categoría/precio):

| id_pedido | id_producto | cantidad | subtotal | nombre_producto  | categoria   | precio |
|-----------|-------------|----------|----------|------------------|-------------|--------|
| 1001      | 101         | 1        | 950      | Portátil X       | Electrónica | 950    |
| 1001      | 102         | 1        | 25       | Ratón Óptico     | Accesorios  | 25     |
| 1002      | 104         | 1        | 70       | Mochila Travel   | Accesorios  | 70     |
| 1004      | 104         | 1        | 70       | Mochila Travel   | Accesorios  | 70     |

R4 := σ{categoria = 'Electrónica' ∨ categoria = 'Accesorios'}(R3)
R4 (filtrado por categorías transversales):

| id_pedido | id_producto | cantidad | subtotal | nombre_producto  | categoria   | precio |
|-----------|-------------|----------|----------|------------------|-------------|--------|
| 1001      | 101         | 1        | 950      | Portátil X       | Electrónica | 950    |
| 1001      | 102         | 1        | 25       | Ratón Óptico     | Accesorios  | 25     |
| 1002      | 104         | 1        | 70       | Mochila Travel   | Accesorios  | 70     |
| 1004      | 104         | 1        | 70       | Mochila Travel   | Accesorios  | 70     |

R5 := π{id_pedido}(R4)
R5 (pedidos que incluyen esos productos en marzo):

| id_pedido |
|-----------|
| 1001      |
| 1002      |
| 1004      |

R6 := R5 ⨝ PEDIDO   (añadimos id_cliente)

| id_pedido | id_client e |
|-----------|-------------|
| 1001      | 1           |
| 1002      | 2           |
| 1004      | 4           |

R7 := π{id_cliente}(R6)

| id_cliente |
|------------|
| 1          |
| 2          |
| 4          |

R8 := R7 ⨝ CLIENTE

R8:

| id_cliente | nombre        |
|------------|---------------|
| 1          | Carlos Vega   |
| 2          | Sofía López   |
| 4          | Elena Navarro |

---

## Ejercicio 9 — Join + Diferencia + Proyección (clientes que NO compraron "Accesorios")

Obtener los nombres de los clientes que **no** compraron productos de la categoría “Accesorios” (en todo el periodo disponible).

A) Conjunto de todos los clientes (que aparecen en CLIENTE):
TODOS_CLIENTES := π{id_cliente, nombre}(CLIENTE)

TODOS_CLIENTES :

| id_cliente | nombre        |
|------------|---------------|
| 1          | Carlos Vega   |
| 2          | Sofía López   |
| 3          | Javier Ramos  |
| 4          | Elena Navarro |
| 5          | Diego Morales |

B) Clientes que compraron accesorios (hacer join entre PEDIDO, DETALLE_PEDIDO y PRODUCTO, filtrar por categoría 'Accesorios'):

B1 := PEDIDO ⨝ DETALLE_PEDIDO  (por id_pedido)
B1 (pedidos + detalles)

| id\_pedido | id\_cliente | fecha      | total | estado    | id\_producto | cantidad | descuento | subtotal |
| ------------ | ------------- | ------------ | ------- | ----------- | -------------- | ---------- | ----------- | ---------- |
| 1001       | 1           | 2024-03-15 | 1020  | Pagado    | 101          | 1        | 0         | 950      |
| 1001       | 1           | 2024-03-15 | 1020  | Pagado    | 102          | 1        | 0         | 25       |
| 1002       | 2           | 2024-03-22 | 95    | Pagado    | 104          | 1        | 0         | 70       |
| 1003       | 3           | 2024-04-02 | 120   | Pendiente | 103          | 1        | 10        | 108      |
| 1004       | 4           | 2024-03-18 | 70    | Pagado    | 104          | 1        | 0         | 70       |
| 1005       | 5           | 2024-04-10 | 950   | Pagado    | 101          | 1        | 0         | 950      |

B2 := B1 ⨝ PRODUCTO (por id_producto)

| id\_pedido | id\_cliente | fecha      | total | estado    | id\_producto | cantidad | descuento | subtotal | nombre\_producto | categoria    | precio | stock |
| ------------ | ------------- | ------------ | ------- | ----------- | -------------- | ---------- | ----------- | ---------- | ------------------ | -------------- | -------- | ------- |
| 1001       | 1           | 2024-03-15 | 1020  | Pagado    | 101          | 1        | 0         | 950      | Portátil X      | Electrónica | 950    | 20    |
| 1001       | 1           | 2024-03-15 | 1020  | Pagado    | 102          | 1        | 0         | 25       | Ratón Óptico   | Accesorios   | 25     | 120   |
| 1002       | 2           | 2024-03-22 | 95    | Pagado    | 104          | 1        | 0         | 70       | Mochila Travel   | Accesorios   | 70     | 40    |
| 1003       | 3           | 2024-04-02 | 120   | Pendiente | 103          | 1        | 10        | 108      | Auriculares Pro  | Electrónica | 120    | 80    |
| 1004       | 4           | 2024-03-18 | 70    | Pagado    | 104          | 1        | 0         | 70       | Mochila Travel   | Accesorios   | 70     | 40    |
| 1005       | 5           | 2024-04-10 | 950   | Pagado    | 101          | 1        | 0         | 950      | Portátil X      | Electrónica | 950    | 20    |

B3 := π{id_pedido,id_producto,id_cliente,categoria}(σ{categoria = 'Accesorios'}(B2))

B3 (filtrado):

| id_pedido | id_producto | id_cliente | categoria  |
|-----------|-------------|------------|------------|
| 1001      | 102         | 1          | Accesorios |
| 1002      | 104         | 2          | Accesorios |
| 1004      | 104         | 4          | Accesorios |

B4 := π{id_cliente}(B3)

B4:

| id_cliente |
|------------|
| 1          |
| 2          |
| 4          |

C) Clientes que NO compraron accesorios:

RESULT := TODOS_CLIENTES_ids − B4

TODOS_CLIENTES_ids := π{id_cliente}(TODOS_CLIENTES ) = {1,2,3,4,5}

| id_cliente |
|------------|
| 1          |
| 2          |
| 3          |
| 4          | 
| 5          |

RESULT_ids := {1,2,3,4,5} − {1,2,4} = {3,5}

| id_cliente |
|------------|
| 3          |
| 5          |

Unir a CLIENTE para obtener nombres:

RESULT := π{nombre}(RESULT_ids ⨝ CLIENTE)

| id_cliente | nombre       | ciudad     | edad | tipo |
|-------------|--------------|-------------|------|------|
| 3 | Javier Ramos  | Valencia   | 22 | Premium |
| 5 | Diego Morales | Bilbao     | 35 | Premium |

RESULT:

| nombre       |
|--------------|
| Javier Ramos |
| Diego Morales |

---

## Ejercicio 10 — Integrador (3 partes)

### (1) Listar los clientes que han comprado **todos** los productos de la categoría "Electrónica".

S := π{id_producto}(σ{categoria = 'Electrónica'}(PRODUCTO))
S (productos Electrónica):

| id_producto |
|-------------|
| 101         |
| 103         |
| 105         |

R := π{id_cliente, id_producto}( PEDIDO ⨝ DETALLE_PEDIDO )
R (clientes × productos comprados; derivado de la unión pedidos+detalles):

R (extraído de datos):

| id_cliente | id_producto |
|------------|------------|
| 1          | 101        |  -- pedido 1001
| 1          | 102        |  -- accesorio
| 2          | 104        |
| 3          | 103        |  -- pedido 1003
| 4          | 104        |
| 5          | 101        |  -- pedido 1005

Aplicar división: ClientesIds := R ÷ S
(Queremos clientes cuyo conjunto de productos comprados incluya **todos** {101,103,105})

Observando R:

- Cliente 1 → {101,102} (le faltan 103 y 105)
- Cliente 2 → {104}
- Cliente 3 → {103}
- Cliente 4 → {104}
- Cliente 5 → {101}

Ningún cliente tiene {101,103,105} completo → resultado vacío.

Resultado :

| id_cliente |
|------------|
| (ninguno)  |

---

### (2) Mostrar los productos "Accesorios" que **no fueron vendidos** en marzo.

S := π{id_producto}(σ{categoria = 'Accesorios'}(PRODUCTO))
S (productos accesorios):

| id_producto |
|-------------|
| 102         |
| 104         |

V_MARZO := π{id_producto}( (σ{fecha >= '2024-03-01' ∧ fecha <= '2024-03-31'}(PEDIDO)) ⨝ DETALLE_PEDIDO )
V_MARZO (productos vendidos en marzo)

V_MARZO :

| id_producto |
|-------------|
| 101 |
| 102 |
| 104 |

(Observa: 101 vendido en marzo, 102 y 104 también)

Accesorios_no_vendidos_en_marzo := S − V_MAR

S − V_MARZO :

| id_producto |
|-------------|
| (ninguno)   |

Por tanto **no hay accesorios sin ventas en marzo** .

---

### (3) Listar los clientes que **solo** compraron productos con precio < 100.

Clientes que hayan realizado compras **y** para los cuales **no existe** una compra de producto con precio ≥ 100.

A) Conjunto de clientes que han comprado algo (COMPRAN_ALGO):
COMPRAN_ALGO:= π{id_cliente}(PEDIDO) = {1,2,3,4,5}

B) Conjunto de clientes que compraron al menos un producto caro (price ≥ 100):

B1 := DETALLE_PEDIDO ⨝ PRODUCTO
B2 := σ{precio >= 100}(B1)
B3 := π{id_pedido}(B2)
B4 := B3 ⨝ PEDIDO
B5 := π{id_cliente}(B4)

B2 => rows:

| id_pedido | id_producto | precio |
|-----------|-------------|--------|
| 1001      | 101         | 950    |
| 1003      | 103         | 120    |
| 1005      | 101         | 950    |

B3 := π{id_pedido}(B2) = {1001,1003,1005}
B4 := B3 ⨝ PEDIDO =  {1,3,5}
B5 := π{id_cliente}(B4) = {1,3,5}

C) Clientes que solo compraron productos baratos= COMPRAN_ALGO− B5

COMPRAN_ALGO{1,2,3,4,5} − {1,3,5} = {2,4}

Unir con CLIENTE para nombres:

Resultado (parte 3):

| id_cliente | nombre       |
|------------|--------------|
| 2          | Sofía López  |
| 4          | Elena Navarro |


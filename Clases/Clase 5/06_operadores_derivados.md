## Operadores Derivados

Además de los operadores fundamentales, existen operaciones derivadas que pueden expresarse en términos de las anteriores pero que resultan más convenientes o legibles en la práctica.

### La **intersección**

Entre ellas se encuentra la **intersección** (∩), que devuelve las tuplas que están en ambas relaciones de entrada.

**Relación R1**

| ID | NOMBRE |
|----|--------|
| 1  | Ana    |
| 2  | Luis   |
| 3  | Marta  |
| 4  | Jorge  |

**Relación R2**

| ID | NOMBRE |
|----|--------|
| 3  | Marta  |
| 4  | Jorge  |
| 5  | Antonio |
| 6  | Pedro |

**Resultado R1 ∩ R2**

| ID | NOMBRE |
|----|--------|
| 3  | Marta  |
|  4 | Luis   |

### El **join**

Otra operación de gran importancia es el **join** o combinación, que consiste en realizar un producto cartesiano seguido de una selección que conserva únicamente las tuplas que cumplen una condición de coincidencia.

La notación R ⨝ condición S se utiliza para representar esta operación de manera compacta.

El **join natural** es un caso particular en el que la condición es la igualdad de todos los atributos que tienen el mismo nombre en ambas relaciones.

CLIENTE(ID, NOMBRE) ⨝ PEDIDO(ID_CLIENTE, IMPORTE)

| ID | NOMBRE | ID_CLIENTE | IMPORTE |
|----|--------|------------|---------|
| 1  | Ana    | 1          | 100     |
| 1  | Ana    | 1          | 250     |

### La **división**

Por último, la **división** (÷) es una operación usada para consultas de tipo “para todos”, devolviendo las tuplas de una relación R que están relacionadas con **todas** las tuplas de otra relación S.

Es útil en consultas como “encontrar los empleados que han trabajado en todos los proyectos” o “los estudiantes que han aprobado todas las asignaturas requeridas".

**Relación R = COMPRA(cliente, producto):**

| CLIENTE | PRODUCTO |
|--------|-----------|
| Ana    | P1        |
| Ana    | P2        |
| Ana    | P3        |
| Luis   | P1        |
| Luis   | P3        |
| Marta  | P1        |
| Marta  | P2        |
| Marta  | P3        |

**Relación S = PROMO(producto):**

| PRODUCTO |
|----------|
| P1       |
| P2       |
| P3       |

**Consulta:** COMPRA ÷ PROMO

**Resultado:**

| CLIENTE |
|--------|
| Ana    |
| Marta  |


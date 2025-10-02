# Ejercicios Resueltos – Operadores Intersección (∩), División (÷) y Join (⨝)

## Relaciones de Ejemplo

**EMPLEADO_A**

| id_empleado | nombre      | departamento |
|-------------|-------------|--------|
| 1           | Ana López   | IT     |
| 2           | Juan Pérez  | IT     |
| 3           | Marta Ruiz  | HR     |

**EMPLEADO_B**

| id_empleado | nombre      | departamento |
|-------------|-------------|--------|
| 2           | Juan Pérez  | IT     |
| 3           | Marta Ruiz  | HR     |
| 4           | Pedro León  | IT     |

**PROYECTO**

| id_proyecto | nombre_proyecto |
|-------------|-------------|
| 10          | CRM         |
| 20          | ERP         |
| 30          | BI          |

**ASIGNACION**

| id_empleado | id_proyecto |
|-------------|-------------|
| 1           | 10          |
| 1           | 20          |
| 1           | 30          |
| 2           | 10          |
| 2           | 20          |
| 2           | 30          |
| 3           | 10          |
| 3           | 20          |

---

## Operador Intersección (∩)

Devuelve las tuplas que están presentes en **ambas** relaciones (requiere mismo esquema).

### Ejercicio 1 – Fácil

Objetivo: Obtener los empleados que aparecen tanto en A como en B.

Operación:

`EMPLEADO_A ∩ EMPLEADO_B`

Resultado:

| id_empleado | nombre      | departamento |
|-------------|-------------|--------|
| 2           | Juan Pérez  | IT     |
| 3           | Marta Ruiz  | HR     |

---

### Ejercicio 2 – Medio

Objetivo: Obtener solo los **nombres** de empleados en la intersección.

Operación:

π(nombre)(EMPLEADO_A) ∩ π(nombre)(EMPLEADO_B)

Resultado:

| nombre      |
|-------------|
| Juan Pérez  |
| Marta Ruiz  |

---

### Ejercicio 3 – Difícil

Objetivo: Intersección y luego renombrar para mostrar como COMUNES.

Operación:

ρ(COMUNES)(EMPLEADO_A ∩ EMPLEADO_B)

Resultado (**COMUNES**):

| id_empleado | nombre      | departamento |
|-------------|-------------|--------|
| 2           | Juan Pérez  | IT     |
| 3           | Marta Ruiz  | HR     |

---

## Operador Join (⨝)

Combina tuplas de dos relaciones cuando cumplen una condición (generalmente igualdad de atributos).

### Ejercicio 1 – Fácil

Objetivo: Hacer un join natural entre EMPLEADO_B y ASIGNACION por id_empleado.

Operación:

`EMPLEADO_B ⨝ ASIGNACION`

Resultado (parcial):

| id_empleado | nombre      | departamento | id_proyecto |
|-------------|-------------|-------|-------------|
| 2           | Juan Pérez  | IT    | 10          |
| 2           | Juan Pérez  | IT    | 20          |
| 2           | Juan Pérez  | IT    | 30          |
| 3           | Marta Ruiz  | IT    | 10          |
| 3           | Marta Ruiz  | IT    | 20          |

---

### Ejercicio 2 – Medio

Objetivo: Join y luego proyección de nombre_proy y nombre de empleado.

Operación:

`π(nombre, nombre_proy )(EMPLEADO_A ⨝ ASIGNACION ⨝ PROYECTO)`

Resultado (parcial):

| nombre      | nombre_proy |
|-------------|-------------|
| Ana López   | CRM         |
| Ana López   | ERP         |
| Ana López   | BI          |
| Juan Pérez  | CRM         |
| Juan Pérez  | ERP         |
| Juan Pérez   | BI          |

---

### Ejercicio 3 – Difícil

Objetivo: Join de tres tablas y selección de empleados que trabajen en “ERP”.

Operación:

`σ(nombre_proy='ERP')(EMPLEADO_A ⨝ ASIGNACION ⨝ PROYECTO)`

Resultado:

| id_empleado | nombre      | departamento | id_proyecto | nombre_proyecto |
|-------------|-------------|-------|-------------|-------------|
| 1           | Ana López   | IT    | 20          | ERP         |
| 2           | Juan Pérez  | IT    | 20          | ERP         |

---

## Operador División (÷)

Usado cuando queremos **tuplas de A que están relacionadas con TODAS las tuplas de B**.

### Ejercicio 1 – Fácil

Objetivo: Obtener empleados de la relación B que trabajen en **TODOS** los proyectos.

Operación:

`π(id_empleado)(ASIGNACION) ÷ π(id_proyecto)(PROYECTO)`

resultado:

| id_empleado |
|-------------|
| 1           |
| 2           |

Porque solo los empleados 1 y 2 tienen asignaciones en **los 3** proyectos 10, 20 y 30.

---

### Ejercicio 3 – Medio

Objetivo: Obtener nombres de empleados que trabajen en todos los proyectos de tipo “CRM” y “BI”.

Operación:

S = π(id_proyecto)(σ(nombre_proyecto = CRM ∨ nombre_proyecto = BI)(PROYECTO))

| id_proyecto|
|-------------|
| 10   |
| 30  |

R = (ASIGNACION ⋈ (EMPLEADO_A ∪ EMPLEADO_B))

| id_empleado | nombre      | departamento | id_proyecto |
|-------------|-------------|-------|-------------|
| 1           | Ana López   | IT     | 10          |
| 1           | Ana López   | IT     | 20          |
| 1           | Ana López   | IT     | 30          |
| 2           | Juan Pérez  | IT    | 10          |
| 2           | Juan Pérez  | IT    | 20          |
| 2           | Juan Pérez  | IT    | 30          |
| 3           | Marta Ruiz  | IT    | 10          |
| 3           | Marta Ruiz  | IT    | 20          |

π(nombre)(R ÷ S)

Resultado:

| nombre      |
|-------------|
| Ana López   |
| Juan Pérez  |

---

### Ejercicio 3 – Difícil

Objetivo: Usar división para obtener todos empleados que estén en departamento = IT y que hayan trabajado en los proyectos CRM y ERP.

Operación:

S = σ(departamento ='IT')(EMPLEADO_A ∪ EMPLEADO_B)

| id_empleado | nombre      | departamento |
|-------------|-------------|--------|
| 1           | Ana López   | IT     |
| 2           | Juan Pérez  | IT     |
| 4           | Pedro León  | IT     |

R = π(id_proyecto)(σ(nombre_proyecto = CRM  ∨ nombre_proyecto = ERP)(PROYECTO))

| id_proyecto |
|-------------|
| 10          |
| 20          |

T = π(id_empleado )(ASIGNACION ÷ R)

| id_empleado |
|-------------|
| 1           | 
| 2           |

Resultado:

S ÷ T

| id_empleado | nombre      | departamento |
|-------------|-------------|-------|
| 1           | Ana López   | IT    |
| 2           | Juan Pérez  | IT    |


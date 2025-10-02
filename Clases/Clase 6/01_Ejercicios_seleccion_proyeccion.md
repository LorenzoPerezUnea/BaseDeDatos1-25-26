# Ejercicios Resueltos – Operadores Selección (σ) y Proyección (π)

## Relación de Ejemplo

Supongamos una relación **EMPLEADO**:

| id_empleado | nombre      | departamento | salario |
|-------------|-------------|--------|--------|
| 1           | Ana López   | Ventas | 1500   |
| 2           | Juan Pérez  | IT     | 2500   |
| 3           | Marta Ruiz  | IT     | 1800   |
| 4           | Pedro León  | HR     | 1200   |
| 5           | Carla Díaz  | IT     | 3000   |

---

## Operador Selección (σ)

La selección filtra tuplas de una relación que cumplen una condición.

**Ejercicio 1 – Fácil**

Objetivo: Seleccionar los empleados del departamento de IT.

Operación:

σ(depto = "IT")(EMPLEADO)

Resultado:

| id_empleado | nombre      | departamento | salario |
|-------------|-------------|-------|--------|
| 2           | Juan Pérez  | IT    | 2500   |
| 3           | Marta Ruiz  | IT    | 1800   |
| 5           | Carla Díaz  | IT    | 3000   |

---

**Ejercicio 2 – Medio**

Objetivo: Seleccionar empleados del departamento IT con salario mayor a 2000.

Operación:

σ(depto = "IT" ∧ salario > 2000)(EMPLEADO)

Resultado:

| id_empleado | nombre      | departamento | salario |
|-------------|-------------|-------|--------|
| 2           | Juan Pérez  | IT    | 2500   |
| 5           | Carla Díaz  | IT    | 3000   |

---

**Ejercicio 3 – Difícil**

Objetivo: Seleccionar empleados de IT o Ventas con salario menor a 2000.

Operación:

σ((depto = "IT" v depto = "Ventas") ∧ salario < 2000)(EMPLEADO)

Resultado:

| id_empleado | nombre      | departamento | salario |
|-------------|-------------|--------|--------|
| 1           | Ana López   | Ventas | 1500   |
| 3           | Marta Ruiz  | IT     | 1800   |

---

## Operador Proyección (π)

La proyección selecciona columnas (atributos) de una relación y elimina duplicados.

**Ejercicio 1 – Fácil**

Objetivo: Mostrar solo los nombres de los empleados.

Operación:

π(nombre)(EMPLEADO)

Resultado:

| nombre      |
|-------------|
| Ana López   |
| Juan Pérez  |
| Marta Ruiz  |
| Pedro León  |
| Carla Díaz  |

---

**Ejercicio 2 – Medio**

Objetivo: Mostrar nombre y salario de empleados de IT.

Operación:

π(nombre, salario)(σ(departamento ="IT")(EMPLEADO))

Resultado:

| nombre      | salario |
|-------------|--------|
| Juan Pérez  | 2500   |
| Marta Ruiz  | 1800   |
| Carla Díaz  | 3000   |

---

**Ejercicio 3 – Difícil**

Objetivo: Mostrar los departamentos únicos (sin duplicados).

Operación:

π(depto)(EMPLEADO)

Resultado:

| departamento |
|--------|
| Ventas |
| IT     |
| HR     |


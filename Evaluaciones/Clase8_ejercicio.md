# Ejercicios Clase 8 - Álgebra Relacional

## Ejercicio 1

```sql
ρ(EMPLEADOS_FINANZAS)(π(nombre, salario)(σ(salario > 2000)(Empleados)))
```

### Resultado
| nombre      | salario |
|-------------|---------|
| Ana Torres  | 2500    |
| Laura Ruiz  | 2600    |
| Pedro Gómez | 3200    |
---

## Ejercicio 2

```sql
r1:(σ(nombre){Clientes})ρ(nombre_cliente)⨝(σ(id_producto,nombre,precio > 100)π(σ(id_pedido,id_producto,descuento){PEDIDO}
σ(nombre_cliente,(producto)ρ(nombre_producto),precio,descuento){r1
```

### Resultado

| nombre_cliente | nombre_producto | precio | descuento |
|----------------|-----------------|--------|-----------|
| Carlos Vega    | Portátil X     | 950    | 0         |
| Javier Ramos   | Auriculares Pro| 120    | 10        |

---

## Ejercicio 3


```sql
ClientesElectronicos := π(id_cliente)(σ(tipo='Electronico')(PRODUCTO) ⋈ COMPRA)
ClientesAccesorios := π(id_cliente)(σ(tipo='Accesorio')(PRODUCTO) ⋈ COMPRA)
ClientesSinCompras := π(id_cliente)(CLIENTE) - π(id_cliente)(COMPRA)

```

### Resultado

| id_cliente |
|------------|
| 3          |
| 4          |


## Ejercicio 4

```sql
ProyectosNacionales := π(id_proyecto)(σ(tipo='Nacional')(PROYECTO))
ProyectosInternacionales := π(id_proyecto)(σ(tipo='Internacional')(PROYECTO))
EmpleadosInternacionales := π(id_empleado)(ASIGNACION ⋈ ProyectosInternacionales)
```

### Resultado

| id_empleado |
|-------------|
| 2           |
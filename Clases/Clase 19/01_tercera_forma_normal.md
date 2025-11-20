# Tercera Forma Normal (3FN)

## Concepto

Una tabla está en **Tercera Forma Normal (3FN)** si:

1. ​**Cumple la Segunda Forma Normal (2FN)**​.
2. **No existen dependencias transitivas** entre atributos no clave.

> En otras palabras: **todo atributo no clave** debe depender **directamente de la clave primaria** y ​**no de otro atributo no clave**​.

### Definición formal

Si A → B y B → C, entonces existe una **dependencia transitiva** A → C.
La 3FN elimina ese tipo de dependencia separando los atributos en nuevas tablas.

## Ejemplo que viola la 3FN

Imaginemos una tabla `PEDIDO` que ya cumple 2FN:

PEDIDO

| id_pedido | id_cliente | nombre_cliente | ciudad_cliente | fecha_pedido |
|------------|-------------|----------------|----------------|---------------|
| 1 | 101 | Ana Pérez | Quito | 2024-06-01 |
| 2 | 102 | Bruno Díaz | Guayaquil | 2024-06-02 |
| 3 | 103 | Carla Mena | Quito | 2024-06-03 |

**Clave primaria:**`id_pedido`

**Dependencias:**

* `id_pedido → id_cliente`  (válida)
* `id_cliente → nombre_cliente, ciudad_cliente`  (transitiva)
  Los atributos `nombre_cliente` y `ciudad_cliente` dependen ​**del cliente**​, no del pedido.
  Por tanto, ​**no cumple la 3FN**​.

## Solución: separar las dependencias transitivas

Dividimos la tabla en dos:

**CLIENTE**

| id_cliente | nombre_cliente | ciudad_cliente |
| ------------- | ----------------- | ----------------- |
| 101         | Ana Pérez      | Quito           |
| 102         | Bruno Díaz     | Guayaquil       |
| 103         | Carla Mena      | Quito           |

**PEDIDO**

| id_pedido | id_cliente | fecha_pedido |
| ------------ | ------------- | --------------- |
| 1          | 101         | 2024-06-01    |
| 2          | 102         | 2024-06-02    |
| 3          | 103         | 2024-06-03    |

## Implementación SQL

```sql
CREATE TABLE cliente (
  id_cliente INT PRIMARY KEY,
  nombre_cliente VARCHAR(100) NOT NULL,
  ciudad_cliente VARCHAR(100)
);

CREATE TABLE pedido (
  id_pedido INT PRIMARY KEY,
  id_cliente INT,
  fecha_pedido DATE,
  FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);
```

Ahora:

* `PEDIDO` almacena solo datos del pedido.
* `CLIENTE` almacena los datos personales.
* No hay dependencias transitivas: todo atributo no clave depende ​**solo de la clave primaria**​.

## Ejemplo extendido

Consideremos ahora una tabla `VENTA` con información combinada:

VENTA

| id_venta | id_cliente | cliente_nombre | cliente_ciudad | id_vendedor | vendedor_nombre | fecha | total |
|-----------|-------------|----------------|----------------|--------------|------------------|--------|--------|
| 1 | 201 | Ana | Quito | 501 | Luis | 2024-06-01 | 120 |
| 2 | 202 | Bruno | Guayaquil | 501 | Luis | 2024-06-02 | 150 |
| 3 | 203 | Carla | Quito | 502 | Marta | 2024-06-03 | 100 |

**Claves y dependencias:**

* `id_venta` → `id_cliente`, `id_vendedor`, `fecha`, `total`
* `id_cliente` → `cliente_nombre`, `cliente_ciudad`
* `id_vendedor` → `vendedor_nombre`.

**Violaciones de 3FN:**

* `cliente_nombre` y `cliente_ciudad` dependen transitivamente de `id_venta` a través de `id_cliente`.
* `vendedor_nombre` depende transitivamente de `id_venta` a través de `id_vendedor`.

## Normalización a 3FN

Creamos tres tablas separadas:

**CLIENTE**

| id_cliente | cliente_nombre | cliente_ciudad |
| ------------- | ----------------- | ----------------- |
| 201         | Ana             | Quito           |
| 202         | Bruno           | Guayaquil       |
| 203         | Carla           | Quito           |

**VENDEDOR**

| id_vendedor | vendedor_nombre |
| -------------- | ------------------ |
| 501          | Luis             |
| 502          | Marta            |

**VENTA**

| id_venta | id_cliente | id_vendedor | fecha      | total |
| ----------- | ------------- | -------------- | ------------ | ------- |
| 1         | 201         | 501          | 2024-06-01 | 120   |
| 2         | 202         | 501          | 2024-06-02 | 150   |
| 3         | 203         | 502          | 2024-06-03 | 100   |

### SQL resultante

```sql
CREATE TABLE cliente (
  id_cliente INT PRIMARY KEY,
  nombre VARCHAR(100),
  ciudad VARCHAR(100)
);

CREATE TABLE vendedor (
  id_vendedor INT PRIMARY KEY,
  nombre VARCHAR(100)
);

CREATE TABLE venta (
  id_venta INT PRIMARY KEY,
  id_cliente INT,
  id_vendedor INT,
  fecha DATE,
  total DECIMAL(10,2),
  FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
  FOREIGN KEY (id_vendedor) REFERENCES vendedor(id_vendedor)
);
```

Ahora cada entidad representa una ​**sola temática**​:

* `cliente`: información del comprador
* `vendedor`: información del vendedor
* `venta`: relación entre ambos con sus propios datos

No hay dependencias parciales ni transitivas → ​**cumple 3FN**​.

## Ejercicio 3 (para los estudiantes)

La siguiente tabla `INSCRIPCION` contiene datos mezclados:

| id_inscripcion | id_estudiante | nombre_estudiante | carrera  | id_curso | nombre_curso | profesor | fecha      |
| ----------------- | ---------------- | ------------- | ---------- | ----------- | --------------- | ---------- | ------------ |
| 1               | 10             | Laura       | Sistemas | 100       | SQL Básico   | Ruiz     | 2024-04-01 |
| 2               | 11             | Pedro       | Diseño  | 101       | Photoshop     | Ruiz     | 2024-04-02 |
| 3               | 12             | Sofía      | Sistemas | 100       | SQL Básico   | Ruiz     | 2024-04-03 |

**Tarea:**

1. Identificar las dependencias transitivas.
2. Reescribir las tablas para alcanzar la 3FN.
3. Indicar las claves primarias y foráneas.

### Solución esperada

**ESTUDIANTE**

| id_estudiante | nombre_estudiante | carrera  |
| ---------------- | ------------- | ---------- |
| 10             | Laura       | Sistemas |
| 11             | Pedro       | Diseño  |
| 12             | Sofía      | Sistemas |

**CURSO**

| id_curso | nombre_curso | profesor |
| ----------- | --------------- | ---------- |
| 100       | SQL Básico   | Ruiz     |
| 101       | Photoshop     | Ruiz     |

**INSCRIPCION**

| id_inscripcion | id_estudiante | id_curso | fecha      |
| ----------------- | ---------------- | ----------- | ------------ |
| 1               | 10             | 100       | 2024-04-01 |
| 2               | 11             | 101       | 2024-04-02 |
| 3               | 12             | 100       | 2024-04-03 |

### SQL correspondiente

```sql
CREATE TABLE estudiante (
  id_estudiante INT PRIMARY KEY,
  nombre_estudiante VARCHAR(100),
  carrera VARCHAR(100)
);

CREATE TABLE curso (
  id_curso INT PRIMARY KEY,
  nombre_curso VARCHAR(100),
  profesor VARCHAR(100)
);

CREATE TABLE inscripcion (
  id_inscripcion INT PRIMARY KEY,
  id_estudiante INT,
  id_curso INT,
  fecha DATE,
  FOREIGN KEY (id_estudiante) REFERENCES estudiante(id_estudiante),
  FOREIGN KEY (id_curso) REFERENCES curso(id_curso)
);
```

## Conclusión general

| Forma Normal  | Requisitos                                | Qué elimina                      | Ejemplo típico                       |
| --------------- | ------------------------------------------- | ----------------------------------- | --------------------------------------- |
| **1FN** | Atributos atómicos                       | Grupos repetidos                  | Lista de productos en una celda       |
| **2FN** | Cumple 1FN + sin dependencias parciales   | Redundancia por clave compuesta   | Nombre del cliente en tabla de pedido |
| **3FN** | Cumple 2FN + sin dependencias transitivas | Redundancia entre campos no clave | Ciudad del cliente dentro de pedido   |



# Ejercicio Integrado de Repaso – Bases de Datos

* Una biblioteca municipal necesita un sistema sencillo para gestionar el préstamo de libros.
* Cada usuario puede solicitar préstamos de distintos libros, y cada libro pertenece a una categoría**.
* Cuando un usuario realiza un préstamo, se registra la fecha de préstamo y la fecha de devolución prevista**.
* Al devolver un libro, se guarda la fecha de devolución real y, si hay retraso, se genera una multa asociada al préstamo.
* Consultar préstamos activos y el total de multas por usuario.
* Cada libro puede estar en préstamo solo una vez a la vez.

## Diseño Conceptual

### Entidades

- **USUARIO**: id_usuario, nombre, email, telefono
- **CATEGORIA**: id_categoria, nombre_categoria
- **LIBRO**: id_libro, titulo, autor, id_categoria
- **PRESTAMO**: id_prestamo, id_usuario, id_libro, fecha_prestamo, fecha_devolucion_prevista, fecha_devolucion_real
- **MULTA**: id_multa, id_prestamo, monto, motivo

### Relaciones (con cardinalidades)

- Un usuario realiza muchos préstamos → (USUARIO 1:N PRESTAMO)
- Un libro pertenece a una categoría → (LIBRO N:1 CATEGORIA)
- Un libro puede estar asociado a muchos préstamos, pero solo uno activo → (LIBRO 1:N PRESTAMO)
- Un préstamo puede generar una multa → (PRESTAMO 1:0..1 MULTA)

### Diagrama ER (Chen simplificado)

![1761207385651](images/ejercicios_repaso/1761207385651.png)
-------------

## Álgebra Relacional

**USUARIO**

| id\_usuario | nombre | email           |
| ------------- | -------- | ----------------- |
| 1           | Ana    | [ana@mail.com]()   |
| 2           | Bruno  | [bruno@mail.com]() |
| 3           | Carla  | [carla@mail.com]() |

**CATEGORIA**

| id\_categoria | nombre\_categoria |
| --------------- | ------------------- |
| 1             | Historia          |
| 2             | Ciencia           |
| 3             | Literatura        |

**LIBRO**

| id\_libro | titulo                   | autor      | id\_categoria |
| ----------- | -------------------------- | ------------ | --------------- |
| 10        | Los Orígenes del Hombre | Darwin     | 2             |
| 11        | La Odisea                | Homero     | 3             |
| 12        | La Revolución Francesa  | Lefebvre   | 1             |
| 13        | El Cosmos                | Carl Sagan | 2             |

**PRESTAMO**

| id\_prestamo | id\_usuario | fecha\_prestamo | fecha\_devolucion |
| -------------- | ------------- | ----------------- | ------------------- |
| 100          | 1           | 2024-04-01      | 2024-04-10        |
| 101          | 2           | 2024-04-02      | 2024-04-09        |
| 102          | 3           | 2024-04-03      | 2024-04-15        |

**MULTA**

| id\_multa | id\_prestamo | monto | estado    |
| ----------- | -------------- | ------- | ----------- |
| 1         | 102          | 15.00 | Pendiente |

### Ejercicio 1 — Obtener los títulos de libros prestados por el usuario "Ana"

1. **Selección:**
   Seleccionamos al usuario con nombre "Ana" de la relación USUARIO.
   Resultado en variable A1:
   A1 = selección(nombre = 'Ana')(USUARIO)
   
| id\_usuario | nombre | email         |
| ------------- | -------- | --------------- |
| 1           | Ana    | [ana@mail.com]() |
   
   
2. **Join con PRESTAMO:**
   Unimos A1 con PRESTAMO por id\_usuario.
   Resultado en variable A2:
   A2 = A1 join PRESTAMO (por id\_usuario)
   
| id\_usuario | nombre | id\_prestamo | fecha\_prestamo | fecha\_devolucion |
| ------------- | -------- | -------------- | ----------------- | ------------------- |
| 1           | Ana    | 100          | 2024-04-01      | 2024-04-10        |
   
   
3. **Join con LIBRO:**
   Unimos A2 con LIBRO por id\_libro (libros de cada préstamo).
   Resultado en variable A3:
   A3 = A2 join LIBRO (por id\_libro)
   
| id\_usuario | nombre | email         |id\_libro | titulo                   | autor      | id\_categoria |
| ------------- | -------- | --------------- |----------- | -------------------------- | ------------ | --------------- |
| 1           | Ana    | [ana@mail.com]() |10        | Los Orígenes del Hombre | Darwin     | 2             |
| 1           | Ana    | [ana@mail.com]() | 11        | La Odisea                | Homero     | 3             |
   
   
4. **Proyección:**
   Proyectamos el título del libro.
   Resultado final:
   π(titulo)(A3)
   
| titulo                   |
| -------------------------- |
| Los Orígenes del Hombre |
| La Odisea                |
   
   

### Ejercicio 2 — Mostrar los usuarios que tienen multas pendientes

1. **Selección:**
   Seleccionamos las multas con estado = 'Pendiente'.
   B1 = selección(estado = 'Pendiente')(MULTA)
   
| id\_multa | id\_prestamo | monto | estado    |
| ----------- | -------------- | ------- | ----------- |
| 1         | 102          | 15.00 | Pendiente |
   
   
2. **Join con PRESTAMO:**
   Unimos B1 con PRESTAMO para conocer qué préstamo generó la multa.
   B2 = B1 join PRESTAMO (por id\_prestamo)
   
| id\_prestamo | id\_usuario | nombre | email                                | monto | estado    |
| -------------- | ------------- | -------- | -------------------------------------- | ------- | ----------- |
| 102          | 3           | Carla  | [carla@mail.com](mailto:carla@mail.com) | 15.00 | Pendiente |
   
   
3. **Join con USUARIO:**
   Unimos B2 con USUARIO por id\_usuario.
   B3 = B2 join USUARIO (por id\_usuario)
4. **Proyección:**
   π(nombre, email)(B3)
   
| nombre | email                                |
| -------- | -------------------------------------- |
| Carla  | [carla@mail.com](mailto:carla@mail.com) |
   
   

### Ejercicio 3 — Mostrar los libros de la categoría “Ciencia” que han sido prestados

1. **Selección:**
   Seleccionamos las categorías con nombre\_categoria = 'Ciencia'.
   C1 = selección(nombre\_categoria = 'Ciencia')(CATEGORIA)
   
| id\_categoria | nombre\_categoria |
| --------------- | ------------------- |
| 2             | Ciencia           |
   
   
2. **Join con LIBRO:**
   C2 = C1 join LIBRO (por id\_categoria)
   
| id\_categoria | nombre\_categoria | id\_libro | titulo                   | autor      |
| --------------- | ------------------- | ----------- | -------------------------- | ------------ |
| 2             | Ciencia           | 10        | Los Orígenes del Hombre | Darwin     |
| 2             | Ciencia           | 13        | El Cosmos                | Carl Sagan |
   
   
3. **Join con PRESTAMO:**
   C3 = C2 join PRESTAMO (por id\_libro)
   
| id\_prestamo | id\_usuario | id\_libro | titulo    | autor      |
| -------------- | ------------- | ----------- | ----------- | ------------ |
| 102          | 3           | 13        | El Cosmos | Carl Sagan |
   
   
4. **Proyección:**
   π(titulo, autor)(C3)
   
| titulo    | autor      |
| ----------- | ------------ |
| El Cosmos | Carl Sagan |
   
   

## SQL

### DDL

```sql
CREATE DATABASE biblioteca CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

USE biblioteca;

CREATE TABLE categoria (
id_categoria INT AUTO_INCREMENT PRIMARY KEY,
nombre_categoria VARCHAR(100) NOT NULL
);

CREATE TABLE usuario (
id_usuario INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
email VARCHAR(100) UNIQUE
);

CREATE TABLE libro (
id_libro INT AUTO_INCREMENT PRIMARY KEY,
titulo VARCHAR(150) NOT NULL,
autor VARCHAR(100),
id_categoria INT,
FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria)
);

CREATE TABLE prestamo (
id_prestamo INT AUTO_INCREMENT PRIMARY KEY,
id_usuario INT NOT NULL,
id_libro INT NOT NULL,
fecha_prestamo DATE DEFAULT (CURRENT_DATE),
fecha_devolucion_prevista DATE,
fecha_devolucion_real DATE NULL,
FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
FOREIGN KEY (id_libro) REFERENCES libro(id_libro)
);

CREATE TABLE multa (
id_multa INT AUTO_INCREMENT PRIMARY KEY,
id_prestamo INT UNIQUE,
monto DECIMAL(10,2) CHECK (monto > 0),
motivo VARCHAR(255),
FOREIGN KEY (id_prestamo) REFERENCES prestamo(id_prestamo)
);
```

### DML

```sql
INSERT INTO categoria (nombre_categoria) VALUES ('Novela'), ('Ciencia'), ('Historia');

INSERT INTO usuario (nombre, email) VALUES
('Ana Ruiz', 'ana@correo.com'),
('Bruno Díaz', 'bruno@correo.com'),
('Carla León', 'carla@correo.com');

INSERT INTO libro (titulo, autor, id_categoria) VALUES
('1984', 'George Orwell', 1),
('Breve historia del tiempo', 'Stephen Hawking', 2),
('Don Quijote', 'Miguel de Cervantes', 1);

INSERT INTO prestamo (id_usuario, id_libro, fecha_prestamo, fecha_devolucion_prevista)
VALUES
(1, 1, '2024-03-01', '2024-03-10'),
(2, 3, '2024-03-05', '2024-03-15'),
(3, 2, '2024-03-08', '2024-03-18');

INSERT INTO multa (id_prestamo, monto, motivo)
VALUES
(2, 10.00, 'Retraso de 5 días');
```

1. Usuarios con préstamos activos
   ```sql
   SELECT u.nombre
   FROM usuario u
   JOIN prestamo p ON u.id_usuario = p.id_usuario
   WHERE p.fecha_devolucion_real IS NULL;
   ```
   
   
2. Total de multas por usuario

```sql
SELECT u.nombre, SUM(m.monto) AS total_multas
FROM usuario u
JOIN prestamo p ON u.id_usuario = p.id_usuario
JOIN multa m ON p.id_prestamo = m.id_prestamo
GROUP BY u.nombre;
```

3. Libros de la categoría “Novela” actualmente prestados

```sql
SELECT l.titulo
FROM libro l
JOIN categoria c ON l.id_categoria = c.id_categoria
JOIN prestamo p ON l.id_libro = p.id_libro
WHERE c.nombre_categoria = 'Novela'
AND p.fecha_devolucion_real IS NULL;
```

4. Actualizar devolución de un préstamo

```sql
UPDATE prestamo
SET fecha_devolucion_real = CURRENT_DATE
WHERE id_prestamo = 1;
```

5. Eliminar préstamos antiguos

```sql
DELETE FROM prestamo
WHERE fecha_devolucion_real < '2024-03-01';
```


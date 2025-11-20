## **Cuarta Forma Normal (4FN)**

### **Concepto**

Una tabla está en **Cuarta Forma Normal** si:

1. Está en ​**Tercera Forma Normal (3FN)**​, y
2. **No existen dependencias multivaluadas no triviales.**

Una **dependencia multivaluada** ocurre cuando un atributo en una tabla determina **independientemente** a otros dos o más conjuntos de atributos.
En otras palabras, ​**un atributo determina varias listas de valores independientes**​.

Ejemplo conceptual:
Un profesor puede enseñar varios cursos y hablar varios idiomas, y esas dos listas son ​**independientes entre sí**​.
Guardar ambas listas en una misma tabla genera redundancia.

### **Ejemplo teórico (no normalizado)**

**Tabla PROFESOR_INFO**

| id_profesor | nombre     | curso        | idioma   |
| -------------- | ------------ | -------------- | ---------- |
| 1            | Ana López | Matemáticas | Inglés  |
| 1            | Ana López | Matemáticas | Español |
| 1            | Ana López | Historia     | Inglés  |
| 1            | Ana López | Historia     | Español |

Aquí hay ​**redundancia**​:
Cada combinación de curso e idioma se repite innecesariamente, porque ​**los cursos y los idiomas son independientes**​.

### **Normalización a 4FN**

Dividimos en dos tablas separadas para eliminar la dependencia multivaluada:

**PROFESOR_CURSO**

| id_profesor | curso        |
| -------------- | -------------- |
| 1            | Matemáticas |
| 1            | Historia     |

**PROFESOR_IDIOMA**

| id_profesor | idioma   |
| -------------- | ---------- |
| 1            | Inglés  |
| 1            | Español |

Ahora, cada tabla representa una relación simple sin redundancia.

### **Ejemplo SQL — 4ª Forma Normal**

```sql
-- Tabla no normalizada
CREATE TABLE profesor_info (
  id_profesor INT,
  nombre VARCHAR(100),
  curso VARCHAR(100),
  idioma VARCHAR(100)
);

INSERT INTO profesor_info VALUES
(1, 'Ana López', 'Matemáticas', 'Inglés'),
(1, 'Ana López', 'Matemáticas', 'Español'),
(1, 'Ana López', 'Historia', 'Inglés'),
(1, 'Ana López', 'Historia', 'Español');

-- Normalización: creamos tablas separadas
CREATE TABLE profesor (
  id_profesor INT PRIMARY KEY,
  nombre VARCHAR(100)
);

CREATE TABLE profesor_curso (
  id_profesor INT,
  curso VARCHAR(100),
  FOREIGN KEY (id_profesor) REFERENCES profesor(id_profesor)
);

CREATE TABLE profesor_idioma (
  id_profesor INT,
  idioma VARCHAR(100),
  FOREIGN KEY (id_profesor) REFERENCES profesor(id_profesor)
);

-- Insertamos los datos reorganizados
INSERT INTO profesor (id_profesor, nombre)
SELECT DISTINCT id_profesor, nombre
FROM profesor_info;

INSERT INTO profesor_curso (id_profesor, curso)
SELECT DISTINCT id_profesor, curso
FROM profesor_info;

INSERT INTO profesor_idioma (id_profesor, idioma)
SELECT DISTINCT id_profesor, idioma
FROM profesor_info;
```

Ahora cada tabla describe una única relación sin redundancia.
Si Ana enseña un nuevo curso, no necesitamos volver a insertar los idiomas, y viceversa.


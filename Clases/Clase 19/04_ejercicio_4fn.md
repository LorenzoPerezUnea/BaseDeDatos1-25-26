# Cuarta Forma Normal (4FN)

### Dependencias Multivaluadas y Normalización Compleja

La **Cuarta Forma Normal (4FN)** se alcanza cuando una relación se encuentra en **3FN** y ​**no presenta dependencias multivaluadas no triviales**​.
Una **dependencia multivaluada (DMV)** ocurre cuando para una misma clave existen ​**dos conjuntos de atributos independientes**​, que no deberían coexistir en la misma tabla porque generan combinaciones redundantes.

## Escenario realista: Sistema de investigación académica

Una universidad registra ​**investigadores**​, los **proyectos** en los que participan y los **idiomas** que dominan.
Los proyectos y los idiomas son **atributos multivaluados independientes** del investigador.

### Tabla sin normalizar (no cumple 4FN)

```sql
CREATE TABLE investigador_info (
  id_investigador INT,
  nombre VARCHAR(100),
  proyecto VARCHAR(100),
  idioma VARCHAR(50)
);

INSERT INTO investigador_info VALUES
(1, 'Laura Pérez', 'Proyecto Energía Solar', 'Inglés'),
(1, 'Laura Pérez', 'Proyecto Energía Solar', 'Francés'),
(1, 'Laura Pérez', 'Proyecto IA Médica', 'Inglés'),
(1, 'Laura Pérez', 'Proyecto IA Médica', 'Francés'),
(2, 'Carlos Díaz', 'Proyecto IA Médica', 'Español'),
(2, 'Carlos Díaz', 'Proyecto Big Data', 'Español');
```

| id_investigador | nombre       | proyecto       | idioma   |
| ------------------ | -------------- | ---------------- | ---------- |
| 1                | Laura Pérez | Energía Solar | Inglés  |
| 1                | Laura Pérez | Energía Solar | Francés |
| 1                | Laura Pérez | IA Médica     | Inglés  |
| 1                | Laura Pérez | IA Médica     | Francés |
| 2                | Carlos Díaz | IA Médica     | Español |
| 2                | Carlos Díaz | Big Data       | Español |

Aquí hay una ​**dependencia multivaluada**​:
“Los proyectos de un investigador son independientes de los idiomas que habla”.

### Migración paso a paso a 4FN

#### Crear tablas independientes

```sql
CREATE TABLE investigador (
  id_investigador INT PRIMARY KEY,
  nombre VARCHAR(100)
);

CREATE TABLE investigador_proyecto (
  id_investigador INT,
  proyecto VARCHAR(100),
  FOREIGN KEY (id_investigador) REFERENCES investigador(id_investigador)
);

CREATE TABLE investigador_idioma (
  id_investigador INT,
  idioma VARCHAR(50),
  FOREIGN KEY (id_investigador) REFERENCES investigador(id_investigador)
);
```

#### Insertar datos automáticamente con `SELECT DISTINCT`

```sql
INSERT INTO investigador (id_investigador, nombre)
SELECT DISTINCT id_investigador, nombre
FROM investigador_info;

INSERT INTO investigador_proyecto (id_investigador, proyecto)
SELECT DISTINCT id_investigador, proyecto
FROM investigador_info;

INSERT INTO investigador_idioma (id_investigador, idioma)
SELECT DISTINCT id_investigador, idioma
FROM investigador_info;
```

#### Resultado final

**investigador**

| id_investigador | nombre       |
| ------------------ | -------------- |
| 1                | Laura Pérez |
| 2                | Carlos Díaz |

**investigador_proyecto**

| id_investigador | proyecto       |
| ------------------ | ---------------- |
| 1                | Energía Solar |
| 1                | IA Médica     |
| 2                | IA Médica     |
| 2                | Big Data       |

**investigador_idioma**

| id_investigador | idioma   |
| ------------------ | ---------- |
| 1                | Inglés  |
| 1                | Francés |
| 2                | Español |

Eliminamos redundancias sin perder relaciones.
Ahora cada conjunto independiente (proyectos, idiomas) se almacena correctamente.


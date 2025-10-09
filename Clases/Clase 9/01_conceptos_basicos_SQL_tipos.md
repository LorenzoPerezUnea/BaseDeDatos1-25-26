# SQL — Conceptos Básicos, tipos de lenguaje y tipos de datos

SQL (Structured Query Language) es el lenguaje estándar para gestionar y manipular bases de datos relacionales.

Permite crear estructuras, almacenar información, consultarla, actualizarla y controlarla.

SQL no es un lenguaje de programación tradicional, sino un lenguaje declarativo, lo que significa que el usuario indica qué desea obtener o hacer, no cómo lograrlo.

SQL se divide en varios subconjuntos de instrucciones según el tipo de operación que realizan. El lenguaje de definición de datos (DDL, Data Definition Language) define y modifica la estructura de la base de datos, con comandos como CREATE, ALTER, DROP o TRUNCATE.

El lenguaje de manipulación de datos (DML, Data Manipulation Language) manipula los datos almacenados mediante sentencias como SELECT, INSERT, UPDATE y DELETE.

El lenguaje de control de datos (DCL, Data Control Language) se utiliza para controlar los permisos y la seguridad, con GRANT y REVOKE.

Finalmente, el lenguaje de control de transacciones (TCL, Transaction Control Language) gestiona transacciones con comandos como COMMIT, ROLLBACK o SAVEPOINT.

En esta parte del curso nos centraremos exclusivamente en DDL, es decir, en la creación y definición de estructuras.

Todas las sentencias SQL siguen una estructura general: un comando, seguido del objeto sobre el que actúa y sus opciones. Por ejemplo:

```sql
CREATE TABLE cliente (
  id_cliente INT PRIMARY KEY,
  nombre VARCHAR(100),
  telefono VARCHAR(15)
);
```

Las sentencias SQL no distinguen entre mayúsculas y minúsculas (aunque por convención las palabras clave se escriben en mayúsculas), cada sentencia debe terminar con punto y coma (;) y los nombres de tablas y columnas no deben contener espacios ni caracteres especiales.

Los tipos de datos más comunes en SQL permiten definir la naturaleza de cada campo. Algunos de los más utilizados son:

* INT o BIGINT para números enteros
* DECIMAL(p,s)
* FLOAT para valores con decimales
* CHAR(n) y VARCHAR(n) para cadenas de texto de longitud fija o variable
* DATE, TIME y DATETIME para fechas y horas
* BOOLEAN para valores verdadero o falso  TEXT o BLOB para texto o datos binarios extensos.

Es importante elegir el tipo de dato más ajustado al uso previsto, ya que esto optimiza el almacenamiento y el rendimiento.


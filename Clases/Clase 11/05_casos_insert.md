# Comportamiento detallado de la sentencia INSERT en SQL (MySQL)

La sentencia `INSERT` se utiliza para agregar nuevas filas a una tabla existente.

Sin embargo, su comportamiento varía según si se indican o no las columnas, si las columnas permiten valores `NULL`, si tienen valores por defecto (`DEFAULT`), si son obligatorias (`NOT NULL`) o si existen restricciones de integridad referencial (`FOREIGN KEY`). Comprender estos casos es fundamental para evitar errores y manejar los datos correctamente.

Cuando no se especifican las columnas en el `INSERT`, MySQL espera que la lista de valores coincida exactamente con todas las columnas de la tabla, tanto en número como en orden.

Por ejemplo, si la tabla tiene cinco columnas, deben proporcionarse cinco valores, uno para cada columna. Si falta alguno, se genera un error.

Por el contrario, cuando se especifican los nombres de las columnas en el `INSERT`, solo es necesario proporcionar valores para esas columnas, y las demás tomarán su valor por defecto o `NULL` si lo permiten.

```sql
INSERT INTO tabla VALUES (v1, v2, v3, v4);
INSERT INTO tabla (columna1, columna3) VALUES (valor1, valor3);
```

La primera forma inserta valores en todas las columnas en el orden definido en la tabla, mientras que la segunda inserta solo en las columnas indicadas. Las columnas omitidas adoptarán sus valores por defecto o NULL si es posible.

Cuando una columna tiene un valor por defecto (DEFAULT) o permite NULL, es posible omitirla en la inserción sin causar error. En este caso, MySQL usará el valor establecido o NULL automáticamente. Por ejemplo:

```sql
CREATE TABLE ejemplo ( id INT AUTO_INCREMENT PRIMARY KEY, nombre VARCHAR(50) NOT NULL, email VARCHAR(100) DEFAULT NULL, creado TIMESTAMP DEFAULT CURRENT_TIMESTAMP ); ``

INSERT INTO ejemplo (nombre) VALUES ('Ana');
SELECT * FROM ejemplo;
```

Aquí, la columna id se genera automáticamente gracias a AUTO_INCREMENT, email se establece en NULL porque tiene DEFAULT NULL, y creado toma el valor de la fecha y hora actual. El resultado es una fila insertada correctamente sin errores.

Si se omite una columna que está marcada como NOT NULL y no tiene valor por defecto, la inserción fallará. MySQL no podrá asignar un valor válido y mostrará un error. Por ejemplo:

```sql
CREATE TABLE ejemplo2 (
id INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(50) NOT NULL,
edad INT NOT NULL
);

INSERT INTO ejemplo2 (nombre) VALUES ('Luis');
El resultado será el error:

ERROR 1364 (HY000): Field 'edad' doesnt have a default value
```

Las columnas definidas con AUTO_INCREMENT generan automáticamente su valor secuencial, por lo que no es necesario incluirlas en el INSERT. Por ejemplo:

```sql
CREATE TABLE ejemplo3 (
id INT AUTO_INCREMENT PRIMARY KEY,
descripcion VARCHAR(100)
);

INSERT INTO ejemplo3 (descripcion) VALUES ('Item A');
```

En este caso, MySQL asigna el siguiente número consecutivo al campo id, por lo que solo se necesita especificar la descripción.

También es posible usar la palabra clave DEFAULT explícitamente cuando se desea que una columna tome su valor predeterminado definido en la tabla:

```sql
INSERT INTO ejemplo (nombre, email) VALUES ('María', DEFAULT);
El campo email se insertará con NULL o con el valor indicado como DEFAULT en la definición de la tabla.
```

Si se usa INSERT INTO tabla VALUES(...) con una cantidad de valores distinta al número de columnas definidas, MySQL mostrará un error. Por ejemplo:

```sql
INSERT INTO tabla VALUES (1, 'x');
Si la tabla tiene más de dos columnas, se generará el error:

ERROR 1136 (21S01): Column count doesnt match value count at row 1
Por eso es buena práctica siempre listar las columnas en el INSERT.
```

Cuando una tabla contiene una clave foránea (FOREIGN KEY) y se intenta insertar un valor que no tiene correspondencia en la tabla referenciada, la operación será rechazada. Por ejemplo:

```sql
CREATE TABLE padre (
id INT PRIMARY KEY
);

CREATE TABLE hijo (
id INT PRIMARY KEY,
padre_id INT,
FOREIGN KEY (padre_id) REFERENCES padre(id)
);

INSERT INTO hijo (id, padre_id) VALUES (1, 999);

El resultado será:

ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails
```

Esto ocurre porque padre.id = 999 no existe. Para que la inserción sea válida, el valor debe existir en la tabla padre o la columna padre_id debe aceptar NULL.

Si se usa una sentencia INSERT INTO ... SELECT ... que copia datos desde otra tabla, las mismas reglas se aplican. Si el SELECT genera valores de clave foránea que no existen en la tabla padre, la inserción fallará. Por ejemplo:

```sql
INSERT INTO hijo (id, padre_id)
SELECT id, padre_id FROM otra_tabla;
```

En este caso, las claves foráneas serán verificadas una por una.

MySQL puede trabajar en modo estricto o modo no estricto, lo que afecta el comportamiento de INSERT.
En modo STRICT, MySQL rechaza inserciones con valores inválidos o faltantes.
En modo no-STRICT, MySQL permite insertar valores truncados o sustituir NULL o 0 sin error, pero genera avisos (warnings).

Para consultar los avisos generados:

```sql
SHOW WARNINGS;
```

El modo estricto es el recomendado para evitar inserciones silenciosas que puedan corromper la integridad de los datos.

Ejemplos resumidos de comportamientos posibles

```sql
-- Insertar omitiendo columnas opcionales
INSERT INTO producto (nombre) VALUES ('X');
-- Correcto: columnas omitidas toman DEFAULT o NULL o valor autogenerado.

-- Omitir columna NOT NULL sin DEFAULT
INSERT INTO ejemplo2 (nombre) VALUES ('Luis');
-- Error: Field 'edad' doesn't have a default value.

-- Insertar valor de clave foránea inexistente
INSERT INTO hijo (id, padre_id) VALUES (1, 999);
-- Error: Cannot add or update a child row.

-- Usar DEFAULT explícito
INSERT INTO ejemplo (nombre, email) VALUES ('Luis', DEFAULT);
-- Correcto: email toma valor por defecto.

-- Insert múltiple
INSERT INTO producto (nombre, precio) VALUES ('A',10),('B',20);
-- Correcto: inserta múltiples filas.
```

## Buenas prácticas recomendadas

* Siempre indicar las columnas explícitamente en INSERT para evitar errores de orden o estructura.
* Definir valores por defecto adecuados (DEFAULT) para campos NOT NULL.
* Mantener activo el modo STRICT para detectar errores de integridad en tiempo de ejecución.
* Verificar las relaciones de claves foráneas antes de insertar datos dependientes.
* Probar primero las inserciones sin restricciones antes de activar las claves foráneas para depurar más fácilmente.
* No desactivar FOREIGN_KEY_CHECKS salvo en procesos controlados y restaurarlo inmediatamente.
* Usar TIMESTAMP DEFAULT CURRENT_TIMESTAMP cuando se desee registrar la fecha y hora del momento de la inserción.


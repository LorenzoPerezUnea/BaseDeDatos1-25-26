# SQL — Conceptos Básicos, restricciones o constraints

Las restricciones o constraints garantizan la integridad de los datos y definen las reglas que deben cumplir las columnas.

Las principales son:

* PRIMARY KEY (clave primaria) para identificar de forma única cada fila
* FOREIGN KEY (clave foránea) para definir relaciones entre tablas
* UNIQUE para evitar valores duplicados
* NOT NULL para impedir valores nulos
* CHECK para validar una condición
* DEFAULT para establecer un valor por defecto.

Por ejemplo:

```sql
CREATE TABLE cliente (
id_cliente INT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
email VARCHAR(100) UNIQUE,
edad INT CHECK (edad >= 18),
activo BOOLEAN DEFAULT TRUE
);
```

La clave primaria (PK) identifica de manera única cada registro, mientras que la clave foránea (FK) establece la relación entre una tabla hija y su tabla padre.

En el siguiente ejemplo, cada pedido pertenece a un cliente, y esa relación se asegura mediante la clave foránea id_cliente:

```sql
CREATE TABLE cliente (
id_cliente INT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL
);

CREATE TABLE pedido (
id_pedido INT PRIMARY KEY,
fecha DATE NOT NULL,
id_cliente INT,
FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);
```

La integridad referencial es el conjunto de reglas que garantizan que las relaciones entre tablas se mantengan coherentes.

Esto significa que una clave foránea solo puede tomar valores que existan en la clave primaria de la tabla a la que hace referencia.

Si existe un pedido con id_cliente = 5, debe existir un cliente con id_cliente = 5.

Si se elimina ese cliente, deben definirse reglas que indiquen qué hacer con sus pedidos.

SQL ofrece varias opciones para definir el comportamiento ante eliminaciones o actualizaciones en cascada:

```sql
FOREIGN KEY (id_cliente)
REFERENCES cliente(id_cliente)
ON DELETE CASCADE
ON UPDATE SET NULL;
```

Las acciones posibles son: CASCADE, que elimina o actualiza también los registros hijos cuando cambia el padre;

SET NULL, que coloca el valor de la clave foránea en NULL;

RESTRICT o NO ACTION, que impiden la eliminación o actualización si existen registros dependientes.

La elección depende de la lógica de negocio: por ejemplo, si eliminar un cliente debe eliminar automáticamente sus pedidos, se usa CASCADE; si deben conservarse pero desvincularse, se usa SET NULL.

En resumen, SQL es un lenguaje universal para la definición y gestión de datos en sistemas relacionales.

Sus componentes de definición estructural (DDL) constituyen la base de todo sistema de información relacional, permitiendo diseñar las entidades, sus atributos y las relaciones entre ellas antes de pasar al manejo de la información.

Comprender cómo se definen las tablas, sus tipos de datos y las restricciones que garantizan la integridad es el primer paso esencial para construir bases de datos robustas, coherentes y seguras.


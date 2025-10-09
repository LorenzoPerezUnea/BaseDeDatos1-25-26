# El Modelo Relacional

Este modelo es la base formal sobre la que operan la mayoría de los sistemas de gestión de bases de datos modernos y ofrece un marco riguroso y uniforme para representar datos y las operaciones que se pueden realizar sobre ellos.

Una base de datos relacional se organiza como un conjunto de **relaciones**, que de manera intuitiva se pueden representar como tablas.

Cada relación está definida por un **esquema**, que especifica su nombre y su lista de atributos.

Cada atributo está asociado a un **dominio**, es decir, el conjunto de valores válidos que puede tomar.

El contenido actual de la relación se denomina **instancia** de la relación y está compuesto por un conjunto de **tuplas**.

Cada tupla es un conjunto de pares atributo-valor que cumplen el esquema.

Comunmente le llamamos a las tuplas como filas.

Una propiedad esencial es que la relación es un conjunto matemático, por lo que **no existen tuplas duplicadas** y el **orden de las tuplas no tiene significado**.

El esquema de relación es relativamente estático: permanece fijo salvo que se altere la definición en el diseño de la base de datos.

En cambio, la instancia de relación es dinámica y se modifica mediante operaciones de inserción, actualización y eliminación de datos.

Por ejemplo, el esquema EMPLEADO(id, nombre, departamento, salario) define los atributos de la relación EMPLEADO, mientras que la instancia está compuesta por las filas que representan a los empleados registrados en la base de datos en un momento dado.

La distinción entre **esquema** e **instancia** es fundamental para comprender la independencia lógica de los datos, ya que el diseño no depende de cuántas tuplas contenga la relación en un momento determinado, ni de los valores concretos presentes.


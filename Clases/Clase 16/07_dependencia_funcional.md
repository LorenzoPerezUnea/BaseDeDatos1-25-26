# DEPENDENCIA FUNCIONAL

El concepto de dependencia funcional aparece en varios contextos de la matemática y la lógica y se refiere a que determinadas entidades matemáticas se expresan como funciones matemáticas de otras entidades.

## Teorema de Dependencia Funcional

La dependencia funcional viene a ser una generalización del concepto de dependencia lineal. Un conjunto de funciones es funcionalmente dependiente cuando existe una relación funcional entre ellas, o también, cuando alguna de las funciones del conjunto es expresable como función de las otras funciones del conjunto.


Se dice que un atributo **Y depende funcionalmente de otro atributo X** (escrito como `X → Y`) cuando ​**cada valor de X está asociado a un único valor de Y**​.

En otras palabras:
si conoces el valor de X, puedes determinar exactamente el valor de Y.

### Ejemplo práctico

| id\_cliente | nombre | ciudad    |
| ------------- | -------- | ----------- |
| 1           | Ana    | Quito     |
| 2           | Bruno  | Guayaquil |
| 3           | Carla  | Cuenca    |

Aquí:

* `id_cliente → nombre`
* `id_cliente → ciudad`

porque cada cliente tiene un solo nombre y una sola ciudad.

Pero ​**no se cumple**​:

* `ciudad → nombre`,
  porque en una misma ciudad puede haber varios nombres distintos.

### Definición formal (en lenguaje sencillo)

Sean X e Y conjuntos de atributos en una relación R.
Decimos que **Y depende funcionalmente de X (X → Y)** si y solo si,
para cada par de tuplas (filas) en R, cuando las columnas X tienen el mismo valor,
entonces las columnas Y también lo tienen.

Matemáticamente:

> Si t₁[X] = t₂[X] ⇒ t₁[Y] = t₂[Y]

### Dependencia funcional completa y parcial

* **Dependencia completa:**
  Y depende de todo el conjunto de X, no solo de una parte.
  Ejemplo: `(id_pedido, id_producto) → cantidad`
  La cantidad depende del pedido y del producto juntos.
* **Dependencia parcial:**
  Cuando Y depende solo de una parte del conjunto de X.
  Ejemplo: `(id_pedido, id_producto) → fecha_pedido`
  En realidad, la fecha depende solo de `id_pedido`, no del producto.

### Aplicación práctica

Las dependencias funcionales sirven para:

* **Detectar redundancias** en una tabla.
* **Evitar anomalías** de actualización, inserción o eliminación.
* **Guiar la normalización** (transformar tablas en formas más eficientes).

### Ejemplo más avanzado

| id\_empleado | departamento | jefe\_departamento |
| -------------- | -------------- | -------------------- |
| 1            | Ventas       | López             |
| 2            | Ventas       | López             |
| 3            | Compras      | Gómez             |

Aquí se cumple:

* `departamento → jefe_departamento` (cada departamento tiene un único jefe)
* pero ​**no al revés**​: `jefe_departamento → departamento` no siempre se cumple, ya que un jefe podría encargarse de más de un departamento.
  
  En resumen:

| Concepto                       | Explicación simple                   | Ejemplo                                     |
| -------------------------------- | --------------------------------------- | --------------------------------------------- |
| **X → Y**               | Si conozco X, puedo saber Y           | id\_cliente → nombre                       |
| **Dependencia completa** | Y depende de todos los atributos de X | (id\_pedido, id\_producto) → cantidad      |
| **Dependencia parcial**  | Y depende solo de parte de X          | (id\_pedido, id\_producto) → fecha\_pedido |

## Lógica

Sean x e y atributos o conjunto de atributos de una relación R. Entonces se dice que **y depende funcionalmente de x** (denotado por ​*x → y*​) si cada valor de x tiene asociado un solo valor de y.

A x se le denomina **determinante** (de y).

Se dice que el atributo **y** es completamente dependiente de **x** si depende funcionalmente de x y no depende de ningún subconjunto propio de x.


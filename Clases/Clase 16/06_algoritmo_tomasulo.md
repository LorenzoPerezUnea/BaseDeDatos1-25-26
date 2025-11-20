# Algoritmo de Tomasulo

Este algoritmo de planificación dinámica fue desarrollado por **Robert Tomasulo** para la IBM. Fue diseñado para permitir a un procesador ejecutar instrucciones fuera de orden.

Este algoritmo difiere del algoritmo de marcador (scoreboard) en que este último no dispone de renombrado de registros. En su lugar, el scoreboarding resuelve los riesgos **WAW** (​*Write After Write*​) y **WAR** (​*Write After Read*​) deteniendo la ejecución, mientras que el algoritmo de Tomasulo permite el lanzamiento de dichas instrucciones.

Además, el algoritmo de Tomasulo utiliza un **bus de datos común** en el que los valores calculados son enviados a todas las estaciones de reserva que los necesiten. Esto permite mejorar la ejecución paralela de las instrucciones en situaciones en las que el scoreboarding fallaría y provocaría la parada.

Este algoritmo fue implementado por primera vez en la **unidad de punto flotante** del procesador ​**IBM 360/91**​.

Actualmente, la mayoría de los procesadores hacen uso de variaciones de este algoritmo para la planificación dinámica de instrucciones.

### Problema que resuelve

En los procesadores tradicionales, las instrucciones se ejecutan una tras otra, esperando a que cada una termine para continuar.
Esto causa **bloqueos innecesarios** cuando una instrucción depende del resultado de otra (por ejemplo, una instrucción necesita leer un valor que aún no ha sido calculado).

Tomasulo resolvió esto permitiendo que las instrucciones **no dependientes** continúen ejecutándose mientras las dependientes esperan sus datos.

### Conceptos clave

* **Estaciones de reserva:**
  Son pequeñas “colas” donde se almacenan temporalmente las instrucciones hasta que todos sus operandos estén listos.
  Cada estación tiene información sobre la operación que debe ejecutar y qué registros necesita.
* **Renombrado de registros:**
  Para evitar conflictos entre instrucciones que usan el mismo registro, Tomasulo ​**renombra los registros lógicamente**​.
  En lugar de que dos instrucciones escriban en el mismo registro físico, cada una usa una ​**etiqueta o alias temporal**​.
  Esto elimina las dependencias *WAR (Write After Read)* y ​*WAW (Write After Write)*​.
* **Bus de resultados común (CDB – Common Data Bus):**
  Es un “canal de comunicación” que distribuye los resultados de una operación a todas las instrucciones que los necesitan, sin pasar por el registro central.
  Así, una instrucción puede continuar en cuanto el dato llega al bus, incluso si no se ha escrito todavía en el registro definitivo.

### Etapas simplificadas del algoritmo

1. **Emisión (Issue):**
   La instrucción se envía a una estación de reserva si hay espacio y la unidad funcional requerida está libre.
   Se asignan etiquetas para los registros que va a usar o producir.
2. **Esperar operandos (Wait for operands):**
   Si la instrucción necesita datos que aún no están disponibles, espera en la estación de reserva.
   Si los datos ya están en el bus o llegan mientras espera, los toma directamente.
3. **Ejecución (Execution):**
   Cuando todos los operandos están listos, la instrucción se ejecuta en la unidad funcional correspondiente (por ejemplo, ALU, multiplicador, etc.).
4. **Escritura de resultado (Write result):**
   El resultado no se escribe directamente en un registro, sino que ​**se emite por el bus de datos común (CDB)**​.
   Todas las estaciones que estaban esperando ese valor lo reciben simultáneamente.
   Una vez propagado, el resultado se guarda en el registro físico correspondiente.

### Ventajas del algoritmo de Tomasulo

* Permite ​**ejecución fuera de orden**​: las instrucciones independientes avanzan aunque otras estén esperando datos.
* **Minimiza bloqueos** al eliminar dependencias falsas (WAR, WAW).
* **Aumenta el paralelismo** en la ejecución de instrucciones.
* ​**Aprovecha mejor las unidades funcionales**​, ya que no quedan ociosas esperando datos.

### Ejemplo sencillo

Supón las siguientes instrucciones:

1. R2 ← R1 + R3
2. R4 ← R2 × R5
3. R6 ← R7 + R8

En un procesador tradicional, la instrucción 2 debería esperar a que la 1 termine, porque depende de R2.
Pero la instrucción 3 ​**no depende de ninguna de las anteriores**​, así que Tomasulo permite que la instrucción 3 se ejecute mientras la 2 espera.
Esto mejora la eficiencia y evita tiempos muertos en la CPU.


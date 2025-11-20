# SOLUCIONES AL PROBLEMA DE LA DEPENDENCIA

Se puede delegar la tarea de la eliminación de dependencias de datos al compilador, que completará con instrucciones **NOP** el código necesario para asegurar la corrección del resultado del programa, o reordenando las instrucciones en las partes del código donde sea necesario.

Hay otros métodos que se implementan en hardware (chips) y son:

* Algoritmo de marcador
* Algoritmo de Tomasulo

### Algoritmo de marcador

Este es un método centralizado, utilizado en el **CDC 6600** para planificar de manera dinámica la segmentación, de forma que las instrucciones se ejecuten fuera de orden cuando no hay conflictos y el hardware está disponible.

Trabaja registrando en un marcador las dependencias de datos de cada instrucción. Las instrucciones son emitidas solo cuando el marcador determina que ya no hay conflictos con las instrucciones previamente ejecutadas o en ejecución.

Si una instrucción sufre la inserción de una burbuja por considerarse insegura su ejecución, el marcador entonces vigilará el flujo de ejecución de las instrucciones hasta que todas las dependencias hayan sido resueltas, pudiendo así ser relanzada la instrucción detenida.

### Etapas del algoritmo de marcador

Las instrucciones se decodifican en orden y pasan por cuatro etapas:

a) **Issue (Emisión):** el sistema verifica los registros que serán leídos o modificados por la instrucción. El procesador puede acceder a esta información cuando sea necesario en alguna de las siguientes etapas. Para poder evitar dependencias de salida (WAW - ​*Write After Write*​) se inserta una burbuja en la instrucción hasta que todas las instrucciones que pretenden escribir en el mismo registro se completen. La instrucción también se detiene si alguna de las unidades funcionales se encuentra ocupada.

b) **Read Operands (Lectura de operandos):** una vez que la instrucción ha sido emitida y se ha comprobado que todas las unidades funcionales necesarias están libres, la instrucción espera a que los operandos estén disponibles. Este procedimiento resuelve las dependencias verdaderas (RAW - ​*Read After Write*​) ya que los registros que serán modificados por alguna otra instrucción no son considerados como disponibles hasta que son realmente modificados.

c) **Execution (Ejecución):** cuando todos los operandos han sido capturados, la unidad funcional inicia la ejecución. Cuando el resultado está disponible, el marcador recibe una notificación.

d) **Write Result (Escritura de resultados):** en esta etapa se intenta la escritura del resultado en el correspondiente registro de destino. Esta operación se retrasa hasta que las instrucciones que intentan leer los registros en que esta instrucción pretende escribir han completado su etapa de lectura de operandos. Esto permite resolver las dependencias (WAR - ​*Write After Read*​).

### Estructura de datos

Para poder controlar la ejecución de las instrucciones, el marcador mantiene tres tablas de estados como se muestra a continuación:

* **Instruction Status (Estados de instrucción):** por cada instrucción en ejecución indica en qué etapa de las cuatro se encuentra.
* **Functional Unit Status (Estados de unidad funcional):** indica el estado de cada unidad funcional, manteniendo cada una de ellas nueve campos en la tabla:
  * Busy (Ocupado): indica si la unidad está siendo utilizada o no.
  * Op (Operación): operación a realizar en la unidad (por ejemplo: MUL, DIV, MOD).
  * Fi: registro de destino.
  * Fj, Fk: números de registros fuente.
  * Qj, Qk: unidades funcionales que producirán el resultado a leer de los registros fuente Fj, Fk.
  * Rj, Rk: marcas que indican cuando los registros Fj, Fk están listos.
* **Register Status (Estados de registro):** por cada registro indica qué unidad funcional escribirá en él su resultado.


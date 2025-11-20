# DEPENDENCIA DE DATOS

Dependencia de datos es una situación en la que las instrucciones de un programa se refieren a los resultados de otras anteriores que aún no han sido completadas. Si dichas dependencias no se resuelven pueden ocasionar riesgos de datos o incluso condiciones de inconsistencia. El área de estudio de las dependencias de datos se conoce como análisis de dependencias.

## TIPOS DE DEPENDENCIA

Se pueden identificar tres tipos de dependencias de datos:

* **RAW** - *Read After Write*
* **WAR** - *Write After Read*
* **WAW** - *Write After Write*

### Dependencia RAW - Read After Write

Este tipo de dependencia RAW se refiere a una situación donde se necesita un dato que aún no ha sido calculado, por ejemplo:

> Paso 1: R2 <- R1 + R3
> 
> Paso 2: R4 <- R2 + R3

En el paso 1 se calcula un valor que será guardado en el registro R2, mientras que el segundo paso necesita este valor para computarlo y almacenar el resultado en el registro R4. Sin embargo, en un procesador segmentado, cuando se capturan los operandos para realizar la segunda instrucción, los resultados de la primera aún no han sido guardados, de forma que aparecerá una dependencia de datos.

Se dice que existe una dependencia de datos en la instrucción 2, la cual depende de la finalización de la instrucción 1.

### Dependencia WAR - Write After Read

Esta dependencia WAR se representa cuando hay un problema de ejecución concurrente, por ejemplo:

> Paso 1: R1 <- R2 + R3
> Paso 2: R3 <- R4 × R5

En este caso, si la instrucción 2 puede finalizar antes de que lo haga la 1 (por ejemplo, cuando se ejecutan en equipos que soportan concurrencia de procesos), es necesario asegurarse de que no se almacenará el resultado en el registro R3 antes de que la instrucción 1 haya podido leer sus operandos.

### Dependencia WAW - Write After Write

Esta dependencia WAW es otra de las posibles situaciones que pueden presentarse en un entorno de ejecución concurrente, por ejemplo:

> Paso 1: R2 <- R1 + R3
> Paso 2: R2 <- R4 × R7

En este caso debe retrasarse la escritura (etapa ​*WB*​) de la instrucción 2 hasta que la instrucción 1 haya finalizado.


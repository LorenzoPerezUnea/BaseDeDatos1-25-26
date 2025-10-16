# Conceptos charset y collate

```sql
CREATE
CHARACTER SET utf8mb4
COLLATE utf8mb4_general_ci;
```

## CHARACTER SET: cómo se codifican los caracteres

`CHARACTER SET` define **el sistema de codificación** que usará MySQL para representar cada símbolo o letra como una secuencia de bytes.

* `latin1` usa un solo byte por carácter (256 símbolos posibles).
  Solo sirve para textos en inglés y algunas lenguas europeas occidentales.
* `utf8` (en MySQL clásico) usa hasta 3 bytes por carácter.
  Puede almacenar la mayoría de los idiomas europeos, pero ​**no soporta todos los emojis ni ciertos ideogramas**​.
* `utf8mb4` usa hasta 4 bytes por carácter.
  Es el **estándar moderno recomendado** porque puede representar ​*cualquier símbolo Unicode*​,
  incluyendo emojis (😊), caracteres chinos (漢), árabes (ع), acentos y signos especiales.

## COLLATE: cómo se comparan y ordenan los textos

`COLLATE` (o ​*collation*​) especifica **las reglas de comparación y ordenamiento** de los caracteres definidos en el `CHARACTER SET`.

Dicho de otro modo:

* `CHARACTER SET` dice ​*qué letras existen*​.
* `COLLATE` dice *cómo se comparan* esas letras entre sí (mayúsculas, acentos, orden alfabético, etc.).

| COLLATE                  | Comparación 'Á' = 'A'                                  | Ordenamiento resultante     |
| -------------------------- | ---------------------------------------------------------- | ----------------------------- |
| `utf8mb4_general_ci` | **Sí**(no distingue acentos)                      | Árbol, avión, Auto, barco |
| `utf8mb4_spanish_ci` | ​**Sí**​, pero usa reglas del español (ñ, ch) | Auto, avión, Árbol, barco |
| `utf8mb4_bin`        | ​**No**​, distingue acentos y mayúsculas        | Auto, Árbol, avión, barco |


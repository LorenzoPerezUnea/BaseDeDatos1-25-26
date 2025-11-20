# Quinta Forma Normal (5FN)

### Dependencias de Unión y Normalización Compleja

La **Quinta Forma Normal (5FN)** o **Forma Normal de Proyección–Unión (PJNF)** se alcanza cuando no existen **dependencias de unión** no triviales.
Esto significa que ninguna tabla puede descomponerse más sin perder información, y que solo se mantienen ​**dependencias derivadas de claves candidatas**​.

## Escenario realista: Red de distribución internacional

Una empresa logística registra qué **proveedores** distribuyen qué **productos** a qué ​**regiones**​.
No todos los proveedores pueden enviar todos los productos a todas las regiones, pero hay intersecciones entre ellos.

### Tabla sin normalizar (no cumple 5FN)

```sql
CREATE TABLE distribucion (
  proveedor VARCHAR(50),
  producto VARCHAR(50),
  region VARCHAR(50)
);

INSERT INTO distribucion VALUES
('GlobalTrade', 'Microchip', 'Europa'),
('GlobalTrade', 'Microchip', 'Asia'),
('GlobalTrade', 'Sensores', 'Europa'),
('ElectroHub', 'Sensores', 'América'),
('ElectroHub', 'Microchip', 'América'),
('TechDistrib', 'Cables', 'Europa');
```

| proveedor   | producto  | región  |
| ------------- | ----------- | ---------- |
| GlobalTrade | Microchip | Europa   |
| GlobalTrade | Microchip | Asia     |
| GlobalTrade | Sensores  | Europa   |
| ElectroHub  | Sensores  | América |
| ElectroHub  | Microchip | América |
| TechDistrib | Cables    | Europa   |

Aquí existe una **dependencia de unión (join dependency)** porque la tabla puede descomponerse en tres subconjuntos:

* proveedor ↔ producto
* producto ↔ región
* proveedor ↔ región

Y a partir de ellos se puede reconstruir el original sin pérdida.

### Migración a 5FN

#### Crear relaciones descompuestas

```sql
CREATE TABLE proveedor_producto (
  proveedor VARCHAR(50),
  producto VARCHAR(50)
);

CREATE TABLE producto_region (
  producto VARCHAR(50),
  region VARCHAR(50)
);

CREATE TABLE proveedor_region (
  proveedor VARCHAR(50),
  region VARCHAR(50)
);
```

#### Insertar datos automáticamente

```sql
INSERT INTO proveedor_producto (proveedor, producto)
SELECT DISTINCT proveedor, producto FROM distribucion;

INSERT INTO producto_region (producto, region)
SELECT DISTINCT producto, region FROM distribucion;

INSERT INTO proveedor_region (proveedor, region)
SELECT DISTINCT proveedor, region FROM distribucion;
```

#### Resultado final

**proveedor_producto**

| proveedor   | producto  |
| ------------- | ----------- |
| GlobalTrade | Microchip |
| GlobalTrade | Sensores  |
| ElectroHub  | Sensores  |
| ElectroHub  | Microchip |
| TechDistrib | Cables    |

**producto_region**

| producto  | región  |
| ----------- | ---------- |
| Microchip | Europa   |
| Microchip | Asia     |
| Sensores  | Europa   |
| Sensores  | América |
| Cables    | Europa   |

**proveedor_region**

| proveedor   | región  |
| ------------- | ---------- |
| GlobalTrade | Europa   |
| GlobalTrade | Asia     |
| ElectroHub  | América |
| TechDistrib | Europa   |

#### Reconstrucción de la tabla original

```sql
SELECT DISTINCT pp.proveedor, pr.producto, prg.region
FROM proveedor_producto pp
JOIN producto_region pr ON pp.producto = pr.producto
JOIN proveedor_region prg ON pp.proveedor = prg.proveedor
WHERE prg.region = pr.region;
```

 Este `JOIN` reconstruye la información original ​**sin pérdida ni redundancia**​.
Si la unión generara combinaciones que no existían antes, el diseño ​**no cumpliría 5FN**​.


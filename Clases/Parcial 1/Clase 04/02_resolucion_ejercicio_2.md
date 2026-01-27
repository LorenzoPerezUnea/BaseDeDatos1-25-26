## Entidades y Atributos

**USUARIO**

* id\_usuario (PK)
* nombre
* email
* telefono

**CLIENTE** (subtipo de USUARIO)

* id\_cliente (PK, FK a USUARIO)
* fecha\_registro
* nivel\_fidelidad

**VENDEDOR** (subtipo de USUARIO)

* id\_vendedor (PK, FK a USUARIO)
* reputacion
* fecha\_alta

**CATEGORIA**

* id\_categoria (PK)
* nombre
* id\_categoria\_padre (FK, nullable para categorías raíz)

**PRODUCTO**

* id\_producto (PK)
* id\_vendedor (FK)
* nombre
* descripcion
* id\_categoria (FK)

**VARIANTE\_PRODUCTO**

* id\_variante (PK)
* id\_producto (FK)
* talla
* color
* sku

**ALMACEN**

* id\_almacen (PK)
* id\_vendedor (FK)
* nombre
* direccion

**INVENTARIO**

* id\_inventario (PK)
* id\_almacen (FK)
* id\_variante (FK)
* cantidad\_disponible
* cantidad\_reservada

**PEDIDO**

* id\_pedido (PK)
* id\_cliente (FK)
* fecha\_creacion
* estado\_pedido

**LINEA\_PEDIDO**

* id\_linea (PK)
* id\_pedido (FK)
* id\_variante (FK)
* id\_almacen (FK)
* id\_envio (FK, nullable)
* cantidad
* precio\_unitario

**ENVIO (Shipment)**

* id\_envio (PK)
* estado\_envio
* fecha\_envio
* codigo\_seguimiento

**PAGO**

* id\_pago (PK)
* id\_pedido (FK)
* monto
* metodo\_pago
* estado\_pago

**REEMBOLSO**

* id\_reembolso (PK)
* id\_pago (FK)
* monto\_devuelto
* motivo

**DEVOLUCION**

* id\_devolucion (PK)
* id\_linea (FK)
* motivo
* estado

**PROMOCION**

* id\_promocion (PK)
* nombre
* tipo\_aplicacion (por\_producto, por\_categoria, por\_pedido)
* porcentaje\_descuento
* fecha\_inicio / fecha\_fin

**RESEÑA**

* id\_resena (PK)
* id\_cliente (FK)
* id\_producto (FK)
* calificacion
* comentario

**HISTORIAL\_PRECIO**

* id\_historial (PK)
* id\_variante (FK)
* precio
* fecha\_inicio
* fecha\_fin

**LOG\_AUDITORIA**

* id\_log (PK)
* entidad\_afectada
* id\_entidad
* usuario\_responsable
* fecha
* descripcion

## Relaciones y Cardinalidades (bidireccionales)

* **Usuario–Cliente:** Usuario puede ser cliente (1:1 opcional), Cliente es un usuario (1:1)
* **Usuario–Vendedor:** Usuario puede ser vendedor (1:1 opcional), Vendedor es un usuario (1:1)
* **Vendedor–Producto:** Vendedor publica productos (1:N), Producto pertenece a un vendedor (N:1)
* **Producto–Variante:** Producto tiene variantes (1:N), Variante pertenece a producto (N:1)
* **Producto–Categoría:** Producto pertenece a categoría (N:1), Categoría agrupa productos (1:N)
* **Categoría–Categoría:** Categoría padre contiene subcategorías (1:N), Subcategoría pertenece a categoría padre (N:1)
* **Variante–Inventario:** Variante tiene registros de inventario (1:N), Inventario corresponde a variante (N:1)
* **Almacén–Inventario:** Almacén gestiona inventario (1:N), Inventario pertenece a almacén (N:1)
* **Vendedor–Almacén:** Vendedor tiene almacenes (1:N), Almacén pertenece a un vendedor (N:1)
* **Cliente–Pedido:** Cliente realiza pedidos (1:N), Pedido pertenece a cliente (N:1)
* **Pedido–LíneaPedido:** Pedido contiene líneas (1:N), Línea pertenece a pedido (N:1)
* **Variante–LíneaPedido:** Variante puede aparecer en varias líneas (1:N), Línea se refiere a una variante (N:1)
* **LíneaPedido–Envío:** Cada línea se despacha en un envío (N:1), un envío agrupa varias líneas (1:N)
* **Almacén–LíneaPedido:** El stock de cada línea se surte desde un almacén (N:1)
* **Pedido–Pago:** Pedido puede tener varios pagos (1:N), Pago pertenece a pedido (N:1)
* **Pago–Reembolso:** Pago genera reembolsos (1:N), Reembolso pertenece a pago (N:1)
* **LíneaPedido–Devolución:** Línea puede ser devuelta (0..N), Devolución corresponde a línea (N:1)
* **Promoción–Producto:** Promoción aplica a productos (M:N), Producto tiene promociones aplicables (M:N)
* **Cliente–Reseña:** Cliente escribe reseñas (1:N), Reseña pertenece a cliente (N:1)
* **Producto–Reseña:** Producto recibe reseñas (1:N), Reseña corresponde a producto (N:1)
* **Variante–HistorialPrecio:** Variante registra historial (1:N), Historial corresponde a variante (N:1)


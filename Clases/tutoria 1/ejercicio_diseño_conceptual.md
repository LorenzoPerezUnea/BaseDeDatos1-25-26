# Diseño Conceptual

* Es una empresa intermediaria cuya función es proveer insumos industriales a empresas industriales.
* Un cliente hace un pedido que puede tener uno a muchos productos, por tipo de producto no por marca.
* La empresa debe cotizar cada producto con sus proveedores, y presentar al cliente tres cotizaciones para casa producto pedido, con los 3 mejores precios.
* El Intermediario consolidad grupos de solictudes por proveedor.
* El proveedor hacer una oferta con vrios productos consolidados.
* El cliente elegirá una sola cotización por producto y realizará el pago.
* Modelemos hasta la cotización (no medlamos la siguiente parte del proceso que es recibir el pago de los clientes para comprar al proveedor, recibir los productos en bodegam, consolidar el paquete y enviar al cliente ).
  
  ## Entidades

| Entidad                          | Descripción                                                                 |
|----------------------------------|------------------------------------------------------------------------------|
| CLIENTE                          | Empresa industrial que solicita cotizaciones.                               |
| SOLICITUD_COTIZACION_CLIENTE     | Solicitud de cotización de un cliente.                                      |
| DETALLE_SOLICITUD_COTIZACION_CLIENTE | Productos genéricos pedidos por ese cliente.                             |
| TIPO_PRODUCTO                    | Tipo de producto sin marca ni modelo.                                       |
| SOLICITUD_PROVEEDOR              | Solicitud de cotización enviada a un proveedor (emitida por el intermediario). |
| DETALLE_SOLICITUD_PROVEEDOR      | Lista de productos genéricos solicitados a ese proveedor (pueden provenir de varios clientes). |
| PROVEEDOR                        | Empresa que ofrece insumos.                                                 |
| OFERTA_PROVEEDOR                 | Cotización que responde a una solicitud del intermediario.                  |
| DETALLE_OFERTA_PROVEEDOR         | Detalle de productos específicos, precios y condiciones ofrecidos.          |
| PRODUCTO                         | Variante concreta del producto genérico (marca/modelo).                     |


## Relaciones

| Relación | Dirección 1 | Dirección 2 | Cardinalidad |
|-----------|-------------|--------------|--------------|
| CLIENTE ↔ COTIZACION\_CLIENTE | Cliente **realiza** cotizaciones | Cotización **es realizada por** un cliente | 1:N |
| SOLICTUD_COTIZACION\_CLIENTE ↔ DETALLE\_SOLICTUD_COTIZACION\_CLIENTE | Cotización **contiene** detalles | Detalle **pertenece a** una cotización | 1:N |
| DETALLE\_SOLICITUD\_CLIENTE ↔TIPO_PRODUCTO | Detalle **requiere** un producto | Producto **es requerido en** varios detalles | N:1 |
| TIPO_PRODUCTO ↔ DETALLE\_SOLICITUD\_PROVEEDOR | Producto **agrupa** solicitudes a proveedor | Solicitud **consolida** productos | 1:N |
| SOLICITUD\_PROVEEDOR ↔ PROVEEDOR | Solicitud **se envía a** un proveedor | Proveedor **recibe** solicitudes | N:1 |
| OFERTA\_PROVEEDOR ↔ DETALLE\_OFERTA\_PROVEEDOR | Oferta **incluye** detalles | Detalle **forma parte de** una oferta | 1:N |
| DETALLE\_OFERTA\_PROVEEDOR ↔ PRODUCTO | Detalle **corresponde a** producto específico | Producto específico **aparece en** muchos detalles | N:1 |
| PRODUCTO ↔TIPO_PRODUCTO | Producto específico **es variante de** tipo de producto | Producto genérico **tiene variantes** | N:1 |


# Modelo Entidad-Relación (Chen) - Plataforma de Eventos

## Entidades
- **Evento**
- **Sesión**
- **Ticket**
- **Cliente**
- **Check-in**
- **Descuento**
- **Asiento**

---

## Principales Verbos y Relaciones
- **Cliente** compra **Ticket** `(1,M)`
- **Cliente** registra **Check-in** cuando se utiliza **Ticket** `(1,M)`
- **Evento** tiene **Sesión** `(1,M)`
- **Sesión** tiene **Ticket** `(1,M)`
- **Sesión** tiene **Asiento** `(0,N)`
- **Sesión** tiene **Descuento** `(0,N)`

---

## Atributos

### Ticket
- **estado**: {reservado, pagado, cancelado, usado}  
- **precio**  
- **tipo de ticket**: {General, VIP, Early-bird}  
- **cantidad**  
- **reembolso**: boolean  
- **reglas** (para devoluciones)

### Asiento
- **tipo**: {numerado, general}  

### Sesión
- **fecha**  
- **hora**

### Evento
- **descripción**  
- **nombre**  
- **fecha**  
- **lugar**

---

## Identificadores
- **Evento**: `evento_id`  
- **Sesión**: `sesion_id`  
- **Ticket**: `ticket_id`  
- **Cliente**: `cliente_id`  
- **Check-in**: `checkin_id`  
- **Descuento**: `descuento_id`  
- **Asiento**: `asiento_id`  

## Enlace al Diagrama ER (Chen)
[Diagram Chen](https://viewer.diagrams.net/?tags=%7B%7D&lightbox=1&highlight=0000ff&edit=_blank&layers=1&nav=1&title=Bases%20de%20datos%3AEjercicios_1_clase%203.drawio&dark=auto#R%3Cmxfile%3E%3Cdiagram%20id%3D%224seIna0w2M7AC2M7Yw48%22%20name%3D%22Page-2%22%3E7Vzdc6M2EP9rPHN58I34hsfEyV07k2tvLnfT9ulGAcWmwcgVcr7%2B%2BgqQDEjYJnFA2O2TYVlk%2BO1qd7W7YmLNlk%2BfCVwtvuAIJRMTRE8T63JimobtmuwnpzyXFNcAJWFO4ogzVYSb%2BAVxomBbxxHKGowU44TGqyYxxGmKQtqgQULwY5PtDifNf13BOVIINyFMVOofcUQXJdV3QEX%2FBcXzhfhnA%2FArSyiYOSFbwAg%2F1kjW1cSaEYxpebR8mqEkB0%2FgUt73acvVzYMRlNIuN7zQ33%2Fc%2F0o%2F2xQ8Be6X6%2BWL%2B23q8mejz%2BKFUcTen59iQhd4jlOYXFXUC4LXaYTyUQE7q3iuMV4xosGIfyNKn7kw4ZpiRlrQZcKvsgcmz3%2Fm9390xOlf9WuXT3zw8uyZn5XPmj%2FgVgg4KcNrEqId7y1UCZI5ojv4nI2gmIYjvETsedh9BCWQxg%2FN54Bc1eYbvkoa7IAL5BXCMYwxSQeMTzoGOFA8xa3nhMDnGsMKxynNaiN%2FzQmMQRg1wylH5CbNcKSJt4%2Ff2M0%2F3c3PDsonrhRr8%2BoH6JqlV9camlYp3oh0zdRqCgC31A8wWfP%2F%2BsD%2BbPblrFVu1%2FCWOeIG1jCJ5yk7DhlEiDDCAyI0Zp7unF9YxlFUihVl8Qu8LcbL0eYTgg3uXEycyw3%2B%2BQDoqfHi3A3zmyvnV5fMDv1T4RVzgumEbXiNecEji9dN9mq2CRZ8d5cxycsSeo85pYjs6oGhgBWJNefR4yKm6GYFC7V9ZGFVU45bsVe0fyuapghShIURYnqsQpwNbVELb1zQk37bWszPO5oRs6MZsfWaEUPVyZMyI%2FZeM2K4oOlexTQdrx0xFZnNkjiHX78h8a0Gli7QbUiEjzhaQ7JFgd%2BqnVxQrtO0%2BJ6Ef2m3%2BE09eEL%2FFKTSJUp0dZr3Tarh5GEOtHpR4J%2B2FzW3rKsrL2q6ptv0oqOPxi1FZjcMWpxqd6JOMLpoXIEqxctbosYbbKx4laFBYJJQagEpGBIjR8HoEmUhiVdhm04NCZRpSfqkGSktEVk9i%2BltCEWW%2BSOwvD35peLsKyIxQyA3z7qSTrZON6c6uev1HBKtui2FsYavWbcDzbptBd6kkTkFwD0S3fZ16rawiTXl%2FoTCBcy0avfU3R8JDKrehq1Xv%2FVVBbrm8w5drh%2BoxZ6ixsVCxDiRhYixxQFWCxHLC3gkNt6Vh1CmmpS%2BxyhtSd8tWJi9zgaxNbZcA2gJE%2F0WW%2BP3ZmvUiPpOv0l2TQkmpxNKTm8oqXXABSZQK0aetOBwumlSbxiZmmvZ%2Bvomgo5eyzS1ui1DzcV8ACfktsz9VagAHFkx2z32Cm3nyWEd2vRV3PrarqLAk%2FJb3u4uoT38PXUJBSOMZDYtpQIJS3MkYzpHPlWENdrvR7QmqEzNmUVtq9Pu8jm0HPkmU%2BZKpsneY8o84zB%2Bh3d09Gr6RLT6v7JtY7S1KJu8%2BLDlNvg9%2FJYzhPJo7rMfv%2FKYh1b036Y8sqXa08qt8HsDKI%2FAsBF0hfc8zB9T5doK1Mhr2Mq1qZauvxIUxmrP7aAJElfGSc0iteX1%2B8uQqFmkGUxpHMFIL1CyMe9Y3%2BsPKHXBMzHdhP3tRRQ%2FNIBy%2F1nnW7ku2NvTKc9PnDOOBN3RAh3BwI7m%2FLcYKFvBtHWkWxjez4s5PQ1xgkk5HiUwzQSkF0WaYnMtySGZRpDcfyDz2yKnMimavYufs%2FI3v2LmXi8%2FqR%2BcnbU%2B5%2Fd4hX9G6CflRqd8agZn%2BeDNl2HkAhhB1ahMvqxMjjrrNtv16tpk99ZXc%2FT9eU5Hd25pre7amjfOaQu3ustHawOlpZZ6zrN4FFtjDCD56rZs0rAxjaU24qTrJSIw0hvVVHudd5QQW6HqLfNmqe56jlIGVaIXKbklr617cVikbHVRMcPLVUslcdCitO03cHJaFhSDpnJtNVBGGdU98zy%2FuYXJarFRg4bJjrqtLO%2BGXY%2FCpAe2tPpqWVQMa9HFRzH0tQ1azRL1R%2BD6e6KU3tsGu5bnnC3SHqp2rcYuxTrrtxOpXZe6uat27QZO0PT75dl4a9eBasW%2FIbS8xUmm2ZDLlQxXsyEPRlVSszXbJNPsaJOCUdTZHH%2BIFgCg%2BnodOvOOYg78jmLmCx5dvidQF4Lf0DzOqOaofRNQic3FLaubQaP2QPe2DGD4TUvmeIFuW9bVlB2auXuTKbNs6UMCwe5CnCXF9K%2Fl91x3AFNpqNWok%2BpzDLZkEWt9jiawG8CPPlY0wH92z4tI53Xwg5q3vai7t2YLFN5PY3Xn7QBVcGmLgKc9Y2wA3QkG4Ft1Pd73Zce%2BnZ%2FIdo69MR4ce%2BcotwxDIP22hh9pwe1au%2BMG%2Bbs5En9fSyx1f8QPGifMvyvqMWijtTdYnM9Oqy%2FjlrhW3xe2rv4F%3C%2Fdiagram%3E%3C%2Fmxfile%3E)

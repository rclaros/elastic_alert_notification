# Notificaciones de alertas en Elastic Stack
Script para envío de notificaciones a correos y/o mensaje de texto, cuando se producen alertas en monitoreo (Uptime) de Elastic Stack

## Problema
Para el envio notificaciones de las alertas, Elastic Stack requiere Licencia Gold, para poder conectarse y enviar a multiples componentes, la versión community solo soporta la creación de indice y registro en log.

## Solucion
Para enviar a correos y otros servicios de notificación se realizarán mediante script bash en linux, el cual utilizaremos swatch para escuchar los eventos de las alertas y tomar esa linea, parsear y enviar por correo y numero de teléfono, ademas que podemos enviar a otros servicios segun nuestra imaginación.

## Requisitos
- apt-get install swatch
- apt-get install jq
- apt-get install mailutils

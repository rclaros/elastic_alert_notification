#!/bin/bash
for fn in `cat /opt/elastic/notificacion/lista_telefonos_alertas.txt`; do    
wget --no-check-certificate --quiet --method POST --timeout=0 --header 'Content-Type: application/json' --header 'Authorization: Basic U1VTQUxVRF9USTpTVVNBTFVEMjAyMA==' \
  --body-data '{
    "to": '"$fn"',
    "text": "Alerta - Monitoreo '"$1"' -'"$2"' "
}' \
   'https://apisendmessage:8090/sendsms'
   echo "SMS enviado a $fn"
done
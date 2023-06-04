#!/bin/bash
for fn in `cat /opt/elastic/notificacion/list_phones_alert.txt`; do    
wget --no-check-certificate --quiet --method POST --timeout=0 --header 'Content-Type: application/json' --header 'Authorization: Basic XXX' \
  --body-data '{
    "to": '"$fn"',
    "text": "Alerta - Monitoreo '"$1"' -'"$2"' "
}' \
   'https://apisendmessage/sendsms'
   echo "SMS enviado a $fn"
done
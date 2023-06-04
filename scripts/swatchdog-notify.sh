#!/bin/bash
echo $1 > message.txt
mensaje=$(jq ".message" message.txt)
if [[ $(echo "$mensaje" | grep -i "Monitor") ]]; then
    if [[ $(echo "$mensaje" | grep -i "Up") ]]; then
       monitor=$(echo "$mensaje" | grep -oP '\((.*?)\)' | head -1 | tr -d '()')
       CONTENT=$(sed -e 's/{{monitor}}/'"$monitor"'/g' -e 's|{{status}}|'"$mensaje"'|g' -e 's/{{mensaje}}/DISPONIBLE/g'  -e 's/{{color}}/green/g' -e 's/{{color2}}/green/g' /opt/elastic_alertas/plantilla_alerta_elastic.html)
       mail -a "Content-Type: text/html"  -s "Alerta - Monitoreo $monitor" -a "From: alertas_elastic@susalud.gob.pe" $(cat /opt/elastic/notificacion/lista_correos_alertas.txt) <<< $CONTENT
       /opt/elastic/scripts/script_enviar_sms.sh "$monitor" "DISPONIBLE"
       echo "Correo enviado correctamente STATUS ..."
    else
       monitor=$(echo "$mensaje" | grep -oP '\((.*?)\)' | head -1 | tr -d '()')
       CONTENT=$(sed -e 's/{{monitor}}/'"$monitor"'/g' -e 's|{{status}}|'"$mensaje"'|g' -e 's/{{mensaje}}/NO DISPONIBLE/g'  -e 's/{{color}}/red/g' -e 's/{{color2}}/red/g'  /opt/elastic_alertas/plantilla_alerta_elastic.html)
       mail -a "Content-Type: text/html"  -s "Alerta - Monitoreo $monitor" -a "From: alertas_elastic@susalud.gob.pe"  $(cat /opt/elastic/notificacion/lista_correos_alertas.txt) <<< $CONTENT
       /opt/elastic/scripts/script_enviar_sms.sh "$monitor" "NO DISPONIBLE"
       echo "Correo enviado correctamente ERROR ..."
    fi
else
     echo "No tiene formato de monitoreao elastic"
fi
#!/bin/bash
echo $1 > message.txt
mensaje=$(jq ".message" message.txt)
if [[ $(echo "$mensaje" | grep -i "Monitor") ]]; then
    if [[ $(echo "$mensaje" | grep -i "Up") ]]; then
       monitor=$(echo "$mensaje" | grep -oP '\((.*?)\)' | head -1 | tr -d '()')
       CONTENT=$(sed -e 's/{{monitor}}/'"$monitor"'/g' -e 's|{{status}}|'"$mensaje"'|g' -e 's/{{mensaje}}/DISPONIBLE/g'  -e 's/{{color}}/green/g' -e 's/{{color2}}/green/g' /opt/elastic/template/template_email_alert.html)
       mail -a "Content-Type: text/html"  -s "Alerta - Monitoreo $monitor" -a "From: alerts_elastic@midomain.com" $(cat /opt/elastic/notificacion/list_emails_alerts.txt) <<< $CONTENT
       /opt/elastic/scripts/script_enviar_sms.sh "$monitor" "DISPONIBLE"
       echo "Correo enviado correctamente STATUS ..."
    else
       monitor=$(echo "$mensaje" | grep -oP '\((.*?)\)' | head -1 | tr -d '()')
       CONTENT=$(sed -e 's/{{monitor}}/'"$monitor"'/g' -e 's|{{status}}|'"$mensaje"'|g' -e 's/{{mensaje}}/NO DISPONIBLE/g'  -e 's/{{color}}/red/g' -e 's/{{color2}}/red/g'  /opt/elastic/template/template_email_alert.html)
       mail -a "Content-Type: text/html"  -s "Alerta - Monitoreo $monitor" -a "From: alerts_elastic@midomain.com"  $(cat /opt/elastic/notificacion/list_emails_alerts.txt) <<< $CONTENT
       /opt/elastic/scripts/script_enviar_sms.sh "$monitor" "NO DISPONIBLE"
       echo "Correo enviado correctamente ERROR ..."
    fi
else
     echo "No tiene formato de monitoreao elastic"
fi
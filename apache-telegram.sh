#!/bin/bash

read -p 'CODIGO DA FARMACIA: ' COD_FCIA
echo ANALISE DE SISTEMA
echo BY: LUCAS FERNANDES
echo
echo EXECUTANDO...

echo "PRESSIONE [CTRL+C] PARA SAIR"

TOKEN="1927799827:AAFxJx6fy9cussu3klZyfKTLPYAxWhfXYcc";
CHAT_ID="1655701962";
#COD_FCIA="7220";
MESSAGE="TOMCAT STATUS: PARADO";
NL="
"

function envia_mensagem(){

curl --silent -X POST --data-urlencode "chat_id=${CHAT_ID}" --data-urlencode "text=FARMACIA: ${COD_FCIA}${NL}${NL}${MESSAGE}" "https://api.telegram.org/bot${TOKEN}/sendMessage?disable_web_page_preview=true&parse_mode=html" | grep -q '"ok":true'

}

STATUS_SCRIPT="0";

while [ "$STATUS_SCRIPT" = "0" ]; 
do

VERIFICA_APACHE=$(sudo systemctl status tomcat | grep 'Active: active');

if [ "$VERIFICA_APACHE" = "" ];
then
envia_mensagem
STATUS_SCRIPT="1";
echo 
echo TOMCAT PARADO!
echo MENSAGEM ENVIADA
fi
sleep 60
done

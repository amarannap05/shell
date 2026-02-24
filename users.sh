#!/bin/bash
# Aitor Maraña Pérez
# Fecha 21/02/2026
if [ $USER != "root" ]; then
    echo "Usted no es usuario root"
    exit 1
else
    UID_REF=1000
    if [ $# -eq 1 ]; then
        UID_REF=$1
    fi
    FECHA=$(date +%d-%m-%Y)
    HORA=$(date +%H:%M)
    USUARIO=$(whoami)
    CONTADOR=0
    echo "Informe de usuarios el día $FECHA a las $HORA"
    while IFS=: read -r nom usu uid gid desc home shell; do
        if [ $uid -gt $UID_REF ]; then
            echo "$nom - $uid"
            CONTADOR=$((CONTADOR + 1))
        fi
    done < /etc/passwd
    echo "Total: $CONTADOR usuarios"
    echo "$FECHA - $HORA - El usuario $USUARIO ha solicitado un informe de usuarios" >> /tmp/logeventos
fi

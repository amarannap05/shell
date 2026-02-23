#!/bin/bash
# Aitor Maraña Pérez
# Fecha 20/02/2026

if [ $# -ne 2 ]; then
    echo "ERROR: Número de parámetros incorrecto"
    echo "Uso: $0 <fichero_salida> <directorio>"
    exit 1
fi
FI="$1"
DI="$2"
if [ -e "$FI" ]; then
    echo "ERROR: El fichero '$FI' ya existe"
    exit 1
fi
if [ ! -d "$DI" ]; then
    echo "ERROR: El directorio '$DI' no existe"
    exit 1
fi
if [ -z "$(ls -A "$DI")" ]; then
    echo "ERROR: El directorio '$DI' está vacío"
    exit 1
fi
echo "fiveOrMore.sh - Autor: [Tu nombre y apellidos aquí]"
echo "Buscando ficheros .txt con 5 o más líneas en: $DI"
CN=0
for fi in "$DI"/*.txt; do
    if [ ! -f "$fi" ]; then
        continue
    fi
    no=$(basename "$fi")
    nl=$(wc -l < "$fi" 2>/dev/null)
    if [ "$nl" -ge 5 ]; then
        echo "$no - $nl líneas"
        echo "$no" >> "$FI"
        CN=$((CN + 1))
        fq="${fi}.q"
        np=$(wc -w < "$fi" 2>/dev/null)
        echo "El fichero original tiene $np palabras" > "$fq"
        cat "$fi" >> "$fq"
        echo "Creado: $(basename "$fq")"
    fi
done
if [ $CN -eq 0 ]; then
    echo "No se encontraron ficheros .txt con 5 o más líneas."
else
    echo "Total: $CN" >> "$FI"
    echo "Ficheros identificados: $CN"
    echo "Fichero de salida: $(realpath "$FI")"
    echo "Contenido del fichero de salida:"
    cat "$FI"
fi

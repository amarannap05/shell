#!/bin/bash
# Aitor Maraña Pérez
# Fecha 17/02t/2026

if [ $# -ne 2 ]; then
    echo "ERROR: Número de parámetros incorrecto"
    echo "Uso: $0 <fichero_salida> <max_operaciones>"
    exit 1
fi

if [ -e "$1" ]; then
    echo "ERROR: El fichero '$1' ya existe"
    exit 1
fi

FICHERO_SALIDA="$1"
MAX_OPERACIONES="$2"
CONTADOR=0

while [ $CONTADOR -lt $MAX_OPERACIONES ]; do
    echo "----------------------------------------"
    echo "Operación Op1 Op2:"
    read OPERACION OP1 OP2

    if [ "$OPERACION" = "X" ] || [ "$OPERACION" = "x" ]; then
        echo "Saliendo por solicitud del usuario (X)..."
        break
    fi
    
    case $OPERACION in
        S|s|R|r|M|m|D|d)
            ;;
        *)
            echo "ERROR: Operación no válida. Use S, R, M, D o X para salir"
            continue
            ;;
    esac

    if [ -z "$OP1" ] || [ -z "$OP2" ]; then
        echo "ERROR: Debe ingresar dos operandos"
        continue
    fi
    
    OPERACION_MAYUS=$(echo "$OPERACION" | tr '[:lower:]' '[:upper:]')
    
    case $OPERACION_MAYUS in
        S)
            RESULTADO=$((OP1 + OP2))
            echo "Resultado: $OP1 + $OP2 = $RESULTADO"
            ;;
        R)
            RESULTADO=$((OP1 - OP2))
            echo "Resultado: $OP1 - $OP2 = $RESULTADO"
            ;;
        M)
            RESULTADO=$((OP1 * OP2))
            echo "Resultado: $OP1 * $OP2 = $RESULTADO"
            ;;
        D)

            if [ $OP2 -eq 0 ]; then
                echo "ERROR: No se puede dividir entre cero"
                continue
            fi
            RESULTADO=$(echo "scale=2; $OP1 / $OP2" | bc)
            echo "Resultado: $OP1 / $OP2 = $RESULTADO"
            ;;
    esac
    
    echo "$OPERACION_MAYUS $OP1 $OP2" >> "$FICHERO_SALIDA"
    
    CONTADOR=$((CONTADOR + 1))
    
    RESTANTES=$((MAX_OPERACIONES - CONTADOR))
    echo "Operaciones restantes: $RESTANTES"
done

if [ -f "$FICHERO_SALIDA" ]; then
    # Obtener ruta completa
    RUTA_COMPLETA=$(realpath "$FICHERO_SALIDA")
    echo "Ruta completa del fichero de salida:"
    echo "$RUTA_COMPLETA"
    echo ""
    echo "Contenido del fichero:"
    echo "----------------------------------------"
    cat "$FICHERO_SALIDA"
else
    echo "No se realizó ninguna operación, no se creó el fichero."
fi

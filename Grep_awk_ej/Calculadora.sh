#!/bin/bash
# Ejercicio 1: Calculadora con opciones
# Crea un script que acepte opciones para realizar operaciones matemáticas simples (suma, resta, multiplicación, división) entre dos números.

# Opciones requeridas:
# -a <número>: Primer número.
# -b <número>: Segundo número.
# -o <operación>: Operación a realizar (suma, resta, multiplica, divide).
# Pista:
# Usa case para determinar la operación según el valor de OPTARG en la opción -o.

#Mostrar ayuda 
function mostrar_ayuda {
    echo "Uso: $0 -a <número> -b <número> -o <operación>"
    echo "  -a <número>       Primer número."
    echo "  -b <número>       Segundo número."
    echo "  -o <operación>    Operación a realizar (suma, resta, multiplica, divide)."
    echo "  -h                Muestra esta ayuda."
}

# Procesar opciones
while getopts "a:b:o:h" opcion; do
    case $opcion in
        a)
            numero1="$OPTARG"
            ;;
        b)
            numero2="$OPTARG"
            ;;
        o)
            operacion="$OPTARG"
            ;;
        h)
            mostrar_ayuda
            exit 0
            ;;
        *)
            mostrar_ayuda
            exit 1
            ;;
    esac
done

# Validar que los números y la operación estén definidos
if [[ -z "$numero1" || -z "$numero2" || -z "$operacion" ]]; then
    echo -e "\nError: Debes especificar los números (-a y -b) y la operación (-o).\n"
    mostrar_ayuda
    exit 1
fi

#Parte de la logica
# Realizar la operación
case $operacion in
    suma)
        resultado=$((numero1 + numero2))
        echo "$numero1+$numero2= $resultado"
        ;;
    resta)
        resultado=$((numero1 - numero2))
        echo "$numero1-$numero2= $resultado"
        ;;
    multiplica)
        resultado=$((numero1 * numero2))
        echo "$numero1 * $numero2= $resultado"
        ;;
    divide)
        if [[ "$numero2" -eq 0 ]]; then
            echo "Error: No se puede dividir por cero."
            exit 1
        fi
        resultado=$((numero1 / numero2))
        echo "$numero1 / $numero2= $resultado"
        ;;
    *)
        echo "Error: Operación no válida. Usa suma, resta, multiplica o divide."
        exit 1
        ;;
esac


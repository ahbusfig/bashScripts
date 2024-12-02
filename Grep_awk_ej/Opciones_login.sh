#!/bin/bash

# Mostrar ayuda
function mostrar_ayuda {
    echo "Uso: $0 [-u usuario] [-p password] [-h]"
    echo "  -u usuario  Especifica el nombre de usuario."
    echo "  -p password Especifica la contraseña."
    echo "  -h          Muestra esta ayuda."
}

# Procesar opciones
while getopts "u:p:h" opcion; do
    case $opcion in
        u) 
            usuario="$OPTARG"
            ;;
        p) 
            password="$OPTARG"
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

# Verificar si se proporcionaron las opciones obligatorias
if [[ -z "$usuario" || -z "$password" ]]; then
    echo "Error: Se requieren las opciones -u y -p."
    mostrar_ayuda
    exit 1
fi

# Imprimir los valores proporcionados
echo "Usuario: $usuario"
echo "Contraseña: $password"

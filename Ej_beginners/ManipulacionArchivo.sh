#!/bin/bash
: ' 
                            Manipulación de Archivos:

    Escribe un script que lea un archivo línea por línea y cuente el número de líneas 
    y el número de veces que una palabra específica aparece en el archivo.

'
# Asignación correcta de la variable archivo
ubicacion=$(pwd)
archivo="$ubicacion/hola.txt"
contador=0
read -p "Dime la palabra que buscas --> " palabra
contador_palabra=0

# Leemos el archivo línea por línea
while IFS= read -r linea; do 
    # Incrementamos el contador por cada línea leída
        contador=$((contador + 1))
    # Verificamos si la palabra aparece en la línea
    if [[ "$linea" == *"$palabra"* ]]; then  # * * --> permite que la palavra aparezca en cualquier sitio de la linea
        # Contamos las ocurrencias de la palabra en la línea
        ocurrencias=$(grep -o "$palabra" <<< "$linea" | wc -l)
        contador_palabra=$((contador_palabra + ocurrencias))
    fi
    
done < "$archivo"

# Imprimimos el número total de líneas y el número de veces que la palabra aparece
echo -e "\nEl archivo tiene $contador líneas"
echo -e "La palabra '$palabra' aparece $contador_palabra veces\n"
echo -e "La ubicacion del archivo es --> $archivo"
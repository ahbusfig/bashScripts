#!/bin/bash
# Crea un script que lea un archivo línea por línea e imprima cada línea en la terminal.
# Argumentos de Línea de Comandos:

# Creamos la función leerArchivo
function leerArchivo(){
    # Guardamos el primer argumento (nombre del archivo) en una variable local
    local filename="$1"
    
    # Leemos el archivo línea por línea
    while IFS= read -r line; do
        # Imprimimos cada línea en la terminal
        echo "$line"
    # Redirigimos el contenido del archivo al bucle while
    done < "$filename"
}

# Verificamos si se proporciona un nombre de archivo como argumento
if [ -z "$1" ]; then #-z --> para verif. si una cadena está vacia!
  # Si no se proporciona, mostramos un mensaje de uso y salimos con un código de estado 1
  echo "Uso: $0  --> Tienes que proporcionar el nombre del archivo que quiere leer!"
  exit 1
fi

# Llamamos a la función con el nombre de archivo proporcionado
leerArchivo "$1"
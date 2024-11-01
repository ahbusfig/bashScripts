#!/bin/bash
# Crea un script que escriba líneas en un archivo.
# Argumentos de Línea de Comandos: nombre_del_archivo linea1 linea2 ...

# Función para escribir en el archivo
function escribirArchivo(){
    # Guardamos el primer argumento (nombre del archivo) en una variable local
    local filename="$1"
    # Shift para eliminar el primer argumento y dejar solo las líneas
    shift
    # Guardamos las líneas restantes en un array
    local lines=("$@")
    # Abrimos el archivo en modo de adición y escribimos cada línea
    for line in "${lines[@]}"; do
        echo "$line" >> "$filename"
    done
}

# Verificamos si se proporciona un nombre de archivo como argumento
if [ -z "$1" ]; then
  # Si no se proporciona, mostramos un mensaje de uso y salimos con un código de estado 1
  echo "Uso: $0 nombre_del_archivo linea1 linea2 ..."
  exit 1
fi

# Llamamos a la función con el nombre de archivo y las líneas proporcionadas
escribirArchivo "$@"
#!/bin/bash
: '-----------------Buscar Texto en Archivos-------------------

    Escribe un script que busque una palabra específica en todos 
    los archivos de un directorio.

    Usa el comando grep.
'
function buscar_palabra_directorio(){
    read -p "Que archivo buscas ? --> " palabra
    busqueda=$(ls -l | grep "$palabra")
    if [ -n "$busqueda" ]; then #-n --> comprueba si no está vacio
        echo -e "\n[+] Se ha encontrado almenos 1 coincidencia"
        echo -e "\t[+] $busqueda"
    else
        echo -e "\nNo se ha encontrado ninguna coincidencia"
    fi
}


: '
3. ----------------------Contar Líneas en un Archivo--------------------
   - Escribe un script que cuente el número de líneas en un archivo dado.
   - Usa el comando `wc -l`.
'
function contar_lineas_archivo(){
    read -p "Que archivo buscas ? --> " palabra
    ubicacion=$(pwd)
    archivo="$ubicacion/$palabra"
     
    if [ -n "$archivo" ]; then #-n --> comprueba si no está vacio
        contador_lineas=$(cat $archivo | wc -l)
        echo -e "\n[+] El archivo tiene $contador_lineas lineas"
    else
        echo -e "\n[+] El archivo está vacio"
    fi
}

: '---------------------Mostrar el Contenido de un Archivo-----------------
    -Escribe un script que muestre el contenido de un archivo.
    -Usa el comando cat.
'
function Mostrar_archivo(){
    read -p "Dime el nombre del archivo completo --> " nombre
    ubicacion=$(pwd)
    archivo="$ubicacion/$nombre"
    echo -e "\nEl archivo en la ubicacion --> $archivo"
    echo -e "\n$(cat "$archivo" | sed 's/^/\t/')"
}

: '-----------Script que copie un archivo de un directorio a otro.----------
    -Usa el comando cp.
'
function copy_to_other_directory(){
    while True;do
        read -p "Dime el nombre del archivo completo --> " nombre
        ubicacion=$(pwd)
        archivo="$ubicacion/$nombre"
        if [ -e $archivo ]; then
            break
        else
            echo -e "\n El archivo no existe!\n"
        fi
    done 

    read -p "Dime el nombre del nuevo directorio --> " directorio
    directorio_comp="$pwd/$directorio"

    if [ -n "$directorio" ]; then
        # Verificar si el directorio existe, si no, crearlo
        if [ ! -d "$directorio_comp" ]; then
            echo -e "\nEl directorio aun no existe --> Por tanto se acaba de crear!"
            mkdir -p "$directorio"
        fi
        # Copiar el archivo al nuevo directorio
        cp "$archivo" "$directorio"
        echo "Archivo copiado a $directorio"
    else
        echo "No se proporcionó un directorio válido."
    fi
}
#Ejecutar script
#buscar_palabra_directorio 
#contar_lineas_archivo
#Mostrar_archivo
#copy_to_other_directory
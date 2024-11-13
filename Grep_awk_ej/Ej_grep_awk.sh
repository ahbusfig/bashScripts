#!/bin/bash
: '----------------------------------Buscar palabras en un archivo de texto----------------------------------
    Usa grep para encontrar todas las líneas que contengan la palabra "error" en un archivo llamado logfile.txt.
    grep -i --> para hacerlo no sensible mayusc y minusc
' 
# Variable global para almacenar el nombre del archivo
nombre_arch=""

function buscar_1archivo(){
    # Preguntar por el archivo y verificar que exista
    while true; do
        read -p "¿Qué archivo estás buscando (p.e data.txt)? --> " nombre_arch
        if [ -e "$nombre_arch" ]; then
            ubi=$(pwd)/$nombre_arch
            echo -e "\nLa ubicación del archivo es --> $ubi\n"
            break
        else
            echo -e "\nEl archivo no existe, inténtelo de nuevo\n"
        fi
    done
}

function buscar_palabra_1archivo() {
    #Funcion para buscar un archivo
    buscar_1archivo
    # Pedir la palabra a buscar
    read -p "¿Qué palabra buscas? --> " palabra_buscada
    # Usar grep para buscar la palabra en el archivo y almacenar el resultado --> Poner comillas para evitar problemas al comprobar que da res vacio
    busqueda=$(grep -i "$palabra_buscada" "$nombre_arch")  #El parametro -i para q no sea case sensitive
    
    # Comprobar si hubo coincidencias
    if [ -z "$busqueda" ]; then
        echo -e "\nNo ha habido coincidencias\n"
    else
        echo -e "\nCoincidencias encontradas:\n$busqueda"
    fi
}

: '-----------------------------------Buscar palabras con un patrón específico----------------------------------
    Busca todas las líneas que contengan un número de teléfono en formato XXX-XXX-XXXX en el archivo contacts.txt.
    usar grep -E --> parametro para no escapara los simbolos especiales!
'
function buscar_fechas_1archivo(){
    # Llamar a la función para buscar el archivo
    buscar_1archivo
    # Buscar fechas en el archivo con el patrón especificado
    busqueda=$(grep -E '\b[0-9]{4}[-/][0-9]{2}[-/][0-9]{2}\b' "$nombre_arch")

    # Comprobar si hubo coincidencias
    if [ -z "$busqueda" ]; then
        echo -e "\nNo se encontraron fechas en el formato YYYY/MM/DD o MM-DD-YYYY\n"
    else
        echo -e "\nFechas encontradas:\n"
        echo -e "$busqueda"
    fi
}

: '----------------------------------Buscar palabras en varios archivos--------------------------------------------
    Busca la palabra "fatal" en todos los archivos .log dentro de un directorio.
'
function buscar_palabra_en_varios_archivos(){
    # Pedir la palabra a buscar
    read -p "¿Qué palabra buscas? --> " palabra_buscada

    # Comprobar si existen archivos .txt en el directorio
    if ls *.txt 1> /dev/null 2>&1; then
        # Usar grep para buscar la palabra en todos los archivos .txt
        busqueda=$(grep -i -H -n "$palabra_buscada" *.txt)

        # Comprobar si hubo coincidencias
        if [ -z "$busqueda" ]; then
            echo -e "\nNo ha habido coincidencias\n"
        else
            echo -e "\nCoincidencias encontradas:\n$busqueda"
        fi
    else
        echo -e "\nNo se encontraron archivos .txt en el directorio actual.\n"
    fi
}

: '-----------------------------------Buscar y contar ocurrencias de una palabra------------------------------------
    Cuenta cuántas veces aparece la palabra "failed" en el archivo data.txt
        grep -c "failed" server.log
        Mostrar líneas sin coincidencias
'
function contar_ocurrencias_1archivo() {
    # Llamar a la función para buscar el archivo
    buscar_1archivo
    # Contar las ocurrencias de la palabra 'failed' en el archivo
    cuenta=$(grep -o -i "failed" "$nombre_arch" | wc -l)

    # Mostrar el número de ocurrencias
    echo -e "\nLa palabra 'failed' aparece $cuenta veces en el archivo $nombre_arch."
}

: '---------------------------------Muestra todas las líneas del archivo data.txt que no contengan la palabra "success"----
    grep -v "success" data.txt
'
: '---------------------------------Muestra todas las líneas del archivo que no contengan la palabra "success"----'
function mostrar_lineas_sin_palabra() {
    # Llamar a la función para buscar el archivo
    buscar_1archivo
    # Mostrar todas las líneas que no contengan la palabra 'success'
    busqueda=$(grep -v -i "success" "$nombre_arch")

    # Comprobar si hubo coincidencias
    if [ -z "$busqueda" ]; then
        echo -e "\nNo se encontraron líneas sin la palabra 'success'.\n"
    else
        echo -e "\nLíneas sin la palabra 'success':\n$busqueda"
    fi
}

#------------------Para ejecutar la funcion
#buscar_palabra_1archivo
#buscar_fechas_1archivo
#buscar_palabra_en_varios_archivos
mostrar_lineas_sin_palabra
#contar_ocurrencias_1archivo
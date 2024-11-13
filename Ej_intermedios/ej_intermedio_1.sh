#!/bin/bash

# ------------------------------- Buscar y reemplazar texto en múltiples archivos: ---------------------------------------------
# Encuentra todos los archivos .txt en un directorio y reemplaza
# todas las ocurrencias de una palabra específica con otra palabra.
function reemplazar_palabra_en_multiples_archivos_txt() {
    ubicacion=$(pwd)
    echo -e "En este directorio --> $ubicacion"
    echo -e "Cambiaremos una palabra en todos los archivos .txt"

    # Bucle para preguntar la palabra buscada
    while true; do
        read -p "Dime la palabra que quieres cambiar --> " palabra_buscada

        # Comprobar si la palabra existe en algún archivo
        archivos_con_palabra=$(grep -rl "$palabra_buscada" . --include="*.txt") 
        # rl -> de forma recursiva devuelve nombre archivos con la palabra buscada
        # . -> desde el directorio actual, --include -> solo busca en los archivos .txt
        if [ -z "$archivos_con_palabra" ]; then  # z -> verifica si long. cadena es 0
            echo -e "\tLa palabra '$palabra_buscada' no se encontró en ningún archivo .txt. Inténtalo de nuevo.\n"
        else
            break
        fi
    done

    read -p "Dime la nueva palabra --> " nueva_palabra

    # Reemplazar la palabra dentro de los archivos
    echo "$archivos_con_palabra" | xargs -d '\n' sed -i "s/$palabra_buscada/$nueva_palabra/g"

    echo "Reemplazo completado."
}

# ------------------------------------------ Crear un script de respaldo: ---------------------------------------------------
# Escribe un script que copie todos los archivos de un directorio a otro directorio de respaldo,
# preservando la estructura de directorios.
function crear_backup_documento(){
    origen=$(pwd)      # Nos da la ubicación donde estamos
    destino="/ruta/absoluta/GuardarCopiaSeguridad" # Cambia esto a la ruta absoluta deseada

    # Crear el directorio de destino si no existe
    mkdir -p "$destino"

    # Buscar y comprobar que exista el archivo
    while true; do
        read -p "Dime el nombre del archivo que quieres hacer backup --> " nombre_archivo
        if [ -e "$nombre_archivo" ]; then
            echo -e "\nEl archivo existe!\n"
            break
        else
            echo -e "\nEl archivo no existe --> inténtelo otra vez\n"
        fi
    done

    # Copiar archivo al destino
    cp "$origen/$nombre_archivo" "$destino"
    echo -e "Se ha hecho la copia de seguridad correctamente en $destino"
}

# ------------------------------------------ Monitorear el uso de disco: ---------------------------------------------------
# Crea un script que monitoree el uso del disco y envíe una alerta por correo electrónico si el uso del disco supera un cierto umbral.

function monitorear_uso_disco() {
    # Umbral de uso de disco en porcentaje
    umbral=80
    # Dirección de correo electrónico para enviar la alerta
    correo="alaingh37@gmail.com"

    # Obtener el uso del disco en porcentaje (para la partición principal "/")
    uso_disco=$(df / | awk 'NR==2 {print $5}' | sed 's/%//')

    # Comprobar si el uso del disco supera el umbral
    if [ "$uso_disco" -gt "$umbral" ]; then
        # Mensaje de alerta
        mensaje="El uso del disco ha superado el umbral del $umbral%. Uso actual: $uso_disco%."
        echo "$mensaje"
    fi
}

# ------------------------------------------ Procesar archivos de registro: ------------------------------------------------
# Escribe un script que lea un archivo de registro, filtre las líneas que contienen errores y guarde esas líneas en un nuevo archivo.
function procesar_archivos_de_registro() {
    # Preguntar por el nombre del archivo de registro
    while true; do
        read -p "Dime el nombre del archivo de registro que quieres procesar --> " archivo_registro
        if [ -e "$archivo_registro" ]; then
            echo -e "\nEl archivo de registro existe!\n"
            break
        else
            echo -e "\nEl archivo de registro no existe --> inténtelo otra vez\n"
        fi
    done

    # Preguntar por el nombre del archivo de salida
    read -p "Dime el nombre del archivo donde guardar los errores --> " archivo_errores

    # Filtrar las líneas que contienen errores y guardarlas en el nuevo archivo
    grep -i "error" "$archivo_registro" > "$archivo_errores"

    echo -e "Las líneas con errores se han guardado en $archivo_errores"
}

# ------------------------------------------ Automatizar la descarga de archivos: -------------------------------------------
# Crea un script que descargue archivos de una lista de URLs y los guarde en un directorio específico.
function automatizar_descarga_archivos() {
    # Preguntar por el nombre del archivo que contiene las URLs
    while true; do
        read -p "Dime el nombre del archivo que contiene las URLs --> " archivo_urls
        if [ -e "$archivo_urls" ]; then
            echo -e "\nEl archivo de URLs existe!\n"
            break
        else
            echo -e "\nEl archivo de URLs no existe --> inténtelo otra vez\n"
        fi
    done

    # Preguntar por el directorio de destino
    read -p "Dime el nombre del directorio donde guardar los archivos descargados --> " directorio_destino

    # Crear el directorio de destino si no existe
    mkdir -p "$<directorio_destino"

    # Leer el archivo de URLs y descargar cada archivo
    while IFS= read -r url; do
        echo "Descargando $url..."
        wget -P "$directorio_destino" "$url"
    done < "$archivo_urls"

    echo -e "Descargas completadas. Los archivos se han guardado en $directorio_destino"
}
# ------------------------------------------ Ejecutar las funciones ----------------------------------------------------------
# reemplazar_palabra_en_multiples_archivos_txt
# crear_backup_documento
#monitorear_uso_disco
#procesar_archivos_de_registro
automatizar_descarga_archivos

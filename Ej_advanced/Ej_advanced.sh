#!/bin/bash
# Ejercicio 1: Procesamiento de Logs
# Escribe un script que lea un archivo de log (logfile.log) y extraiga las líneas que contienen errores (puedes buscar la palabra ERROR).
# Luego, genera un nuevo archivo con esas líneas, eliminando duplicados y mostrando el total de errores únicos.
# 
# 1. Crea el archivo de salida unique_errors.log.
# 2. Usa grep para buscar los errores.
# 3. Usa sort y uniq para eliminar duplicados.
# 4. Muestra en pantalla el número total de errores únicos.

function log_processing(){
    #Bucle para comprobar si el archivo es correcto o existe
    while true; do

        read -p "Dime el nombre del archivo buscado (p.e logfile.log) --> " nombre_log
        if [[ -e $nombre_log && $nombre_log == *.log ]]; then
            echo -e "\n[i] Se ha encontrado el archivo\n"
            sleep 1
            echo -e "\n[i] Filtrando....\n"

            break
        else 
            echo -e "\n[!] No se ha encontrado el archivo o no es un archivo .log\n"
        fi
    done 
    #filtrar por "ERROR" y mostrarlo
    busqueda=$(grep "ERROR" $nombre_log | sort | uniq > unique_errors.log)
    cat unique_errors.log
    #Contar el numero de errores
    total_err=$(wc -l < unique_errors.log)
    echo -e "Hay un total de $total_err errores únicos en el archivo"

}
#log_processing

# Ejercicio 2: Copia de Seguridad Incremental
# Escribe un script que haga una copia de seguridad incremental de un directorio (source_dir) hacia otro (backup_dir).
# El script solo debe copiar archivos que hayan sido modificados desde la última copia de seguridad.
# 
# 1. Usa rsync para sincronizar los archivos.
# 2. Agrega opciones de rsync para que solo copie archivos nuevos o modificados.
# 3. Guarda la fecha y hora de la copia en un archivo de log (backup.log) para futuras referencias.
# -----------rsync solo funciona en linux o wsa ------------------------------------------
function security_backup_sync(){
    ubi=$(pwd)
    source_dir="$ubi/source_dir"
    echo -e "Dir origen --> $source_dir"
    backup_dir="$ubi/backup_dir"
    echo -e "Dir destino --> $backup_dir"
    
    # Realizamos la copia de seguridad
    echo -e "\n[!] Realizando copia de seguridad de los archivos modificados.\n"
    sleep 1
    
    # Usamos rsync para sincronizar los archivos modificados
    rsync -av --update $source_dir/ $backup_dir/
    
    # Guardamos la fecha y hora de la copia en un archivo de log
    echo "Backup realizado el: $(date)" >> backup.log
    echo -e "\n[!] Copia de seguridad completada.\n"
}

#security_backup_sync

# Ejercicio 3: Analizar y Comparar Archivos CSV
# Escribe un script que compare dos archivos CSV (file1.csv y file2.csv) y muestre las diferencias entre ellos en términos de filas.
# Supón que los CSVs tienen la misma estructura.
# 
# 1. Usa comm para comparar ambos archivos.
# 2. Muestra en pantalla las filas que están en file1.csv pero no en file2.csv y viceversa.
# 3. Muestra solo las filas únicas que no estén en ambos archivos.

function compare_csv_files(){
    read -p "Dime el nombre del primer archivo CSV (p.e file1.csv) --> " file1
    read -p "Dime el nombre del segundo archivo CSV (p.e file2.csv) --> " file2

    if [[ -e $file1 && $file1 == *.csv && -e $file2 && $file2 == *.csv ]]; then
        echo -e "\n[i] Comparando archivos...\n"
        sleep 1

        echo -e "\n[i] Filas en $file1 pero no en $file2:\n"
        comm -23 <(sort $file1) <(sort $file2)

        echo -e "\n[i] Filas en $file2 pero no en $file1:\n"
        comm -13 <(sort $file1) <(sort $file2)

        echo -e "\n[i] Filas únicas que no están en ambos archivos:\n"
        comm -3 <(sort $file1) <(sort $file2)
    else
        echo -e "\n[!] Uno o ambos archivos no existen o no son archivos .csv\n"
    fi
}

#compare_csv_files

# Ejercicio 4: Organizar Archivos por Tipo y Fecha
# Crea un script que organice los archivos de un directorio (source_dir) en subdirectorios basados en su tipo y fecha de modificación.
# 
# 1. Crea subdirectorios para cada tipo de archivo (por extensión).
# 2. Dentro de cada subdirectorio de tipo, crea subdirectorios basados en el año y mes de la última modificación del archivo.
# 3. Mueve cada archivo a la carpeta correspondiente.

# Ejercicio 5: Monitoreo de Recursos del Sistema
# Escribe un script que monitoree el uso de CPU y memoria del sistema y envíe una alerta por correo electrónico si algún uso excede un umbral determinado (por ejemplo, 80%).
# 
# 1. Usa top o ps para obtener el uso de CPU y memoria.
# 2. Establece un umbral y envía un correo usando mail si se supera.
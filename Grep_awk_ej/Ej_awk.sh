#!/bin/bash

function comprobar_archivo_existe(){
    #Comprobar archivo existe
    while true; do
        read -p "Dime el nombre del archivo: " nombre_archivo
        if [ -e $nombre_archivo ];then
            break
        else
            echo -e "\n El archivo no existe, dime otro archivo \n"
        fi
    done
}
# Ejercicio 1,2: Imprimir la 1 y 2 columna de un archivo
# Utiliza awk para imprimir la primera columna de un archivo llamado "data.txt".
function imprimir_1_columna(){
    comprobar_archivo_existe
    #Hacer el filtrado
    busqueda=$(cat $nombre_archivo | awk '{print $1}')
    echo -e "\nEl resultado del filtro awk es (1 columnas) -->\n"
    echo -e  $busqueda

    busqueda2=$(cat $nombre_archivo | awk '{print $2}')
    echo -e "\nEl resultado del filtro awk es (2 columnas) -->\n"
    echo -e  $busqueda2
}
#imprimir_1_columna

# Ejercicio 3: Imprimir las líneas que contienen un patrón específico
# Utiliza awk para imprimir las líneas de un archivo llamado "data.txt" que contienen la palabra "failed".
function imprimir_patron_error(){
    comprobar_archivo_existe
    #Hacer el filtrado
    busqueda=$(cat $nombre_archivo | awk '/failed/')
    echo -e "\nEl resultado del filtro awk es (líneas con 'failed') -->\n"
    echo -e "$busqueda"
}
# imprimir_patron_error
# Ejercicio 4: Sumar los valores de una columna
# Utiliza awk para sumar los valores de la tercera columna de un archivo llamado "data.txt".
function sumar_valores(){
    comprobar_archivo_existe
    #Hacer la suma
    suma=$(cat $nombre_archivo | awk 'NR > 2 {print $3}' | tr -d ',' | awk '{sum += $1} END {print sum}')
    #Dar el reultado
    echo -e "\n[+]El resultado de la suma es --> $suma\n"
}
# sumar_valores

# Ejercicio 5: Contar el número de líneas que cumplen una condición
# Utiliza awk para contar el número de líneas en un archivo llamado "data.txt" donde el valor de la segunda columna es mayor que 100.
function contar_lineas_cumple_condicion(){
    #Buscar el archivo
    comprobar_archivo_existe
    valor=800
    #Hacer la operacion
    contador=$(cat $nombre_archivo | awk  -v val="$valor", '$3 > val' | awk 'NR > 2 {print($3)}' | tr -d ',' | wc -l)
    #Mostrar el resultado
    echo -e "\nEl número de líneas donde la tercera columna es mayor que $valor es: $contador\n"
}
#  contar_lineas_cumple_condicion

# Ejercicio 6: Imprimir columnas específicas con formato
# Utiliza awk para imprimir la primera y la tercera columna de un archivo llamado "data.txt" con un formato específico, por ejemplo, separadas por un guion.
function imprimir_columnas_formato(){
    #Buscar el archivo
    comprobar_archivo_existe
    #Hacer la operacion
    resultado=$(awk 'NR >= 2 {print $1 "-" $2 "-" $3}' $nombre_archivo | tr -d ',')
    #Mostrar el resultado
    echo -e "\nEl resultado del filtro awk es (1 y 3 columnas separadas por un guion) -->\n"
    echo -e "$resultado"
}
# imprimir_columnas_formato

# Ejercicio 7: Filtrar y modificar el contenido de un archivo
# Utiliza awk para filtrar las líneas de un archivo llamado "data.txt" donde la segunda columna es mayor que 50 y, además, multiplica el valor de la tercera columna por 2.
function filtra_y_modificar_contenido(){
    #Buscar el archivo
    comprobar_archivo_existe
    #Hacer la operacion
    resultado=$(cat data.txt |tr -d ',' |awk '$3 > 500' |awk 'NR>2 {print($1 "-" $2 "-" $3*2)}')
    #Mostrar el resultado
    echo -e "\nEl resultado del filtro y multiplicacion es -->\n"
    echo -e "$resultado"
}
# filtra_y_modificar_contenido

# Ejercicio 8: Crear un reporte con estadísticas
# Utiliza awk para crear un reporte que muestre el número total de líneas, la suma de los valores de la 
# columna Precio y el promedio de los valores de la columna Cantidad en un archivo llamado "data.txt".
function crear_reporte_estadisticas(){
    comprobar_archivo_existe
    total_lineas=$(awk 'END {print NR}' $nombre_archivo)
    suma_precio=$(awk '{sum += $2} END {print sum}' $nombre_archivo)
    promedio_cantidad=$(awk '{sum += $3; count++} END {if (count > 0) print sum / count; else print 0}' $nombre_archivo)
    echo -e "\nReporte de estadísticas:\n"
    echo -e "Número total de líneas: $total_lineas"
    echo -e "Suma de los valores de la columna Precio: $suma_precio"
    echo -e "Promedio de los valores de la columna Cantidad: $promedio_cantidad"
}
 crear_reporte_estadisticas

# Ejercicio 9: Procesar múltiples archivos
# Utiliza awk para procesar múltiples archivos llamados "data1.txt", "data2.txt" y "data3.txt", y generar 
# un reporte combinado que incluya la suma de los valores de la columna Precio de todos los archivos.
function procesar_multiples_archivos(){
    archivos=("data1.txt" "data2.txt" "data3.txt")
    suma_precio_total=0
    for archivo in "${archivos[@]}"; do
        if [ -e $archivo ]; then
            suma_precio=$(awk '{sum += $2} END {print sum}' $archivo)
            suma_precio_total=$(echo "$suma_precio_total + $suma_precio" | bc)
        else
            echo -e "\nEl archivo $archivo no existe."
        fi
    done
    echo -e "\nReporte combinado:\n"
    echo -e "Suma total de los valores de la columna Precio: $suma_precio_total"
}
# procesar_multiples_archivos

# Ejercicio 10: Usar funciones definidas por el usuario
# Utiliza awk para definir una función que calcule el cuadrado de un número y aplícala a los valores de 
# la columna Precio de un archivo llamado "data.txt".
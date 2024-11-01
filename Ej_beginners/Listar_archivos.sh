#!/bin/bash
: '
---------------------Listar archivos en un directorio--------------------
Comando: ls

Descripción: Lista los archivos y directorios en el directorio actual.

Ejercicio: Escribe un script que liste todos los archivos y directorios 
            en el directorio actual.
'

function listar(){
    echo -e "\n-----------------------------------"
    echo -e "------Listado de elementos---------"
    echo -e "-----------------------------------\n"
    ls -l
    #res=$(ls -l)
    #echo -e "$res"
}

#Ejecutar funcion
listar
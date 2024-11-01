#!/bin/bash
: 'Escribe un script que defina una función para calcular el factorial de un número dado.
Manipulación de Archivos:'
read -p "Ponga un numeroa para hacer el factorial --> " num

function factorial(){
    num=$1
    res=1
    echo -e "Factorial de $num:"
    for((i=1;i<=num;i++));do
        res=$((res*i))
    done
    echo -e "\tEl resultado del factorial es -> $res"
}

factorial $num

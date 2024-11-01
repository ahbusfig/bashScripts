#!/bin/bash
: '
Escribe un script que tome un número como entrada y determine si es par o impar.
Bucles:
'
read -p "Dime un numero --> " num
par_impar=$((num%2))
if [ $par_impar -eq 0 ]; then 
    echo -e "El numero --> $num es par"
elif [ $par_impar -ne 0 ]; then 
    echo -e "El numero --> $num es impar"
else 
    echo -e "Hubo un error al introducir el número"
fi


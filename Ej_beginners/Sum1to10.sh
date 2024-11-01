#!/bin/bash
: 'Crea un script que imprima los números del 1 al 10 usando un bucle for.
Funciones:
'
echo -e "Crea un script que imprima los números del 1 al 10 usando un bucle for\n"
for num in {1..10}; do
    echo -e "Probando..."
    echo -e "\t Este es el numero --> $num\n"
done

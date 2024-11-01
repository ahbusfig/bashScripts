#!/bin/bash
: '
Hola Mundo:

Escribe un script que imprima "Hola Mundo" en la terminal.
Variables y Operaciones:
'
msg="Hola mundo"
echo -e "[+] Escribe un script que imprima "Hola Mundo" en la terminal. Variables y Operaciones:"
echo -e "El mensaje es --> $msg"

: '
Crea un script que declare dos variables con números y luego imprima la suma, resta, multiplicación y división de esos números.
Condicionales:
'
#!/bin/bash

# Solicitar los números por teclado
read -p "Introduce el 1 numero --> " num1
read -p "Introduce el 2 numero --> " num2
#-------------------------------Forma sencilla de hacerlo-----------------------------------
# Declarar un array con las operaciones
suma=$((num1+num2))
resta=$((num1-num2))
mult=$((num1*num2))
div=$((num1/num1))

#Mostrar resultado en pantalla
echo -e "$num1 + $num2 = $suma"
echo -e "$num1 - $num2 = $resta"
echo -e "$num1 * $num2 = $mult"
echo -e "$num1 / $num2 = $div"
#--------------------------------Forma de hacerla con un bucle--------------------------------

operaciones=("+ - * /")
# Iterar sobre las operaciones y realizar cada una
for operacion in ${operaciones[@]}; do
    resultado=$(($num1 $operacion $num2))
    echo "Resultado de $num1 $operacion $num2 = $resultado"
done   


: '


Crea un script que lea un archivo línea por línea e imprima cada línea en la terminal.
Argumentos de Línea de Comandos:

Escribe un script que acepte argumentos de línea de comandos y los imprima.
Redirección y Pipes:

Crea un script que redirija la salida de un comando a un archivo y luego use cat para mostrar el contenido del archivo.s
'
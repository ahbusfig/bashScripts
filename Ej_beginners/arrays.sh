#----------Declarar un array-------------
#declare -a secuencia=(1 2 3 4)
echo "Introduce los elementos del array separados por espacios: "
read -a secuencia
#-----------Imprimir en pantalla----------
echo -e "\nLa secuencia --> ${secuencia[@]}" #Para imprimir todos los elementos

#-----------Imprimir en pantalla un elemento----------
echo -e "\nSecuencia[0] ---> ${secuencia[0]}"

#-----------Imprimir mediante bucle for in----------
echo -e "\n---------Bucle con in--------\n"
i=0
for elemento in "${secuencia[@]}"
do
    echo -e "Elemento $i --> $elemento"
    i=$((i + 1)) 
done
#-----------Imprimir mediante bucle con len del array----------
# Obtener la longitud del array --> se usa #!!!
echo -e "\n---------Bucle con len--------\n"
len=${#secuencia[@]}
# Usar un bucle for con índice
for (( i=0; i<len; i++ ))
do
    echo -e "Elemento $i con Len --> ${secuencia[$i]}"
done

#---------------Modificar el array ya creado------------------------
echo -e "\n---------Elementos modificados (Añadir)--------\n"
secuencia[0]=2
secuencia[1]="Naranja" #Modificar la pos 1 
secuencia[2]="Hello"   #Modificar la pos 2
secuencia+=(new1 new2) #Añadimos más elementos al array
# Reindexar el array para eliminar huecos
secuencia=("${secuencia[@]}")
#Bucle
i=0
for itemMod in ${secuencia[@]};
do
    echo -e "Elemento $i modificado --> $itemMod"
    i=$((i+1))
done

echo -e "\n---------Elementos modificados (Eliminar)--------\n"
# Imprimir el array original
echo -e "\nArray original --> ${secuencia[@]}"
# Eliminar el elemento en la posición 2 (tercer elemento)
unset 'secuencia[2]' # unset 
# Imprimir el array después de eliminar el elemento
echo -e "\nArray después de eliminar el elemento en la posición 2 --> ${secuencia[@]}\n"
# Reindexar el array para eliminar huecos
secuencia=("${secuencia[@]}")
# Imprimir el array después de reindexar
echo -e "\nArray después de reindexar --> ${secuencia[@]}"

#Bucle
i=0
for itemMod in ${secuencia[@]};
do
    echo -e "Elemento $i modificado --> $itemMod"
    i=$((i+1))
done







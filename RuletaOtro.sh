 #!/bin/bash
 
 #Colores
 rojo='\033[1;31m'
 verde='\033[1;32m'
 amarillo='\033[1;33m'
 azul='\033[1;34m'
 magenta='\033[1;35m'
 cyan='\033[1;36m'
 blanco='\033[1;37m'
 end='\033[0m'
 
 # Control de salida 
 function ctrl_c(){
   echo -e "\n${rojo}[!] Saliendo ...${end}"
   tput cnorm; exit 1 
 }
 
 #Ctrl+C
 trap ctrl_c INT
 
 # Banner
 echo ""
 echo "  ####     #                                         #        #                               ##            ###                   # "
 echo "   #  #                                                       #                                #           #   # "
 echo "   #  #   ##     ###   # ##   #   #   ###   # ##    ##     ## #   ###    ###           ###     #           #       ###    ###    ##    # ##    ### "
 echo "   ###     #    #   #  ##  #  #   #  #   #  ##  #    #    #  ##  #   #  #                 #    #           #          #  #        #    ##  #  #   # "
 echo "   #  #    #    #####  #   #   # #   #####  #   #    #    #   #  #   #   ###           ####    #           #       ####   ###     #    #   #  #   # "
 echo "   #  #    #    #      #   #   # #   #      #   #    #    #  ##  #   #      #         #   #    #           #   #  #   #      #    #    #   #  #   # "
 echo "  ####    ###    ###   #   #    #     ###   #   #   ###    ## #   ###   ####           ####   ###           ###    ####  ####    ###   #   #   ### "

 # Panel de ayuda
 function helpPanel(){
   echo -e "\n${cyan}[*]${end} ${blanco}Uso:${end} ${magenta}$0${end}\n"
   echo -e "\t${cyan}-m${end} ${blanco}Dinero con el que se desea jugar${end} "
   echo -e "\t${cyan}-t${end} ${blanco}Tecnica que desea utilizar:${end} ${amarillo}martingala${end} / ${amarillo}inverseLabrouchere${end} / ${amarillo}fibonacci${end} / ${amar
 illo}andrucci${end} \n"
   exit 1 
 }
 
 function martingala(){
   echo -e "\n${amarillo}[*]${end} Dinero Actual: ${amarillo}$money€${end}"
   while true; do
     echo -ne "${amarillo}[*]${end} Cual es la cantidad que deseas apostar? -> " && read apuesta
     # Validar que la apuesta sea un número entero
     if ! [[ "$apuesta" =~ ^[0-9]+$ ]]; then
       echo -e "\n${rojo}[*] Error: La cantidad a apostar debe ser un número entero válido.\n${end}"
       continue
     fi
     # Verificar que la cantidad apostada no sea mayor al dinero disponible
     if [ $apuesta -gt $money ]; then
       echo -e "\n${rojo}[*] El dinero que desea apostar es mayor a su dinero actual\n${end} "
       continue
     fi
     break
   done
   while true; do 
     # Solicitar el tipo de apuesta y validar que sea "par" o "impar"
     echo -ne "${amarillo}[*]${end} A que vas a querer apostar continuamente (par/impar) -> " && read par_impar
     # Validar que la entrada sea exactamente "par" o "impar"
     if [[ "$par_impar" != "par" && "$par_impar" != "impar" ]]; then
       echo -e "\n${rojo}[*] Error: Debes ingresar 'par' o 'impar'.\n${end}"
       continue
     fi
     break
   done
   # Confirmación de la apuesta
 # echo -e "\n${amarillo}[*]${end} Perfecto vas a apostar ${amarillo}$apuesta€${end} a ${amarillo}$par_impar${end}"
 
 # Guarda el valor inicial de la apuesta
   backup_apuesta=$apuesta
 
 # Contiene la cantidad de jugadas realizadas
   contador=0
 
 # Contiene las jugadas malas consecutivas
   jugadas_malas=" "
 
 # Ganancia maxima 
   ganancia_maxima=0
 
   tput civis # ocultar el cursor
   while true; do
     money=$(($money-$apuesta))
     echo -e "\n${amarillo}[*]${end} Acabas de apostar ${amarillo}$apuesta€${end}, te quedan ${amarillo}$money€${end}"
     random_number="$(($RANDOM % 37))"
     echo -e "${amarillo}[*]${end} Ha salido el numero $random_number"
 
     #Numero Par
     # Valida si es menor a 0
     if [ $money -gt $apuesta ]; then
       if [ $par_impar == "par"  ]; then
         if [ "$(($random_number % 2 ))" -eq 0 ];then
           if [ $random_number -eq 0 ]; then
             echo -e "${rojo}[*] El numero es el 0, pierdes :( ${end}"
             apuesta=$((apuesta * 2))
             jugadas_malas+="$random_number "
           else
             reward="$(($apuesta * 2))"
             echo -e "${amarillo}[*]${end} ${verde}El numero es par, has ganado $reward$ :)${end}  "
             money=$(($reward + $money))
             # Guarda la cantida mas alta que has ganado 
             ganancia_maxima=$money
             echo -e "${amarillo}[*]${end} Tus saldo es de ${amarillo}$money${end} "
             #Reinicia la apuesta ala inicial
             apuesta=$backup_apuesta
             #Reinicia el conteo de los malos numeros ya que a ganado
             jugadas_malas=" "
           fi
         else
           echo -e "${rojo}[*] El numero es impar, pierdes :( ${end}"
           apuesta=$((apuesta * 2))
           # Guarda la serie de malos numeros que has salido
           jugadas_malas+="$random_number "
         fi
       else
         # Numero impar
         if [ $par_impar == "impar"  ]; then
           if [ "$(($random_number % 2 ))" -eq 1 ];then
               reward="$(($apuesta * 2))"
               echo -e "${amarillo}[*]${end} ${verde}El numero es impar, has ganado $reward$ :)${end}  "
               money=$(($reward + $money))
               # Guarda la cantida mas alta que has ganado 
               ganancia_maxima=$money
               echo -e "${amarillo}[*]${end} Tus saldo es de ${amarillo}$money${end} "
               #Reinicia la apuesta ala inicial
               apuesta=$backup_apuesta
               #Reinicia el conteo de los malos numeros ya que a ganado
               jugadas_malas=" "
           else
             echo -e "${rojo}[*] El numero es par, pierdes :( ${end}"
             apuesta=$((apuesta * 2))
             # Guarda la serie de malos numeros que has salido 
             jugadas_malas+="$random_number "
           fi
         fi
       fi
     else
       echo -e "\n${rojo}[!] La apuesta que desea hacer es mayor a su dinero actual , adios${end} "
       echo -e "\n${amarillo}[*]${end} Se han realizado un total de ${amarillo}$(($contador))${end} jugadas "
       echo -e "\n${amarillo}[*]${end} Tuviste esta cadena consecutiva de numeros malos \n \t[$jugadas_malas]"
       echo -e "\n${amarillo}[*]${end} La cantidad maxima que llegaste a ganar fue ${amarillo}$ganancia_maxima${end}"
       tput cnorm; exit 0 
     fi
 
     # Va sumando el total de jugadas realizadas
     let contador+=1
 
   done
     tput cnorm # Recuperar el cursor
 }
 
 function inverseLabrouchere(){
   
   echo -e "\n${amarillo}[*]${end} Dinero Actual: ${amarillo}$money€${end}"
   while true; do 
     # Solicitar el tipo de apuesta y validar que sea "par" o "impar"
     echo -ne "${amarillo}[*]${end} A que vas a querer apostar continuamente (par/impar) -> " && read par_impar
     # Validar que la entrada sea exactamente "par" o "impar"
     if [[ "$par_impar" != "par" && "$par_impar" != "impar" ]]; then
       echo -e "\n${rojo}[*] Error: Debes ingresar 'par' o 'impar'.\n${end}"
       continue 
     fi
     break
   done
   # Bucle para solicitar la secuencia de números
   while true; do
     echo -ne "${amarillo}[*]${end} Ingresa los numeros separados por un espacio que sera la secuencia con la que quieres empezar -> " && read secuencia 
     # Valida que la entrada sean numeros enteros 
     if ! [[ "$secuencia" =~ ^[0-9\ ]+$ ]]; then 
       echo -e "\n${rojo}[*] Error: Debes ingresar numeros enteros separados por un espacio\n${end}" 
       continue
     fi
 
     declare -a backup=($secuencia)
     # Convierte la secuencia en un array 
     declare -a arraySecuencia=($secuencia)
     # Verifica que el número de elementos sea al menos 3
     if [ ${#arraySecuencia[@]} -lt 3 ]; then
       echo -e "\n${rojo}[*] Error: Debes ingresar al menos 3 numeros separados por un espacio\n${end}" 
       continue
     fi 
     break 
   done
 
   # Variables
   # Jugadas totales
   contador=0
   # Ganacia maxima
   ganancia_maxima=0
   # Dinero al que debemos llegar para renovar la secuencia 
   bet_to_renew=$(($money+50))
   echo -e "${amarillo}[*]${end} El tope para renovar la secuencia sera de ${amarillo}$bet_to_renew€${end} "
 
   while true; do
 
     # Evalua si el array tiene solo 1 elemento
     if ! [ ${#arraySecuencia[@]} -lt 1 ]; then
        # Ejecuta la suma del primer elemento con el ultimo y la guarda en la variable
       apuesta_inicial="$((${arraySecuencia[0]}+${arraySecuencia[-1]}))"
 
       # Verifica si la cantidad que queremos apostar no es mayor a nuestro dinero
       if [ $apuesta_inicial -gt $money ]; then
       echo -e "${rojo}[*] La apuesta que desea hacer excede su dinero actual ${end}"
       echo -e "\n${amarillo}[*]${end} El total de jugadas fue de ${amarillo}$contador${end} "
       echo -e "${amarillo}[*]${end} La ganacia maxima que obtuvo fue de ${amarillo}$ganancia_maxima€${end}"
       exit 0
       fi

       # Resta la apuesta inicial al dinero actual
       money="$(($money-$apuesta_inicial))"
 
       # Muestra el valor de la apuesta
       echo -e "\n${amarillo}[*]${end} La apuesta sera de ${amarillo}$apuesta_inicial${end}€"
       echo -e "${amarillo}[*]${end} Dinero actual ${amarillo}$money€${end}"
 
       # Saca los numeros random
       random_number="$(($RANDOM % 37))"
       echo -e "${amarillo}[*]${end} Ha salido el numero $random_number"
 
       # Calcula si sobrepasa el nivel critico de perdida
       if [ $money -lt $(($bet_to_renew-100)) ]; then
         echo -e "${amarillo}[*]${end} Se a superado un nivel critico de ${amarillo}$(($bet_to_renew-100))€${end}, se procede a reestablecer el tope "
         let bet_to_renew-=50
         echo -e "${amarillo}[*]${end} El tope a sido renovado a ${amarillo}$bet_to_renew€${end}"
       fi
 
       # Numero Par
       if [ $par_impar == par ]; then
         # Verifica si el numero es par o impar 
         if [ "$(($random_number % 2 ))" -eq 0 ];then
           if [ $random_number -eq 0 ]; then
             echo -e "${rojo}[*] El numero es impar, pierdes ${apuesta_inicial}€ :( ${end}"
             unset arraySecuencia[0]
             unset arraySecuencia[-1] 2>/dev/null
             arraySecuencia=(${arraySecuencia[@]})
             echo -e "${amarillo}[*]${end} La nueva secuencia es [ ${arraySecuencia[@]} ] \n"
           else
             arraySecuencia+=($apuesta_inicial)
             reward=$(($apuesta_inicial*2))
             money=$(($reward + $money))
             # Guarda el mayor valor de ganacia obtenida
             if [ $money -gt $ganancia_maxima ]; then
               ganancia_maxima=$money
             fi
             echo -e "${amarillo}[*]${end}${verde} El numero es par, has ganado${end} ${amarillo}$reward€${end} ${verde}tienes ${end}${amarillo}$money€${end}"
               # Verifica si el dinero es mayor al tope para reiniciar la secuencia
               if [ $money -gt $bet_to_renew ]; then
                 echo -e "${amarillo}[*]${end} Se a superado el tope establecido de ${amarillo}$bet_to_renew€${end} "
                 let bet_to_renew+=50
                 echo -e "${amarillo}[*]${end} Se reinicia la secuencia y el tope queda establecido en ${amarillo}$bet_to_renew€${end}"
                 arraySecuencia=(${backup[@]})
                 apuesta_inicial="$((${arraySecuencia[0]}+${arraySecuencia[-1]}))"
               fi 
             echo -e "${amarillo}[*]${end} La nueva secuencia es [ ${arraySecuencia[@]} ]"
             # Incrementar el contador solo después de realizar la jugada
             let contador+=1
           fi
         else
           echo -e "${rojo}[*] El numero es impar, pierdes $apuesta_inicial€ :( ${end}"
           unset arraySecuencia[0]
           unset arraySecuencia[-1] 2>/dev/null
           arraySecuencia=(${arraySecuencia[@]})
           echo -e "${amarillo}[*]${end} La nueva secuencia es [ ${arraySecuencia[@]} ] "
           # Incrementar el contador solo después de realizar la jugada
           let contador+=1
         fi
       else 
         # Numero impar 
         if [ $par_impar == impar ]; then
           # Verifica si el numero es par o impar 
           if [ "$(($random_number % 2 ))" -eq 1 ]; then
             arraySecuencia+=($apuesta_inicial)
             reward=$(($apuesta_inicial*2))
             money=$(($reward + $money))
             # Guarda el mayor valor de ganacia obtenida
             if [ $money -gt $ganancia_maxima ]; then 
               ganancia_maxima=$money
             fi
             echo -e "${amarillo}[*]${end}${verde} El numero es impar, has ganado${end} ${amarillo}$reward€${end} ${verde}tienes ${end}${amarillo}$money€${end}"
               # Verifica si el dinero es mayor al tope para reiniciar la secuencia
               if [ $money -gt $bet_to_renew ]; then
                 echo -e "${amarillo}[*]${end} Se a superado el tope establecido de ${amarillo}$bet_to_renew€${end} "
                 let bet_to_renew+=50
                 echo -e "${amarillo}[*]${end} Se reinicia la secuencia y el tope queda establecido en ${amarillo}$bet_to_renew€${end}"
                 arraySecuencia=(${backup[@]})
                 apuesta_inicial="$((${arraySecuencia[0]}+${arraySecuencia[-1]}))"
               fi
             echo -e "${amarillo}[*]${end} La nueva secuencia es [ ${arraySecuencia[@]} ]"
             # Incrementar el contador solo después de realizar la jugada
             let contador+=1
           else
             echo -e "${rojo}[*] El numero es par, pierdes :( ${end}"
             unset arraySecuencia[0]
             unset arraySecuencia[-1] 2>/dev/null
             arraySecuencia=(${arraySecuencia[@]})
             echo -e "${amarillo}[*]${end} La nueva secuencia es [ ${arraySecuencia[@]} ] "
             # Incrementar el contador solo después de realizar la jugada
             let contador+=1
           fi
         fi
       fi
     else
       while true ; do
         # Guarda la respuesta por consola
         echo -en "\n${rojo}[!]${end} Se acabaron los numeros de la secuencia , desea continuar ${amarillo}s/n ${end} " && read si_no
         # Valida que la respuesta sea si o no 
         if [[ "$si_no" != "s" && "$si_no" != "n" ]]; then
           echo -e "${rojo}[*] Error: Elije una de las dos opciones s / n${end}"
           continue
         fi
         break
       done
         if [ $si_no = s ]; then
           while true; do
             echo -en "${amarillo}[*]${end} Desea continuar con la secuencia de numeros [ ${backup[@]} ] ${amarillo}s/n${end} " && read respuesta
             # Valida que la respuesta sea si o no
             if [[ "$respuesta" != "s" && "$respuesta" != "n" ]]; then
               echo -e "${rojo}[*] Error: Elije una de las dos opciones s / n${end}"
               continue
             fi
             break
           done 
           while true; do
             if [ $respuesta = s ];then
               arraySecuencia=(${backup[@]})
             else
               echo -en "${amarillo}[*]${end} Elije la nueva secuencia de numeros " && read nueva_secuencia
               # Valida que la entrada sean numeros enteros 
               if ! [[ "$nueva_secuencia" =~ ^[0-9\ ]+$ ]]; then 
                 echo -e "\n${rojo}[*] Error: Debes ingresar numeros enteros separados por un espacio\n${end}"
                 continue
               fi
               # Actuliza la secuencia
               declare -a arraySecuencia=($nueva_secuencia)
               # Verifica que el número de elementos sea al menos 3
               if [ ${#arraySecuencia[@]} -lt 3 ]; then
                 echo -e "\n${rojo}[*] Error: Debes ingresar al menos 3 numeros separados por un espacio\n${end}" 
                 continue
               fi
             fi 
           break 
           done
         else 
           echo -e "\n${rojo}[*] El juego a terminado, Adios ${end}"
           echo -e "\n${amarillo}[*]${end} El total de jugadas fue de ${amarillo}$contador${end} "
           echo -e "${amarillo}[*]${end} La ganacia maxima que obtuvo fue de ${amarillo}$ganancia_maxima€${end}"
           exit 0
         fi 
     fi
   done
 
 }
 
 function fibonacci(){
 
   echo -e "\n${amarillo}[*]${end} Dinero Actual: ${amarillo}$money€${end}"
 
 # Solicitar la apuesta inicial del usuario
  while true; do
    echo -ne "${amarillo}[*]${end} Ingresa el valor inicial de la apuesta -> " && read apuesta_inicial
    if ! [[ "$apuesta_inicial" =~ ^[0-9]+$ ]]; then
      echo -e "${rojo}[*] Error: Debe ser un número entero válido.\n${end}"
      continue
    fi
    if [ $apuesta_inicial -gt $money ]; then
      echo -e "${rojo}[*] La apuesta que desea hacer excede su dinero actual\n ${end}"
      continue
    fi
    break
  done

  while true; do 
    # Solicitar el tipo de apuesta y validar que sea "par" o "impar"
    echo -ne "${amarillo}[*]${end} A que vas a querer apostar continuamente (par/impar) -> " && read par_impar
    # Validar que la entrada sea exactamente "par" o "impar"
    if [[ "$par_impar" != "par" && "$par_impar" != "impar" ]]; then
      echo -e "\n${rojo}[*] Error: Debes ingresar 'par' o 'impar'.\n${end}"
      continue 
    fi
    break
  done

  while true; do
    echo -ne "${amarillo}[*]${end} Cual es la cantidad de numeros que quieres en la secuencia ? -> " && read secuencia
    # Validar que la secuencia sea un número entero
    if ! [[ "$secuencia" =~ ^[0-9]+$ ]]; then
      echo -e "\n${rojo}[*] Error: Debe ser un número entero válido.\n${end}"
      continue
     fi
     break
   done
 
    # Número de elementos de la secuencia Fibonacci
   num=$secuencia
 
   # Variables de inicio de la variable de la secuencia
   a=$apuesta_inicial
   b=$apuesta_inicial
 
   # Array para almacenar la secuencia de Fibonacci
   fibonacci_array=()
 
   echo -en "${amarillo}[*]${end} La secuencia para jugar será: "
 
   # Bucle para generar y mostrar la secuencia de Fibonacci
   for (( i=0; i<num; i++ )); do
     echo -n "$a "         # Imprime el valor actual de la secuencia sin salto de línea
     fibonacci_array+=($a) # Guarda el valor del fibonacci en el array 
     fn=$((a + b))         # Calcula el siguiente número de la secuencia
     a=$b                  # Actualiza a con el valor de b
     b=$fn                 # Actualiza b con el nuevo valor calculado
   done
   # Salto de linea para finalizar la linea anterior
   echo ""
 
   # Varible de la ganancia maxima
   ganancia_maxima=0

   # contador de la jugadas realizadas
   contador_jugadas=0
 
   # Empezamos con la primera apuesta basada en el primer número de Fibonacci
   contador=0
   apuesta=${fibonacci_array[$contador]}
 
   while true; do
     # verifica que la apuesta no sea mayor al dinero que tiene 
     if ! [[ $money -lt $apuesta ]]; then
       if ! [ $contador -ge $num ]; then
         # Mostrar la secuencia de Fibonacci
         echo -e "\n${amarillo}[*]${end} La apuesta sera de: ${amarillo}$apuesta${end}"
         # Saca los numeros random
         random_number="$(($RANDOM % 37))"
         echo -e "${amarillo}[*]${end} Ha salido el numero $random_number"
         # Numero par 
         if [ $par_impar == par ]; then
           if (( $random_number % 2 == 0 && $random_number != 0 )); then
             echo -e "${verde}[*] El numero es par, ganas${end}"
             contador=$(($contador-2))
             if [ $contador -lt 0 ]; then
               contador=0
             fi
             money=$(($money+$apuesta))
             # Guarda el mayor valor de ganacia obtenida
             if [ $money -gt $ganancia_maxima ]; then
               ganancia_maxima=$money
             fi
             echo -e "${amarillo}[*]${end} Dinero actual: ${amarillo}$money${end}"
             # Va acumulando la cantidad de jugadas realizadas
             let contador_jugadas+=1
           else
             echo -e "${rojo}[*] El numero es impar, pierdes${end}"
             contador=$(($contador+1)) 
             money=$(($money-$apuesta))
             echo -e "${amarillo}[*]${end} Dinero actual: ${amarillo}$money${end}"
             # Va acumulando la cantidad de jugadas realizadas
             let contador_jugadas+=1
           fi
         else
           if [ $par_impar == impar ]; then
             if (( $random_number %2 == 1 )); then 
               echo -e "${amarillo}[*] El numero es impar, ganas${end}"
               contador=$(($contador-2))
               if [ $contador -lt 0 ]; then
                 contador=0
               fi
               money=$(($money+$apuesta))
               # Guarda el mayor valor de ganacia obtenida
               if [ $money -gt $ganancia_maxima ]; then
               ganancia_maxima=$money
               fi
               echo -e "${amarillo}[*]${end} Dinero actual: ${amarillo}$money${end}"
               # Va acumulando la cantidad de jugadas realizadas
               let contador_jugadas+=1
             else
               echo -e "${rojo}[*] El numero es par, pierdes${end}"
               contador=$(($contador+1))
               money=$(($money-$apuesta))
               echo -e "${amarillo}[*]${end} Dinero actual: ${amarillo}$money${end}"
               # Va acumulando la cantidad de jugadas realizadas
               let contador_jugadas+=1
             fi
           fi
         fi
 
         # Actualiza la apuesta con el valor correspondiente en la secuencia de Fibonacci
         apuesta=${fibonacci_array[$contador]}
       else
         while true; do 
           echo -en "\n${rojo}[*]${end} Se a terminado la secuencia de numeros, desea seguir jugando ${amarillo}s/n:${end} " && read si_no
           if [[ $si_no != "s" && $si_no != "n" ]]; then
             echo -e "${rojo}[!] Error : Escoja una de las dos opciones s/n\n${end}" 
             continue
           fi
           break
         done
         if [ $si_no == "s" ]; then
           while true; do 
             echo -en "${amarillo}[*]${end} Quiere seguir con la misma secuencia de numeros ${amarillo}s/n:${end} " && read respuesta
             if [[ $respuesta != "s" && $respuesta != "n" ]]; then
               echo -e "${rojo}[!] Error: Escoja una de las dos opciones s/n\n${end} "
               continue
             fi
             break
           done 
           if [ $respuesta == "s" ]; then
             # Reinicio el contador para que vuelva a hacer todo el bucle
             contador=0 
             apuesta=${fibonacci_array[$contador]}
           else
             while true; do 
               echo -en "${amarillo}[*]${end} De cuantos numeros desea la secuencia: " && read nueva_secuencia
               # Valida que la entrada sean numeros enteros 
               if ! [[ "$nueva_secuencia" =~ ^[0-9]+$ ]]; then 
                 echo -e "${rojo}[*] Error: Debes ingresar un numero entero \n${end}"
                 continue
               fi
               break
             done 
             num=$nueva_secuencia
             a=1
             b=1
 
             fibonacci_array=()
              
             echo -en "${amarillo}[*]${end} La nueva secuencia para jugar será: "
               for (( i=0; i<num; i++ )); do
               echo -n "$a "         # Imprime el valor actual de la secuencia sin salto de línea
               fibonacci_array+=($a) # Guarda el valor del fibonacci en el array 
               fn=$((a + b))         # Calcula el siguiente número de la secuencia
               a=$b                  # Actualiza a con el valor de b
               b=$fn                 # Actualiza b con el nuevo valor calculado
               done
               echo ""
             contador=0 
             apuesta=${fibonacci_array[$contador]}
           fi
         else
             echo -e "${rojo}[!] El juego a terminado ${end}"
             echo -e "${amarillo}[*]${end} El total de jugadas realizadas fue de ${amarillo}$contador_jugadas${end}"
             echo -e "${amarillo}[*]${end} La ganacia maxima que obtuvo fue de ${amarillo}$ganancia_maxima€${end}"
             exit 1 
         fi
       fi
     else
       echo -e "\n${rojo}[!] La apuesta que desea hacer es mayor a su dinero actual, el juego a terminado ${end}"
       echo -e "${amarillo}[*]${end} El total de jugadas realizadas fue de ${amarillo}$contador_jugadas${end}"
       echo -e "${amarillo}[*]${end} La ganacia maxima que obtuvo fue de ${amarillo}$ganancia_maxima€${end}"
       exit 1
     fi
 
   done
 }
 
 function andrucci(){
   
   echo -e "\n${amarillo}[*]${end} Dinero Actual: ${amarillo}$money€${end}"
 
   # Variables
   contador=0
   contador_jugadas=0
   jugadas_ganadoras=0
   max_repeticiones=0
   numero_repetido=0
 
   declare -A frecuencia 
 
   while [ $contador -lt 30 ]; do

     # Saca los numeros random
     random_number="$(($RANDOM % 37))"
     echo -e "${amarillo}[*]${end} Ha salido el numero $random_number"
     # Incrementa la frecuencia del número generado
     frecuencia[$random_number]=$((${frecuencia[$random_number]:0} +1))
     ((contador++))
 
   done
   
   echo -e "${amarillo}[*]${end} Se han generado $contador jugadas\n"
 
   for numeros in "${!frecuencia[@]}"; do
     if [ ${frecuencia[$numeros]} -gt $max_repeticiones ]; then
       max_repeticiones=${frecuencia[$numeros]}
       numero_repetido=$numeros
     fi
   done
 
   echo -e "${amarillo}[*]${end} El numero que mas se repito fue el ${amarillo}$numero_repetido${end} un total de ${amarillo}$max_repeticiones${end} veces"
   while true; do 
     echo -en "${amarillo}[*]${end} Cuanto vas a querer apostar al numero ${amarillo}$numero_repetido${end} -> " && read apuesta 
     if ! [[ $apuesta =~ ^[0-9]+$ ]]; then
       echo -e "${rojo}[!] Error, debes ingresar un numero entero \n${end}"
       continue
     fi
     if [ $apuesta -gt $money ]; then
       echo -e "${rojo}[*] La apuesta que desea hacer excede su dinero actual${end}\n "
       continue
     fi
     break
   done
   
 
   while true; do 
     random_number=$((RANDOM % 37))
     if ! [ $money -eq 0 ]; then 
       if [ $random_number == $numero_repetido ]; then
         echo -e "${verde}\n[*] Ha salido el numero $numero_repetido, ganas ${end}"
         money="$(($money+$apuesta))"
         echo -e "${amarillo}[*]${end} Dinero actual: ${amarillo}$money${end}"
         let contador_jugadas+=1
         let jugadas_ganadoras+=1
       else
         echo -e "${rojo}\n[*] Ha salido el numero $random_number, pierdes ${end}"
         money=$(($money-$apuesta))
         echo -e "${amarillo}[*]${end} Dinero actual: ${amarillo}$money${end}"
         let contador_jugadas+=1
       fi
     else 
       echo -e "${rojo}\n[!] Se te acabo el dinero, adios${end} "
       echo -e "${amarillo}[*]${end} El total de jugadas fue de ${amarillo}$contador_jugadas${end}"
       echo -e "${amarillo}[*]${end} Jugadas ganadoras ${amarillo}$jugadas_ganadoras${end}"
       exit 1
     fi
   done
 
 }
 # Guardar Parametros
 while getopts "m:t:h" arg; do
   case $arg in
     m) money=$OPTARG;;
     t) technique=$OPTARG;;
     h) helpPanel;;
   esac
 done
 
 # condicional de los parametros 
 if [ $money ] && [ $technique ]; then
    # Validar que la apuesta sea un número entero
   if ! [[ "$money" =~ ^[0-9]+$ ]]; then
     echo -e "\n${rojo}[*] Error: La cantidad a apostar debe ser un número entero válido.\n${end}"
     exit 1
   fi
 
   if [ "$technique" == "martingala" ]; then
     martingala
   elif [ $technique == "inverseLabrouchere" ]; then
     inverseLabrouchere
   elif [ $technique == "fibonacci" ]; then
     fibonacci
   elif [ $technique == "andrucci" ]; then 
     andrucci
   else
     echo -e "\n${cyan}[*]${end}${rojo} La tecnica introducida no existe${end}"
     helpPanel 
   fi
 else
   helpPanel 
 fi 
# newbie
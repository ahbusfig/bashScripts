#!/bin/bash

#Pedir al user que introduzca su nombre
echo "¿Cual es tu nombre?"

# Leer el nombre que introduce el usuario
read nombre

#Mostrar saludo personalizado
echo "Hola, $nombre.¡Bienvenido!"

# Esperar 2 segundos antes de terminar el script
sleep 2

# Mensaje de despedida
echo "Adiós, $nombre."
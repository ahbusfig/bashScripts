#!/bin/bash

function crtl_c(){
	echo -e "\n [!] Saliendo... \n"
	exit 1
}

#crtl_c
trap ctrl_c INT

for port in $(seq 1 65535); do
	echo "[+] Estamos en el puerto $port"

done 

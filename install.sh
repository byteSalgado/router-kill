
clear

if [[ $EUID -ne 0 ]]; then	
	echo "														         "
	echo " 			(✗) No eres usuario root, para ejecutar la heramienta tienes que ejecutarla siendo root (✗)      "				  
	echo "				(✗) You are not a root user, to run the tool you have to run it as root (✗)              "		
        	exit 1
fi


if which airodump-ng >/dev/null; then
		sleep 0.25
         echo -e "$blue(AIRODUMP-NG)$nc .................................................. Instalado [$green✓$nc]"
else
		sleep 0.25
	 echo -e "$red(AIRODUMP-NG)$nc No instalado [$red✗$nc]"
			sleep 1
#instalación mensaje
apt-get install airckrack-ng
fi


if which mdk3 >/dev/null; then
		sleep 0.25
         echo -e "$blue(MDK3)$nc ......................................................... Instalado [$green✓$nc]"
		sleep 0.25
else
		sleep 0.25
	 echo -e "$red(MDK3)$nc  No instalado [$red✗$nc]"
			sleep 1
	 apt-get install mdk3
		
fi

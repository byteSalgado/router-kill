# router-kill

Herramienta bash para hacer ataques a un router


## Tipos de Ataques

| Ataque        |   Informacion                                 |
|---------------|-----------------------------------------------| 
| Deauth:       | Desauntentica todos los clientes de la red    |
| Auth          | Solicita y manda solicitudes falsas de Auth   |
| Fake AP       | Crea un flood de Falsos puntos de acceso      |
| Inject packet | Autentica un falso cliente y Inyecta paquetes |

## Distribuciones compatibles con Router-kill:

| Distribución |   Estado      |
|--------------|---------------| 
| Kali Linux   | Compatible    |
| Ubuntu       | Compatible    |
| Xbuntu       | Compatible    |
| Debian       | Compatible    |
| Parrot OS    | Compatible    |

# Dependencias:

* Aircrack-ng
* mdk3
* Macchanger
* toilet

# Instalacion:

* git clone https://github.com/byteSalgado/router-kill/
* cd router-kill
* chmod +x install.sh
* ./install.sh

# Creditos:

* Facu Salgado (ByteSalgado)
* Regalanos una estrella en el repositorio, gracias.
* Creditos por parte del codigo;
* (hacking.con.h) https://github.com/hackingconh

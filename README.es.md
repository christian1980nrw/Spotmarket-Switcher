<p align="center" width="100%">
    <img width="33%" src="https://github.com/christian1980nrw/Spotmarket-Switcher/blob/main/SpotmarketSwitcherLogo.png?raw=true"> 
</p>

[checo](README.cs.md)-[danés](README.da.md)-[Alemán](README.de.md)-[Inglés](README.md)-[Español](README.es.md)-[estonio](README.et.md)-[finlandés](README.fi.md)-[Francés](README.fr.md)-[Griego](README.el.md)-[italiano](README.it.md)-[Holandés](README.nl.md)-[noruego](README.no.md)-[Polaco](README.pl.md)-[portugués](README.pt.md)-[sueco](README.sv.md)-[japonés](README.ja.md)

## ¡Bienvenido al repositorio de Spotmarket-Switcher!

¿Qué está haciendo este software?
Este es un script de shell de Linux y enciende el cargador de batería y/o los enchufes conmutables en el momento adecuado si los precios dinámicos de energía por horas son bajos.
Luego puede usar los enchufes para encender un tanque de agua caliente de manera mucho más económica o puede cargar automáticamente la batería por la noche cuando hay energía eólica barata disponible en la red.
El rendimiento solar esperado se puede tener en cuenta mediante una API meteorológica y reservar el almacenamiento de la batería en consecuencia.
Los sistemas compatibles actualmente son:

-   Productos Shelly (como[Tapón Shelly S](https://shellyparts.de/products/shelly-plus-plug-s)o[Shelly Plus](https://shellyparts.de/products/shelly-plus-1pm))
-   [AVMFritz!DECT200](https://avm.de/produkte/smart-home/fritzdect-200/)y[210](https://avm.de/produkte/smart-home/fritzdect-210/)enchufes conmutables
-   [victron](https://www.victronenergy.com/)Sistemas de almacenamiento de energía Venus OS como el[Serie MultiPlus-II](https://www.victronenergy.com/inverters-chargers)

El código es simple, por lo que puede adaptarse fácilmente a otros sistemas de almacenamiento de energía si puede controlar la carga mediante comandos de shell de Linux.
Eche un vistazo a la línea 965 del controlador.sh (charger_command_turnon) para que pueda ver lo fácil que se puede adaptar.
Cree una bifurcación de github y comparta su personalización para que otros usuarios puedan beneficiarse de ella.

## Fuente de datos

Actualmente, el software utiliza precios por hora EPEX Spot proporcionados por tres API gratuitas (Tibber, aWATTar y Entso-E).
La API Entso-E gratuita integrada proporciona datos sobre precios de energía de los siguientes países:
Albania (AL), Austria (AT), Bélgica (BE), Bosnia y Herz. (BA), Bulgaria (BG), Croacia (HR), Chipre (CY), República Checa (CZ), Dinamarca (DK), Estonia (EE), Finlandia (FI), Francia (FR), Georgia (GE), Alemania (DE), Grecia (GR), Hungría (HU), Irlanda (IE), Italia (IT), Kosovo (XK), Letonia (LV), Lituania (LT), Luxemburgo (LU), Malta (MT), Moldavia (MD), Montenegro (ME), Países Bajos (NL), Macedonia del Norte (MK), Noruega (NO), Polonia (PL), Portugal (PT), Rumania (RO), Serbia (RS), Eslovaquia (SK) , Eslovenia (SI), España (ES), Suecia (SE), Suiza (CH), Turquía (TR), Ucrania (UA), Reino Unido (UK) ver[Plataforma Transparencia Entso-E](https://transparency.entsoe.eu/transmission-domain/r2/dayAheadPrices/show).

![grafik](https://user-images.githubusercontent.com/6513794/224442951-c0155a48-f32b-43f4-8014-d86d60c3b311.png)

## Instalación

Configurar Spotmarket-Switcher es un proceso sencillo. Si ya está ejecutando una máquina basada en UNIX, como macOS, Linux o Windows con el subsistema Linux, siga estos pasos para instalar el software:

1.  Descargue el script de instalación desde el repositorio de GitHub usando[este hipervínculo](https://raw.githubusercontent.com/christian1980nrw/Spotmarket-Switcher/main/victron-venus-os-install.sh), o ejecute el siguiente comando en su terminal:
        wget https://raw.githubusercontent.com/christian1980nrw/Spotmarket-Switcher/main/victron-venus-os-install.sh

2.  Ejecute el script del instalador con opciones adicionales para preparar todo en un subdirectorio para su inspección. Por ejemplo:
        DESTDIR=/tmp/foo sh victron-venus-os-install.sh
    Si utiliza Victron Venus OS, el DESTDIR correcto debería ser`/`(el directorio raíz). Siéntase libre de explorar los archivos instalados en`/tmp/foo`.
    En un Cerbo GX, el sistema de archivos está montado en solo lectura. Ver<https://www.victronenergy.com/live/ccgx:root_access>. Para que se pueda escribir en el sistema de archivos, debe ejecutar el siguiente comando antes de ejecutar el script de instalación:
        /opt/victronenergy/swupdate-scripts/resize2fs.sh

Tenga en cuenta que, si bien este software está actualmente optimizado para el sistema operativo Venus, se puede adaptar a otras versiones de Linux, como Debian/Ubuntu en una Raspberry Pi u otra placa pequeña. Un candidato principal es sin duda[AbiertoWRT](https://www.openwrt.org). Usar una máquina de escritorio está bien para fines de prueba, pero cuando se usa las 24 horas del día, los 7 días de la semana, su mayor consumo de energía es motivo de preocupación.

### Acceso al sistema operativo Venus

Para obtener instrucciones sobre cómo acceder al sistema operativo Venus, consulte<https://www.victronenergy.com/live/ccgx:root_access>.

### Ejecución del script de instalación

-   Si está utilizando el sistema operativo Victron Venus:
    -   Luego edite las variables con un editor de texto en`/data/etc/Spotmarket-Switcher/config.txt`.
    -   Configure un programa de carga de ESS (consulte la captura de pantalla proporcionada). En el ejemplo, la batería se carga por la noche hasta un 50% si está activada; se ignoran otros momentos de carga del día. Si no lo desea, cree un horario para las 24 horas del día. Recuerda desactivarlo después de la creación. Verifique que la hora del sistema (como se muestra en la parte superior derecha de la pantalla) sea precisa.![grafik](https://user-images.githubusercontent.com/6513794/206877184-b8bf0752-b5d5-4c1b-af15-800b6499cfc7.png)

La captura de pantalla muestra la configuración de la carga automatizada durante los horarios definidos por el usuario. Desactivado de forma predeterminada, puede activarse temporalmente mediante el script.

-   Instrucciones para instalar Spotmarket-Switcher en un sistema Windows 10 u 11 para realizar pruebas sin dispositivos Victron (solo enchufes conmutables).

    -   launch `cmd.exe`como administrador
    -   Ingresar`wsl --install -d Debian`
    -   Ingrese un nuevo nombre de usuario como`admin`
    -   Introduzca una nueva contraseña
    -   Ingresar`sudo su`y escribe tu contraseña
    -   Ingresar`apt-get update && apt-get install wget curl`
    -   Continúe con la descripción del manual de Linux a continuación (el script del instalador no es compatible).
    -   No olvide que si cierra el shell, Windows detendrá el sistema.


-   Si está utilizando un sistema Linux como Ubuntu o Debian:
    -   Copie el script de shell (`controller.sh`) a una ubicación personalizada y ajuste las variables según sus necesidades.
    -   los comandos son`cd /path/to/save/ &&  curl -s -O "https://raw.githubusercontent.com/christian1980nrw/Spotmarket-Switcher/main/scripts/{controller.sh,sample.config.txt}" && mv sample.config.txt config.txt && chmod +x ./controller.sh`y para editar`vi /path/to/save/config.txt`
    -   Cree un crontab u otro método de programación para ejecutar este script al comienzo de cada hora.
    -   Crontab de muestra:
          Utilice la siguiente entrada de crontab para ejecutar el script de control cada hora:
          Abre tu terminal y entra`crontab -e`, luego inserte la siguiente línea:`0 * * * * /path/to/controller.sh`

### Apoyo y contribución:+1:

Si encuentra valioso este proyecto, considere patrocinar y apoyar un mayor desarrollo a través de estos enlaces:

-   [revolución](https://revolut.me/christqki2)
-   [PayPal](https://paypal.me/christian1980nrw)

Si eres de Alemania y estás interesado en cambiar a una tarifa eléctrica dinámica, puedes apoyar el proyecto registrándote usando este[Tibber (enlace de referencia)](https://invite.tibber.com/ojgfbx2e)o ingresando el código`ojgfbx2e`en tu aplicación. Tanto tú como el proyecto recibiréis**Bonificación de 50 euros por hardware**. Tenga en cuenta que se requiere un medidor inteligente o un Pulse-IR para una tarifa por hora (<https://tibber.com/de/store/produkt/pulse-ir>).
Si necesitas una tarifa de gas natural o prefieres una tarifa eléctrica clásica, aún puedes apoyar el proyecto[Octopus Energy (enlace de referencia)](https://share.octopusenergy.de/glass-raven-58).
Recibes un bono (la oferta varía**entre 50 y 120 euros**) para usted y también para el proyecto.
Octopus tiene la ventaja de que algunas ofertas no tienen un plazo mínimo de contrato. Son ideales, por ejemplo, para pausar una tarifa basada en los precios de bolsa.

Si eres de Austria, puedes apoyarnos usando[aWATTar Austria (enlace de referencia)](https://www.awattar.at/services/offers/promotecustomers). Por favor haz uso de`3KEHMQN2F`como código.

## Descargo de responsabilidad

Tenga en cuenta las condiciones de uso en<https://github.com/christian1980nrw/Spotmarket-Switcher/blob/main/License.md>

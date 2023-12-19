<p align="center" width="100%">
    <img width="33%" src="https://github.com/christian1980nrw/Spotmarket-Switcher/blob/main/SpotmarketSwitcherLogo.png?raw=true"> 
</p>

[checo](README.cs.md)-[danés](README.da.md)-[Alemán](README.de.md)-[Inglés](README.md)-[Español](README.es.md)-[estonio](README.et.md)-[finlandés](README.fi.md)-[Francés](README.fr.md)-[Griego](README.el.md)-[italiano](README.it.md)-[Holandés](README.nl.md)-[noruego](README.no.md)-[Polaco](README.pl.md)-[portugués](README.pt.md)-[sueco](README.sv.md)-[japonés](README.ja.md)

## ¡Bienvenido al repositorio de Spotmarket-Switcher!

¿Qué está haciendo este software?
Spotmarket-Switcher es una herramienta de software fácil de usar que le ayuda a ahorrar dinero en sus facturas de energía. Si tienes un cargador de batería inteligente o dispositivos como calentadores de agua que pueden encenderse y apagarse automáticamente, ¡esta herramienta es perfecta para ti! Enciende inteligentemente tus dispositivos cuando los precios de la energía son bajos, lo que es especialmente útil si tus costos de energía cambian cada hora.

Este resultado típico muestra la capacidad de Spotmarket-Switcher para automatizar el uso de energía de manera eficiente, no solo ahorrando costos sino también optimizando el uso de fuentes de energía renovables. Es un gran ejemplo de cómo se puede utilizar la tecnología inteligente para gestionar el consumo de energía de una manera más sostenible y rentable. (azul = uso de batería, rojo = red, amarillo = solar)

<p align="center" width="100%">
    <img width="50%" src="https://github.com/christian1980nrw/Spotmarket-Switcher/blob/main/Screenshot.jpg?raw=true"> 
</p>

-   Uso nocturno: Durante la noche, cuando los precios de la energía estaban en su punto más bajo, Spotmarket-Switcher activó inteligentemente un enchufe conmutable para encender la bomba de calor de agua caliente (el pico se indica en rojo). Esto muestra la capacidad del sistema para identificar y utilizar períodos de energía de bajo costo para tareas que consumen mucha energía.
-   Eficiencia económica en la carga de baterías: El programa decidió estratégicamente no cargar el almacenamiento de baterías en este momento. Esta decisión se basó en un control económico que tuvo en cuenta las pérdidas de carga y las comparó con los precios de energía promedio o más altos del día. Este enfoque garantiza que la carga de la batería se produzca sólo cuando sea más rentable.
-   Uso óptimo de la batería en horas pico: En este día, las horas más caras de energía eran la mañana y la tarde. Durante estos períodos, Spotmarket-Switcher utilizó la energía almacenada en la batería (que se muestra en azul), evitando así altos costos de electricidad.
-   Reserva de batería para horas de alto costo: después de los períodos de alto costo, el sistema de almacenamiento de energía (ESS) de la batería estaba apagado. Por la tarde, alrededor de las 20:00, no estaba vacío. Esta medida se tomó para reservar suficiente capacidad de la batería para las próximas y costosas horas de la mañana siguiente. Es un enfoque con visión de futuro que anticipa períodos futuros de altos costos y garantiza que la energía almacenada esté disponible para compensar estos costos.

¿Por qué utilizar Spotmarket-Switcher?

-   Ahorre dinero: enciende sus dispositivos cuando la energía es más barata, lo que reduce sus facturas.
-   Eficiencia energética: al utilizar energía cuando sobra (como en las noches con viento), contribuyes a un planeta más verde.
-   Uso inteligente: cargue automáticamente la batería de almacenamiento o encienda dispositivos como calentadores de agua en los mejores momentos.

Los sistemas compatibles actualmente son:

-   Productos Shelly (como[Tapón Shelly S](https://shellyparts.de/products/shelly-plus-plug-s)o[Shelly Plus](https://shellyparts.de/products/shelly-plus-1pm))
-   [AVMFritz!DECT200](https://avm.de/produkte/smart-home/fritzdect-200/)y[210](https://avm.de/produkte/smart-home/fritzdect-210/)enchufes conmutables
-   [victron](https://www.victronenergy.com/)Sistemas de almacenamiento de energía Venus OS como el[Serie MultiPlus-II](https://www.victronenergy.com/inverters-chargers)

Empezando:

-   Descargar e instalar: el proceso de configuración es sencillo. Descargue el script, ajuste algunas configuraciones y estará listo para comenzar.
-   Programe y relájese: configúrelo una vez y se ejecutará automáticamente. ¡Sin problemas diarios!

¿Interesado?

-   Consulte nuestras instrucciones detalladas para diferentes sistemas como Victron Venus OS, Windows o configuraciones de Linux. Nos hemos asegurado de que los pasos sean fáciles de seguir.
-   ¡Únase a nosotros para hacer que el uso de la energía sea más inteligente y rentable! Para cualquier pregunta, sugerencia o comentario, no dude en comunicarse.

El código es simple, por lo que puede adaptarse fácilmente a otros sistemas de almacenamiento de energía si puede controlar la carga mediante comandos de shell de Linux.
Eche un vistazo a controlador.sh y busque cargador_command_turnon para que pueda ver lo fácil que se puede adaptar.
Cree una bifurcación de github y comparta su personalización para que otros usuarios puedan beneficiarse de ella.

## Fuente de datos

Actualmente, el software utiliza precios por hora EPEX Spot proporcionados por tres API gratuitas (Tibber, aWATTar y Entso-E).
La API Entso-E gratuita integrada proporciona datos sobre precios de energía de los siguientes países:
Albania (AL), Austria (AT), Bélgica (BE), Bosnia y Herz. (BA), Bulgaria (BG), Croacia (HR), Chipre (CY), República Checa (CZ), Dinamarca (DK), Estonia (EE), Finlandia (FI), Francia (FR), Georgia (GE), Alemania (DE), Grecia (GR), Hungría (HU), Irlanda (IE), Italia (IT), Kosovo (XK), Letonia (LV), Lituania (LT), Luxemburgo (LU), Malta (MT), Moldavia (MD), Montenegro (ME), Países Bajos (NL), Macedonia del Norte (MK), Noruega (NO), Polonia (PL), Portugal (PT), Rumania (RO), Serbia (RS), Eslovaquia (SK) , Eslovenia (SI), España (ES), Suecia (SE), Suiza (CH), Turquía (TR), Ucrania (UA), Reino Unido (UK) ver[Plataforma Transparencia Entso-E](https://transparency.entsoe.eu/transmission-domain/r2/dayAheadPrices/show).

![Screenshot 2023-12-15 221401](https://github.com/christian1980nrw/Spotmarket-Switcher/assets/6513794/25992602-b0a2-48ff-bd4c-64a6f8182297)

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

    -   lanzamiento`cmd.exe`como administrador
    -   Ingresar`wsl --install -d Debian`
    -   Ingrese un nuevo nombre de usuario como`admin`
    -   Introduzca una nueva contraseña
    -   Ingresar`sudo su`y escribe tu contraseña
    -   Ingresar`apt-get update && apt-get install wget curl`
    -   Continúe con la descripción del manual de Linux a continuación (el script del instalador no es compatible).
    -   No olvide que si cierra el shell, Windows detendrá el sistema.


-   Si está utilizando un sistema Linux como Ubuntu o Debian:
    -   Copie el script de shell (`controller.sh`) a una ubicación personalizada y ajuste las variables según sus necesidades.
    -   los comandos son`cd /path/to/save/ && curl -s -O "https://raw.githubusercontent.com/christian1980nrw/Spotmarket-Switcher/main/scripts/{controller.sh,sample.config.txt,license.txt}" && chmod +x ./controller.sh && mv sample.config.txt config.txt`y para editar su configuración use`vi /path/to/save/config.txt`
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

Si eres de Austria, puedes apoyarnos utilizando[aWATTar Austria (enlace de referencia)](https://www.awattar.at/services/offers/promotecustomers). Por favor haz uso de`3KEHMQN2F`como código.

## Descargo de responsabilidad

Tenga en cuenta las condiciones de uso en<https://github.com/christian1980nrw/Spotmarket-Switcher/blob/main/License.md>

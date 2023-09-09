<p align="center" width="100%">
    <img width="33%" src="https://github.com/christian1980nrw/Spotmarket-Switcher/blob/main/SpotmarketSwitcherLogo.png?raw=true"> 
</p>

[danese](README.da.md)-[Tedesco](README.de.md)-[Olandese](README.nl.md)-[Inglese](README.md)-[spagnolo](README.es.md)-[Estone](README.et.md)-[finlandese](README.fi.md)-[Francese](README.fr.md)-[greco](README.el.md)-[Italiano](README.it.md)-[norvegese](README.no.md)-[portoghese](README.pt.md)-[svedese](README.sv.md)

## Benvenuti nel repository Spotmarket-Switcher!

Cosa sta facendo questo software?
Questo è uno script della shell Linux che accende il caricabatterie e/o le prese commutabili al momento giusto se i prezzi dinamici dell'energia su base oraria sono bassi.
È quindi possibile utilizzare le prese per accendere un serbatoio dell'acqua calda in modo molto più economico oppure caricare automaticamente la batteria di accumulo di notte quando è disponibile energia eolica a basso costo sulla rete.
Il rendimento solare previsto può essere preso in considerazione tramite un'API meteorologica e l'accumulo della batteria riservato di conseguenza.
I sistemi supportati sono attualmente:

-   Prodotti Shelly (come[Shelly Spina S](https://shellyparts.de/products/shelly-plus-plug-s)O[Shelly Plus](https://shellyparts.de/products/shelly-plus-1pm))
-   [AVMFritz!DECT200](https://avm.de/produkte/smart-home/fritzdect-200/)E[210](https://avm.de/produkte/smart-home/fritzdect-210/)prese commutabili
-   [Victron](https://www.victronenergy.com/)I sistemi di accumulo di energia Venus OS come il[Serie MultiPlus-II](https://www.victronenergy.com/inverters-chargers)

Il codice è semplice in modo che possa essere facilmente adattato ad altri sistemi di accumulo di energia se si è in grado di controllare la ricarica tramite i comandi della shell Linux.
Dai un'occhiata sotto la riga 100 del file controller.sh in modo da poter vedere cosa può essere configurato dall'utente.

## Fonte di dati

Il software attualmente utilizza i prezzi orari EPEX Spot forniti da tre API gratuite (Tibber, aWATTar ed Entso-E).
L'API Entso-E gratuita integrata fornisce dati sui prezzi dell'energia dei seguenti paesi:
Albania (AL), Austria (AT), Belgio (BE), Bosnia ed Herz. (BA), Bulgaria (BG), Croazia (HR), Cipro (CY), Repubblica Ceca (CZ), Danimarca (DK), Estonia (EE), Finlandia (FI), Francia (FR), Georgia (GE), Germania (DE), Grecia (GR), Ungheria (HU), Irlanda (IE), Italia (IT), Kosovo (XK), Lettonia (LV), Lituania (LT), Lussemburgo (LU), Malta (MT), Moldavia (MD), Montenegro (ME), Paesi Bassi (NL), Macedonia del Nord (MK), Norvegia (NO), Polonia (PL), Portogallo (PT), Romania (RO), Serbia (RS), Slovacchia (SK) , Slovenia (SI), Spagna (ES), Svezia (SE), Svizzera (CH), Turchia (TR), Ucraina (UA), Regno Unito (UK) vedi[Piattaforma per la trasparenza Entso-E](https://transparency.entsoe.eu/transmission-domain/r2/dayAheadPrices/show).

![grafik](https://user-images.githubusercontent.com/6513794/224442951-c0155a48-f32b-43f4-8014-d86d60c3b311.png)

## Installazione

La configurazione di Spotmarket-Switcher è un processo semplice. Se stai già utilizzando un computer basato su UNIX, come macOS, Linux o Windows con il sottosistema Linux, segui questi passaggi per installare il software:

1.  Scaricare lo script di installazione dal repository GitHub utilizzando[questo collegamento ipertestuale](https://raw.githubusercontent.com/christian1980nrw/Spotmarket-Switcher/main/victron-venus-os-install.sh)oppure esegui il seguente comando nel tuo terminale:
        wget https://raw.githubusercontent.com/christian1980nrw/Spotmarket-Switcher/main/victron-venus-os-install.sh

2.  Esegui lo script di installazione con opzioni aggiuntive per preparare tutto in una sottodirectory per l'ispezione. Per esempio:
        DESTDIR=/tmp/foo sh victron-venus-os-install.sh
    Se utilizzi il sistema operativo Victron Venus, la DESTDIR corretta dovrebbe essere`/`(la directory principale). Sentiti libero di esplorare i file installati in`/tmp/foo`.

Tieni presente che sebbene questo software sia attualmente ottimizzato per il sistema operativo Venus, può essere adattato ad altre versioni Linux, come Debian/Ubuntu su un Raspberry Pi o un'altra piccola scheda. Un ottimo candidato lo è certamente[OpenWRT](https://www.openwrt.org). L'uso di una macchina desktop va bene a scopo di test, ma quando viene utilizzato 24 ore su 24, 7 giorni su 7, il suo consumo energetico maggiore è preoccupante.

### Accesso al sistema operativo Venus

Per istruzioni sull'accesso al sistema operativo Venus, fare riferimento a<https://www.victronenergy.com/live/ccgx:root_access>.

### Esecuzione dello script di installazione

-   Se utilizzi il sistema operativo Victron Venus:
    -   Dopo l'esecuzione del`victron-venus-os-install.sh`, modificare le variabili con un editor di testo in`/data/etc/Spotmarket-Switcher/controller.sh`.
    -   Configurare un programma di addebito ESS (fare riferimento allo screenshot fornito). Nell'esempio la batteria si ricarica di notte fino al 50% se attivata, gli altri tempi di ricarica della giornata vengono ignorati. Se non lo desideri, crea una pianificazione per tutte le 24 ore del giorno. Ricordati di disattivarlo dopo la creazione. Verificare che l'ora del sistema (come mostrato nell'angolo in alto a destra dello schermo) sia accurata.![grafik](https://user-images.githubusercontent.com/6513794/206877184-b8bf0752-b5d5-4c1b-af15-800b6499cfc7.png)

Lo screenshot mostra la configurazione della ricarica automatizzata durante gli orari definiti dall'utente. Disattivato per impostazione predefinita, può essere temporaneamente attivato dallo script.

-   Se utilizzi un altro sistema operativo:
    -   Copia lo script della shell (`controller.sh`) in una posizione personalizzata e regolare le variabili in base alle proprie esigenze.
    -   Crea un crontab o un altro metodo di pianificazione per eseguire questo script all'inizio di ogni ora.
    -   Crontab di esempio:
          Utilizza la seguente voce crontab per eseguire lo script di controllo ogni ora:
          Apri il tuo terminale ed entra`crontab -e`, quindi inserisci la seguente riga:
            0 * * * * /path/to/controller.sh

### Supporto e contributo

Se ritieni utile questo progetto, considera la possibilità di sponsorizzare e supportare l'ulteriore sviluppo attraverso questi collegamenti:

-   [Rivoluzione](https://revolut.me/christqki2)
-   [PayPal](https://paypal.me/christian1980nrw)

Inoltre, se ti trovi in ​​Germania e sei interessato a passare a una tariffa elettrica dinamica, puoi sostenere il progetto iscrivendoti utilizzando questo[Tibber (link di riferimento)](https://invite.tibber.com/ojgfbx2e). Sia tu che il progetto riceverete un bonus di 50 euro per l'hardware. Si prega di notare che per una tariffa oraria è necessario un contatore intelligente o un Pulse-IR (<https://tibber.com/de/store/produkt/pulse-ir>) .

Se hai bisogno di una tariffa per il gas naturale o preferisci una tariffa elettrica classica, puoi comunque sostenere il progetto[Octopus Energy (link di riferimento)](https://share.octopusenergy.de/glass-raven-58).
Ricevi un bonus di 50 euro per te e anche per il progetto.
Octopus ha il vantaggio che i contratti hanno solitamente solo una durata mensile. Sono ideali, ad esempio, per sospendere una tariffa basata sui prezzi di borsa.

## Disclaimer

Si prega di notare i termini di utilizzo su<https://github.com/christian1980nrw/Spotmarket-Switcher/blob/main/License.md>

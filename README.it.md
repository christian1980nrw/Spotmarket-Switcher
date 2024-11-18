<p align="center" width="100%">
    <img width="33%" src="https://github.com/christian1980nrw/Spotmarket-Switcher/blob/main/SpotmarketSwitcherLogo.png?raw=true"> 
</p>

[ceco](README.cs.md)-[danese](README.da.md)-[tedesco](README.de.md)-[Inglese](README.md)-[spagnolo](README.es.md)-[Estone](README.et.md)-[finlandese](README.fi.md) - [francese](README.fr.md)-[greco](README.el.md)-[Italiano](README.it.md)-[Olandese](README.nl.md)-[norvegese](README.no.md)-[Polacco](README.pl.md)-[portoghese](README.pt.md)-[svedese](README.sv.md)-[giapponese](README.ja.md)

## Benvenuti nel repository Spotmarket-Switcher!

Cosa sta facendo questo software? 
Spotmarket-Switcher è uno strumento software facile da usare che ti aiuta a risparmiare denaro sulle bollette energetiche. Se disponi di un caricabatterie intelligente o di dispositivi come gli scaldabagni che possono accendersi e spegnersi automaticamente, questo strumento è perfetto per te! Accende in modo intelligente i tuoi dispositivi quando i prezzi dell'energia sono bassi, particolarmente utile se i costi energetici cambiano ogni ora.

Questo risultato tipico dimostra la capacità di Spotmarket-Switcher di automatizzare l'utilizzo dell'energia in modo efficiente, non solo risparmiando sui costi ma anche ottimizzando l'uso delle fonti di energia rinnovabile. È un ottimo esempio di come la tecnologia intelligente possa essere utilizzata per gestire il consumo energetico in modo più sostenibile ed economicamente vantaggioso. (blu = utilizzo della batteria, rosso = rete, giallo = solare)

<p align="center" width="100%">
    <img width="50%" src="https://github.com/christian1980nrw/Spotmarket-Switcher/blob/main/Screenshot.jpg?raw=true"> 
</p>

-   Utilizzo notturno: durante la notte, quando i prezzi dell'energia erano al minimo, lo Spotmarket-Switcher ha attivato in modo intelligente una presa commutabile per alimentare la pompa di calore dell'acqua calda (picco indicato in rosso). Ciò dimostra la capacità del sistema di identificare e utilizzare periodi energetici a basso costo per attività ad alto consumo energetico.
-   Efficienza economica nella ricarica della batteria: il programma ha deciso strategicamente di non caricare la batteria durante questo periodo. Questa decisione si è basata su un controllo economico che ha tenuto conto delle perdite di tariffazione e le ha confrontate con i prezzi medi o più alti dell'energia del giorno. Questo approccio garantisce che la ricarica della batteria avvenga solo quando è più conveniente.
-   Utilizzo ottimale della batteria durante le ore di punta: al giorno d'oggi, le ore più costose dal punto di vista energetico erano la mattina e la sera. Durante questi periodi, lo Spotmarket-Switcher utilizzava l'energia immagazzinata nella batteria (mostrata in blu), evitando così elevati costi dell'elettricità.
-   Prenotazione della batteria per ore a costo elevato: dopo aver registrato i periodi a costo elevato, il sistema di accumulo dell'energia (ESS) della batteria è stato disattivato. Non era vuoto la sera intorno alle 20:00. Questa azione è stata intrapresa per riservare una capacità della batteria sufficiente per le prossime ore costose del mattino successivo. Ciò anticipa futuri periodi di costi elevati e garantisce che l’energia immagazzinata sia disponibile per ridurre al minimo i costi.

Perché utilizzare Spotmarket-Switcher?

-   Risparmia denaro: accende i tuoi dispositivi quando l'energia costa meno, riducendo le bollette.
-   Risparmia denaro: usa l'energia solare immagazzinata ai prezzi più alti.
-   Efficienza energetica: utilizzando l'energia quando è in surplus (come nelle notti ventose), contribuisci a un pianeta più verde.
-   Utilizzo intelligente: carica automaticamente la batteria o accendi dispositivi come gli scaldabagni nei momenti migliori.

I sistemi supportati sono attualmente:

-   Prodotti Shelly (come[Shelly Spina S](https://shellyparts.de/products/shelly-plus-plug-s)O[Shelly Plus](https://shellyparts.de/products/shelly-plus-1pm))
-   [AVMFritz!DECT200](https://avm.de/produkte/smart-home/fritzdect-200/)E[210](https://avm.de/produkte/smart-home/fritzdect-210/)prese commutabili
-   [Victron](https://www.victronenergy.com/)I sistemi di accumulo di energia Venus OS come il[Serie MultiPlus-II](https://www.victronenergy.com/inverters-chargers)(Dbus su localhost e MQTT su LAN sono supportati)
-   [figlio](https://www.sonnen.de/)Sistemi AC-AC come[batteria del sole 10](https://sonnen.de/stromspeicher/sonnenbatterie-10/). Testato con la versione software 1.15.6 su LAN su un sistema autonomo senza SonnenCommunity o sonnenVPP.
-   [altro caricabatterie MQTT](http://www.steves-internet-guide.com/mosquitto_pub-sub-clients/)(caricabatterie controllabili tramite comandi Mosquitto MQTT)

Iniziare:

-   Download e installazione: il processo di installazione è semplice. Scarica lo script, regola alcune impostazioni e sei pronto per partire.
-   Pianifica e rilassati: configuralo una volta e verrà eseguito automaticamente. Nessun problema quotidiano!

Interessato?

-   Consulta le nostre istruzioni dettagliate per diversi sistemi come le configurazioni del sistema operativo Victron Venus, Windows o Linux. Ci siamo assicurati che i passaggi siano facili da seguire.
-   Unisciti a noi per rendere l’uso dell’energia più intelligente ed economico! Per qualsiasi domanda, suggerimento o feedback, non esitate a contattarci.

Il codice è semplice in modo che possa essere facilmente adattato ad altri sistemi di accumulo di energia se si è in grado di controllare la ricarica tramite i comandi della shell Linux.
Dai un'occhiata a controller.sh e cerca charger_command_turnon in modo da poter vedere quanto è facile adattarlo.
Crea un fork github e condividi la tua personalizzazione in modo che altri utenti possano trarne vantaggio.

## Origine dati

Il software attualmente utilizza i prezzi orari EPEX Spot forniti da tre API gratuite (Tibber, aWATTar ed Entso-E).
L'API Entso-E gratuita integrata fornisce dati sui prezzi dell'energia dei seguenti paesi:
Albania (AL), Austria (AT), Belgio (BE), Bosnia ed Herz. (BA), Bulgaria (BG), Croazia (HR), Cipro (CY), Repubblica Ceca (CZ), Danimarca (DK), Estonia (EE), Finlandia (FI), Francia (FR), Georgia (GE), Germania (DE), Grecia (GR), Ungheria (HU), Irlanda (IE), Italia (IT), Kosovo (XK), Lettonia (LV), Lituania (LT), Lussemburgo (LU), Malta (MT), Moldavia (MD), Montenegro (ME), Paesi Bassi (NL), Macedonia del Nord (MK), Norvegia (NO), Polonia (PL), Portogallo (PT), Romania (RO), Serbia (RS), Slovacchia (SK) , Slovenia (SI), Spagna (ES), Svezia (SE), Svizzera (CH), Turchia (TR), Ucraina (UA), Regno Unito (UK) vedi[Transparency Entso-E Platform](https://transparency.entsoe.eu/transmission-domain/r2/dayAheadPrices/show).

![Screenshot 2023-12-15 221401](https://github.com/christian1980nrw/Spotmarket-Switcher/assets/6513794/25992602-b0a2-48ff-bd4c-64a6f8182297)Un registro più dettagliato può essere visualizzato con il seguente comando nella shell:

     cd /data/etc/Spotmarket-Switcher
     DEBUG=1 bash ./controller.sh

## Installazione

La configurazione di Spotmarket-Switcher è un processo semplice. Se stai già utilizzando un computer basato su UNIX, come macOS, Linux o Windows con il sottosistema Linux, segui questi passaggi per installare il software:

1.  Scaricare lo script di installazione dal repository GitHub utilizzando[questo collegamento ipertestuale](https://raw.githubusercontent.com/christian1980nrw/Spotmarket-Switcher/main/victron-venus-os-install.sh)oppure esegui il seguente comando nel tuo terminale:
        wget https://raw.githubusercontent.com/christian1980nrw/Spotmarket-Switcher/main/victron-venus-os-install.sh

2.  Esegui lo script di installazione con opzioni aggiuntive per preparare tutto in una sottodirectory per l'ispezione. Per esempio:
        DESTDIR=/tmp/foo sh victron-venus-os-install.sh
    Se utilizzi il sistema operativo Victron Venus, la DESTDIR corretta dovrebbe essere`/`(la directory principale). Sentiti libero di esplorare i file installati in`/tmp/foo`.
    Su un Cerbo GX il filesystem è montato in sola lettura. Vedere<https://www.victronenergy.com/live/ccgx:root_access>. Per rendere scrivibile il filesystem è necessario eseguire il seguente comando prima di eseguire lo script di installazione:
        /opt/victronenergy/swupdate-scripts/resize2fs.sh

Tieni presente che sebbene questo software sia attualmente ottimizzato per il sistema operativo Venus, può essere adattato ad altre versioni Linux, come Debian/Ubuntu su un Raspberry Pi o un'altra piccola scheda. Un ottimo candidato lo è certamente[OpenWRT](https://www.openwrt.org). L'uso di una macchina desktop va bene a scopo di test, ma quando viene utilizzato 24 ore su 24, 7 giorni su 7, il suo consumo energetico maggiore è preoccupante.

### Accesso al sistema operativo Venus

Per istruzioni sull'accesso al sistema operativo Venus, fare riferimento a<https://www.victronenergy.com/live/ccgx:root_access>.

### Esecuzione dello script di installazione

-   Se utilizzi il sistema operativo Victron Venus:
    -   Quindi modifica le variabili con un editor di testo in`/data/etc/Spotmarket-Switcher/config.txt`.
    -   Configurare un programma di addebito ESS (fare riferimento allo screenshot fornito). Nell'esempio la batteria si ricarica di notte fino al 50% se attivata, gli altri tempi di ricarica della giornata vengono ignorati. Se non lo desideri, crea una pianificazione per tutte le 24 ore del giorno. Ricordati di disattivarlo dopo la creazione. Verificare che l'ora del sistema (come mostrato nell'angolo in alto a destra dello schermo) sia accurata.![grafik](https://user-images.githubusercontent.com/6513794/206877184-b8bf0752-b5d5-4c1b-af15-800b6499cfc7.png)

Lo screenshot mostra la configurazione della ricarica automatizzata durante gli orari definiti dall'utente. Disattivato per impostazione predefinita, può essere temporaneamente attivato dallo script.

-   Istruzioni per installare lo Spotmarket-Switcher su un sistema Windows 10 o 11 per eseguire test senza dispositivi Victron (solo prese commutabili).

    -   lancio`cmd.exe`come amministratore
    -   Entra`wsl --install -d Debian`
    -   Inserisci un nuovo nome utente come`admin`
    -   Inserisci una nuova password
    -   Entra`sudo su`e digita la tua password
    -   Entra`apt-get update && apt-get install wget curl`
    -   Continuare con la descrizione manuale di Linux riportata di seguito (lo script di installazione non è compatibile).
    -   Non dimenticare che se chiudi la shell, Windows arresterà il sistema.


-   Se utilizzi un sistema Linux come Ubuntu o Debian:
    -   Copia lo script della shell (`controller.sh`) in una posizione personalizzata e regolare le variabili in base alle proprie esigenze.
    -   i comandi sono`cd /path/to/save/ && curl -s -O "https://raw.githubusercontent.com/christian1980nrw/Spotmarket-Switcher/main/scripts/{controller.sh,sample.config.txt,license.txt}" && chmod +x ./controller.sh && mv sample.config.txt config.txt`e per modificare le impostazioni utilizzare`vi /path/to/save/config.txt`
    -   Crea un crontab o un altro metodo di pianificazione per eseguire questo script all'inizio di ogni ora.
    -   Crontab di esempio:
          Utilizza la seguente voce crontab per eseguire lo script di controllo ogni ora:
          Apri il tuo terminale ed entra`crontab -e`, quindi inserisci la seguente riga:`0 * * * * /path/to/controller.sh`

### Supporto e contributo :+1:

Se ritieni utile questo progetto, considera la possibilità di sponsorizzare e supportare l'ulteriore sviluppo attraverso questi collegamenti:

-   [Rivoluzione](https://revolut.me/christqki2)
-   [PayPal](https://paypal.me/christian1980nrw)

Se vieni dalla Germania e sei interessato a passare a una tariffa elettrica dinamica, puoi sostenere il progetto iscrivendoti utilizzando questo[Tibber (link di riferimento)](https://invite.tibber.com/ojgfbx2e)oppure inserendo il codice`ojgfbx2e`nella tua app. Riceverete sia tu che il progetto**Bonus di 50 euro per l'hardware**. Si prega di notare che per una tariffa oraria è necessario un contatore intelligente o un Pulse-IR (<https://tibber.com/de/store/produkt/pulse-ir>).
Se hai bisogno di una tariffa per il gas naturale o preferisci una tariffa elettrica classica, puoi comunque sostenere il progetto[Octopus Energy (link di riferimento)](https://share.octopusenergy.de/glass-raven-58).
Ricevi un bonus (l'offerta varia**tra 50 e 120 euro**) per te stesso e anche per il progetto.
Octopus ha il vantaggio che alcune offerte non hanno una durata minima contrattuale. Sono ideali, ad esempio, per sospendere una tariffa basata sui prezzi di borsa.

Se vieni dall'Austria puoi sostenerci utilizzando[aWATTar Austria (link di riferimento)](https://www.awattar.at/services/offers/promotecustomers). Si prega di utilizzare`3KEHMQN2F`come codice.

## Disclaimer

Please note the terms of use at <https://github.com/christian1980nrw/Spotmarket-Switcher/blob/main/License.md>
